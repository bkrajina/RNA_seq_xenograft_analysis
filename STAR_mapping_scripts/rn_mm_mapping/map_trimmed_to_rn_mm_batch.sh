#!/bin/bash
#SBATCH --output=trim_map.out
#SBATCH --error=trim_map.error
#SBATCH --mem=64G
#SBATCH -c 8
#SBATCH --partition=campus-new

ml load STAR/2.7.3a-foss-2019b

###################################################
# Read the i/o parameters file into a dictionary
###################################################
io_file='../../io_parameters.csv'
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

# Create the output directories if they don't already exist
if [ ! -d $out_dir ]
then
    echo 'creating output directory'
    mkdir $out_dir
fi

# Loop over all samples and run STAR
for sample in $LIST;
do
    echo $sample

    # If output directory for sample does not exist,
    # create it
    
    if [ ! -d $out_dir/$sample ]
    then
	mkdir $out_dir/$sample
    fi
    
    outprefix=$out_dir/$sample/$sample'-'
    STAR \
	--runThreadN 8 \
	--genomeDir $genome_dir \
	--outFileNamePrefix  $outprefix \
	--readFilesCommand gunzip -c \
	--readFilesIn $read_dir/$sample'_R1_001_val_1.fq.gz' $read_dir/$sample'_R2_001_val_2.fq.gz' \
	--sjdbGTFfile $gtf_file \
	--sjdbOverhang 149 \
	--outSAMtype BAM Unsorted SortedByCoordinate \
	--outSAMunmapped Within
    echo 'done'
done
