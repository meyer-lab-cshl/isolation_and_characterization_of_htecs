# Isolation and Characterization of Human Thymic Epithelial Cells
Data analysis code for the manuscript: Yong _et al_ (2026) "Isolation and Characterization of Human Thymic Epithelial Cells"

Content:
1. verify CD205 as a valid surface marker for identifying human thymus epithelials.
2. characterize previously described CD49f(hi)CD200- "cTECs" by MuSiC deconvolution analysis using our scRNAseq data as reference.
3. assess correspondence of scRNAseq cell types with previously-published Bautista human thymic stromal cell atlas.
4. characterize putative thymic nurse cell subsets

### 10x Flex single-cell RNAseq of CD205+, CD205- and total TECs
Analyses [here](https://github.com/meyer-lab-cshl/isolation_and_characterization_of_htecs/blob/master/scripts/260819-10x-flex-scrnaseq-human-tec-ht67-ht70-ht71.R), 
* identifying TEC clusters,
* verifying CD205 as surface marker,
* assessment of published gene scores on this dataset and
* analyses of thymic nurse cells.

### CD49f(hi)CD200- MuSiC deconvolution analysis
* Objective: align and generate read counts from published TEC bulk-RNAseq data and compare to our TEC scRNAseq data to determine what TEC subtypes make up CD49f(hi)CD200-
* Public data source: https://www.ebi.ac.uk/ena/browser/view/PRJEB39649
* Date downloaded: 7/18/2024
* Paper origin: Novel Combination of Surface Markers for the Reliable and Comprehensive Identification of Human Thymic Epithelial Cells by Flow * Cytometry: Quantitation and Transcriptional Characterization of Thymic Stroma in a Pediatric Cohort

### Integration of scRNAseq data with previously-published Bautista dataset
* The file located at jupyter_notebooks/bautista_flex_integration.ipynb integrates the scRNAseq dataset withe previously-published Bautista human thymic stromal cell atlas.
* Code to collate metadata from the Bautista dataset is located at scripts/get_published_bautista_metadata.py. 
