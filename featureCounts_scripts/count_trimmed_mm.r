library(Rsubread)
library(data.table)
library(tibble)

## Define file directories
master_dir <- '/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/trimmed_reads/STAR_mapping/rn_mm_map/'
annot_file <- '/fh/fast/cheung_k/Brad/genomes/catenated_genomes/rn_mm_catenated/rn.mm.annot.catenated.gtf'
meta_file <- '/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/tumor_region_metadata.csv'
save_dir <- '/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/trimmed_reads/feature_counts/'
save_prefix <- 'trimmed'
## Read in the metadata to get sample names
species <- 'mm'
meta_data <- read.csv(meta_file)
samples <- meta_data$Sample
sample_files <- paste0(samples, '-', species ,'.Aligned.out.bam')
sample_paths <- file.path(master_dir, samples, sample_files)


## Get gene counts
FCout <- featureCounts(sample_paths, annot.ext=annot_file,
                       isGTFAnnotationFile=TRUE,
                       isPairedEnd=TRUE, nthreads=8,
                       countMultiMappingReads=FALSE,
                       requireBothEndsMapped=TRUE,
)

## Rename columns from .bam file names to sample names
old.names <- sample_files
new.names <- gsub('-','.',samples)
FCout$counts <- as.data.frame(FCout$counts)
data.table::setnames(FCout$counts, old.names, new.names)

## For consistency, make GeneID column in annotation
## table a rowname

FCout$annotation <- tibble::column_to_rownames(FCout$annotation,
                                               var='GeneID')
## Print output
print(FCout$stat)
print(FCout$targets)
print(head(FCout$counts))

## Write out data
write.csv(FCout$stat, file.path(save_dir,
                                paste0(save_prefix,
                                       '_featureCounts_stats_', species,
                                       '.csv')))
write.csv(FCout$counts, file.path(save_dir, paste0(save_prefix,
                                                   '_gene_counts_',
                                                   species, '.csv')))
write.csv(FCout$annotation, file.path(save_dir,
                                      paste0(save_prefix,
                                             '_FC_gene_annot_',
                                             species, '.csv')))
