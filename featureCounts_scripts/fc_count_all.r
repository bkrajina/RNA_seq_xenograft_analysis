library(Rsubread)
library(data.table)
library(tibble)
source("fc_count_wrapper.r")

############################
## Read i/o parameters
############################
params_file <- '../io_parameters.csv'
dict <- read.csv(params_file, row.names=1, header=FALSE)

## Define file directories
base_dir <- dict['base_dir',]
map_dir <- dict['STAR_map_dir',]
bam_dir <-file.path(base_dir, map_dir, dict['map_name',])
annot_file <- dict['rn_mm_gtf_dir',]
meta_file <-file.path(base_dir, dict['meta_table',])
save_dir <- file.path(base_dir,dict['fc_save_dir',])
save_prefix <- 'trimmed'

## Read in the metadata to get sample names
meta_data <- read.csv(meta_file)
samples <- meta_data$Sample

##################################################
## Run feature counts on all desired mapping sets
##################################################


## Loop over species and get feature_counts data for each
## species mapping
species_list <- c('mm','rn')

for (species in species_list)
{
    ## Define the bam file locations
    sample_files <- paste0(samples, '-', species ,'.Aligned.out.bam')
    sample_paths <- file.path(bam_dir, samples, sample_files)

    # Call the feature counts wrapper function
    get_gene_counts(species, bam_file, meta_file, save_dir, save_prefix)

}

