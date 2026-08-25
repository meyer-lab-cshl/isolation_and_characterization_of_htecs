import scanpy as sc
import numpy as np
import pandas as pd

# load all published bautista data
baut_published = sc.read("GSE147520_all_cells.h5ad")

# load our raw bautista data 
baut_raw = sc.read("bautista_adata.h5ad")

# get published cell names to keep

## edit names and remove duplicates
to_keep = baut_published.obs_names.str.split("-").str[0].drop_duplicates(keep = False)

## subset anndata object
baut_published_keep = baut_published.copy()
baut_published_keep.obs_names = baut_published_keep.obs_names.str.split("-").str[0]

baut_published_keep = baut_published_keep[baut_published_keep.obs_names.isin(to_keep)]

# get raw cell names to keep

## edit names and remove duplicates
to_keep_raw = baut_raw.obs_names.str.split("_").str[0].drop_duplicates(keep = False)

## subset anndata object
baut_raw_keep = baut_raw.copy()
baut_raw_keep.obs_names = baut_raw_keep.obs_names.str.split("_").str[0]

baut_raw_keep = baut_raw_keep[baut_raw_keep.obs_names.isin(to_keep_raw)]

# get metadata for common cells
common_cells = list(set(baut_published_keep.obs_names).intersection(set(baut_raw_keep.obs_names)))

