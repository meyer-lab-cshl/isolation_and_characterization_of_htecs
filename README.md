# Isolation and Characterization of Human Thymic Epithelial Cells
Data analysis code for the manuscript: Lin Y _et al_ (2026) "Isolation and Characterization of Human Thymic Epithelial Cells", _Journal of Immunology_

## Content:
1. verify CD205 as a valid surface marker for identifying human thymus epithelials.
2. characterize previously described CD49f(hi)CD200- "cTECs" by MuSiC deconvolution analysis using our scRNAseq data as reference.
3. assess correspondence of scRNAseq cell types with previously-published Bautista human thymic stromal cell atlas.
4. characterize putative thymic nurse cell subsets

### 10x Flex single-cell RNAseq of CD205+, CD205- and total TECs
Objective: identifying TEC clusters and assessing their distribution based on sorting scheme; specifically:
* verifying CD205 as surface marker,
* assessment of published gene scores on this dataset and
* analyses of thymic nurse cells.
  
Analyses located [here](https://github.com/meyer-lab-cshl/isolation_and_characterization_of_htecs/blob/master/scripts/260819-10x-flex-scrnaseq-human-tec-ht67-ht70-ht71.R)

### CD49f(hi)CD200- MuSiC deconvolution analysis
Objective: align and generate read counts from published TEC bulk-RNAseq data and compare to our TEC scRNAseq data to determine what TEC subtypes make up CD49f(hi)CD200-
* Public data source: https://www.ebi.ac.uk/ena/browser/view/PRJEB39649, downloaded: 7/18/2024
* Paper origin: Haunerdinger et al (2021) [Novel Combination of Surface Markers for the Reliable and Comprehensive Identification of Human Thymic Epithelial Cells by Flow  Cytometry](https://www.frontiersin.org/journals/immunology/articles/10.3389/fimmu.2021.740047/full)

Analyses located [here](https://github.com/meyer-lab-cshl/isolation_and_characterization_of_htecs/blob/master/scripts/260818-music-deconvolution-analysis.R)


### Integration of scRNAseq data with previously-published Bautista dataset
Objective: put putative TEC clusters and sorting scheme into context of TEC types identified by Bautista _et al_ (2021) [Single-cell transcriptional profiling of human thymic stroma uncovers novel cellular heterogeneity in the thymic medulla](https://www.nature.com/articles/s41467-021-21346-6) and Ragazzini _et al_ (2023) [Defining the identity and the niches of epithelial stem cells with highly pleiotropic multilineage potency in the human thymus](https://doi.org/10.1016/j.devcel.2023.08.017).

Integration of the scRNAseq dataset with the Bautista _et al_ human thymic stromal cell atlas [here](jupyter_notebooks/bautista_flex_integration.ipynb). Code to collate metadata from the Bautista dataset located [here](scripts/get_published_bautista_metadata.py). 
