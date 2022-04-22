#!/bin/bash
#SBATCH --output=index.out
#SBATCH --error=index.error
#SBATCH --mem=32G
#SBATCH -c 8
#SBATCH --partition=campus-new

ml load STAR/2.7.3a-foss-2019b
ml load IGV/2.9.4-Java-11
###################################################
# Read the i/o parameters file into a dictionary
###################################################
io_file='../io_parameters.csv'
declare -A dict
# Save default IFS to restore later
OIFS=$IFS
IFS=','
while read key value
do
    dict+=(["$key"]="$value")
done <$io_file
#Restore IFS to default
IFS=$OIFS

######################################
# Use i/o dictionary to build sample
# list and define i/o variables for
# trimming reads
######################################

# Load sample list
base_dir=${dict["base_dir"]}
sample_list=$base_dir${dict['names_file']}
LIST=$(cat "$sample_list")

# Define input and output directories and files
read_dir=$base_dir${dict['trim_dir']}
genome_dir=${dict['rn_mm_genome_dir']}
out_dir=$base_dir${dict['STAR_map_dir']}/${dict['map_name']}
gtf_file=${dict['rn_mm_gtf_dir']}

# Loop over all samples and create index

for sample in $LIST;
do
    echo $sample

    outprefix=$out_dir/$sample/$sample'-'
    bamfile=$outprefix'Aligned.sortedByCoord.out.bam'

    igvtools index $bamfile
done
