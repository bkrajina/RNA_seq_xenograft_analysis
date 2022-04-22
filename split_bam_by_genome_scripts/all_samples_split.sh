#!/bin/bash
#SBATCH --output='split_all_samples.out'

ml load SAMtools/1.11-GCC-10.2.0
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

# Define directory of mapping BAM files

bam_dir=$base_dir${dict['STAR_map_dir']}/${dict['map_name']}

for sample in $LIST; do
	# Extract all reads mapped uniquely to rat
	# Take reads with MAPQ=255 (unique mappings)
	# Take all headers (^@), take only reads with <tab>rn., exclude mouse headers
	samtools view -h -q 255 $bam_dir/${sample}/${sample}-Aligned.out.bam | \
	sed -n '/^@/ p; /\trn\./ p' | sed -n '/SN:mm\./! p' | \
	samtools view -b > $bam_dir/${sample}/${sample}-rn.Aligned.out.bam
	# Extract all reads mapped uniquely to mouse
	# Take reads with MAPQ=255 (unique mappings)
	# Take all headers (^@), take only reads with <tab>mm., exclude rat headers
	samtools view -h -q 255 $bam_dir/${sample}/${sample}-Aligned.out.bam | \
	sed -n '/^@/ p; /\tmm\./ p' | sed -n '/SN:rn\./! p' | \
	samtools view -b > $bam_dir/${sample}/${sample}-mm.Aligned.out.bam
done
