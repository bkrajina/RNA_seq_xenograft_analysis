library(Rsubread)
library(data.table)
library(tibble)

print(sessionInfo())
###################################################################
## Wrapper function for performing feature counts on bam files and
## exporting the results to a file
##################################################################
## Parameters
## species - an identifier for the species. Assumes bam file named like
##          %sample-%species.Aligned.out.bam
## bam_dir - absolute path to the directory containing the bam files
## meta_path - absolute path to a csv file containing meta data for all samples
## save_dir - absolute path to which to save results. Must already exist
## save_prefix - a prefix to adorn the out files with

get_gene_counts <- function(species, bam_dir, meta_path,
                            save_dir, save_prefix){
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
}
