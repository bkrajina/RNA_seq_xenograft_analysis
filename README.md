# RNA_seq_xenograft_analysis
This is a set of example scripts encompassing a full pipeline for RNA-seq analysis of xenograft samples, allowing for species disambiguation at the alignment level.
The io_parameters.csv file contains parameters for file input/output specification during the trimming, alignment, and feature counting steps.

All code developed by Brad A. Krajina.

These scripts were used to generate analyses for the PNAS manuscript. Please cite this paper if you use these scripts:
Breast cancer-derived angiopoietin-like 7 regulates necrotic core formation and metastasis from the tumor interior
Ami Yamamoto, Yin Huang, Brad A. Krajina, Margaux McBirney, Andrea E. Doak, Carolyn L. Wang, Michael C. Haffner, Kevin J. Cheung.

Analysis should be performed in the following order:
1)Trimming (Trimming)
2)Alignment ("STAR_mapping_scripts")
3)Segregation of reads uniquely mapping to mouse/rat ("split_bam_by_genome_scripts")
4)Counting reads to genomic features ("featureCounts_scripts")
5)Normalization and differential expression analysis ("DE_analysis")

Note that for code to run properly for your use case, input/output directories must be corrected in the io_parameters.csv file, and separately in the DE_analysis files.
