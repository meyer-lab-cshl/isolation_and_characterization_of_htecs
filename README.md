# Isolation and Characterization of Human Thymic Epithelial Cells
Data analysis code for the manuscript: Isolation and Characterization of Human Thymic Epithelial Cells (article link: xxx)

Content:
1. verify CD205 as a valid surface marker for identifying human thymus epithelials.
2. characterize previously described CD49f(hi)CD200- "cTECs" by MuSiC deconvolution analysis using our scRNAseq data as reference.
3. assess correspondence of scRNAseq cell types with previously-published Bautista human thymic stromal cell atlas.
4. characterize putative thymic nurse cell subsets


### CD49f(hi)CD200- MuSiC deconvolution analysis
Objective: align and generate read counts from published TEC bulk-RNAseq data and compare to our TEC scRNAseq data to determine what TEC subtypes make up CD49f(hi)CD200-
Public data source: https://www.ebi.ac.uk/ena/browser/view/PRJEB39649
Date downloaded: 7/18/2024
Paper origin: Novel Combination of Surface Markers for the Reliable and Comprehensive Identification of Human Thymic Epithelial Cells by Flow Cytometry: Quantitation and Transcriptional Characterization of Thymic Stroma in a Pediatric Cohort

### Integration of scRNAseq data with previously-published Bautista dataset
The file located at jupyter_notebooks/bautista_flex_integration.ipynb integrates the scRNAseq dataset withe previously-published Bautista human thymic stromal cell atlas. Code to collate metadata from the Bautista dataset is located at scripts/get_published_bautista_metadata.py. 
