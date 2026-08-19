# MuSiC deconvolution analysis of CD49f(hi)CD200- "cTECs" using our 10x flex
# scRNAseq dataset's annotated cell types as reference to determine whether
# these cells are really cTECs or some other cell type

library(MuSiC) 
library(readr) 
library(Biobase) 
library(SingleCellExperiment) 
library(Seurat)
library(tidyverse)
library(biomaRt)
library(cowplot)

# =============================================================================
# load bulk rnaseq raw count into ExpressionSet object
# =============================================================================
# read in tsv count matrix into data frame
bulk_counts <- read_tsv("cd49f_ctec_analysis/counts/all.tsv")
# add column of sum ctec and mtec gene counts
bulk_counts <- bulk_counts |>
  # mean across replicates
  mutate(ctec_mean = (ctec1 + ctec2 + ctec3)/3,
         mtec_mean = (mtec1 + mtec2 + mtec3)/3,
         # remove version number (.xxx) of gene id
         gene_id=gsub("\\..*", "", gene)) |>
  # arrange gene column
  arrange(gene)

# format duplicate gene ids
# do a sanity check to find out what duplicate ids are
unique_duplicates <- unique(bulk_counts$gene_id[duplicated(bulk_counts$gene_id)])
# seems like duplicates are on pseduo-autosomal region; let's get the mean
bulk_counts |> filter(gene_id %in% unique_duplicates)

bulk_counts <- bulk_counts |>
  # group by unique gene_id
  group_by(gene_id) |>
  # how do we want the rows that belong to unique gene_ids to be summarised:
  # find all columns that have doubles (ie all the ones with counts)
  # for gene_ids with multiple entries, get the mean for each column
  summarise(across(where(is.double), ~ mean(.x, na.rm = TRUE)))

# create input data for music
bulk_sums <- bulk_counts |>
  # select only the columns needed for MuSiC
  dplyr::select(gene_id, ctec_mean, mtec_mean) |>
  # convert to data.frame to add rownames 
  as.data.frame() |>
  column_to_rownames("gene_id") |>
  # convert to matrix
  as.matrix()

bulk_indiv <- bulk_counts |>
  dplyr::select(gene_id, ctec1, ctec2, ctec3, mtec1, mtec2, mtec3) |>
  # convert to data.frame to add rownames 
  as.data.frame() |>
  column_to_rownames("gene_id") |>
  # convert to matrix
  as.matrix()

# convert to using ExpressionSet()
bulk_sums <- ExpressionSet(assayData = bulk_sums)
bulk_indiv <- ExpressionSet(assayData = bulk_indiv)

# load single cell data: will use newly annotated 10x flex data
flex_tec <- readRDS("raw-data/260818-2155-post-annotating.rds")
rownames(flex_tec)

# convert to singleCellExperiment
flex_tec.sce <- as.SingleCellExperiment(flex_tec)

# extract cell types from single cell datasets
celltype.flex_tec <- unique(flex_tec@meta.data$cell_type)

# =============================================================================
# MuSiC Analysis
# =============================================================================
# Extract expression data from bulk ExpressionSet object
bulk_sums.mtx = exprs(bulk_sums)
bulk_indiv.mtx = exprs(bulk_indiv)


# Convert rownames to ensembl gene ids: first load the gene info
gene_info <- readRDS("gene_info.rds")

lookup <- setNames(gene_info$external_gene_name, gene_info$ensembl_gene_id)

sum_names <- lookup[rownames(bulk_sums.mtx)]

sum_names[is.na(sum_names)] <- rownames(bulk_sums.mtx)[is.na(sum_names)]

rownames(bulk_sums.mtx) <- make.unique(sum_names)


indiv_names <- lookup[rownames(bulk_indiv.mtx)]

indiv_names[is.na(indiv_names)] <- rownames(bulk_indiv.mtx)[is.na(indiv_names)]

rownames(bulk_indiv.mtx) <- make.unique(indiv_names)


# Run MuSiC using parse dataset (tec.query.sce) as reference
est.prop.sum = music_prop(bulk.mtx = bulk_sums.mtx, sc.sce = flex_tec.sce,
                          clusters = 'cell_type',
                          samples = 'sample.id', select.ct = celltype.flex_tec)
est.prop.indiv = music_prop(bulk.mtx = bulk_indiv.mtx, sc.sce = flex_tec.sce,
                            clusters = 'cell_type',
                            samples = 'sample.id', select.ct = celltype.flex_tec)
head(est.prop.sum)
head(est.prop.indiv)

# =============================================================================
# Plotting results
# =============================================================================
df <- est.prop.indiv[['Est.prop.weighted']] |> 
  as.data.frame() |>
  tibble::rownames_to_column("Sample") |>
  pivot_longer(cols = -Sample, names_to = "celltype", values_to = "proportion") |>
  mutate(cellclass=gsub("\\d", "", Sample)) |>
  as_tibble()

p <- ggplot(df, aes(x = Sample, y = proportion, color = cellclass)) +
  geom_point() +
  labs(color = "Celltype", x="Samples", y = "Proportion") +
  scale_color_manual(values=c('#1b9e77','#d95f02')) +
  facet_wrap(~celltype, nrow = 2) +
  theme_minimal_hgrid() +
  theme(aspect.ratio = 1,
    axis.text.x = element_text(angle = 90, hjust = 1)) 

print(p)
ggsave(plot=p, "results/deconvolution-proportion-using-10x-flex-data.pdf")

