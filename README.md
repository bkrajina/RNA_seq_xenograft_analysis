# RNA_seq_xenograft_analysis
This is a set of example scripts encompassing a full pipeline for RNA-seq analysis of xenograft samples, allowing for species disambiguation at the alignment level.
The io_parameters.csv file contains parameters for file input/output specification during the trimming, alignment, and feature counting steps, as a comma separated value list of the form: parameter,value.

All code developed by Brad A. Krajina, PhD (Fred Hutchinson Cancer Center). 2023

These scripts were used to generate analyses for the following PNAS publication. Please cite this paper if you use these scripts:  
"Metastasis from the tumor interior and necrotic core formation are regulated by breast cancer-derived angiopoietin-like 7"  
Authors:
Ami Yamamoto, Yin Huang, Brad A. Krajina, Margaux McBirney, Andrea E. Doak, Carolyn L. Wang, Michael C. Haffner, Kevin J. Cheung.

Species disambiguation is performed by aligning reads to a catenated genome consisting of the host and transplant species genomes.

Analysis should be performed in the following order:  
1)Trimming (Trimming)  
2)Alignment ("STAR_mapping_scripts")  
3)Segregation of reads uniquely mapping to mouse/rat ("split_bam_by_genome_scripts")  
4)Counting reads to genomic features ("featureCounts_scripts")  
5)Normalization and differential expression analysis ("DE_analysis")


Note that for code to run properly for your use case, input/output directories must be corrected in the io_parameters.csv file, and separately in the DE_analysis files. All file directories are specified relative to the first parameter, "base_dir", in which it is assumed that all data files and output files will reside, with the exception of genome inded (idx) and genome annotation gtf files. The genome index should be generated prior to running the scripts (this can be accomplished using STAR by following the manual).
