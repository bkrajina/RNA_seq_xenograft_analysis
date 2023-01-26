#!/bin/bash
#SBATCH --output=out_batch_trim
#SBATCH --error=error_batch_trim
#SBATCH --partition=campus-new

# Load necessary modules
ml load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
ml load FastQC/0.11.9-Java-11

###################################################
# Read the i/o parameters file into a dictionary
###################################################
io_file='../io_parameters.csv'
declare -A dict
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
sample_list=$base_dir${dict[names_file]}
LIST=$(cat "$sample_list")

# Define i/o
master_dir=$base_dir${dict["read_dir"]}
out_dir=$base_dir${dict["trim_dir"]}
fqc_out=$base_dir${dict["fastqc_dir"]}

# Create the output directories if they don't already exist
if [ ! -d $out_dir ]
then
    echo 'creating output directory'
    mkdir -p $out_dir
fi

if [ ! -d $fqc_out ]
then
    echo 'creating fastqc directory'
    mkdir -p $fqc_out
fi

#############################################
# Trim reads and run fastqc for all samples
#############################################

for sample in $LIST;
do
    echo trimming ${sample}
    read1=${sample}'_R1_001.fastq.gz'
    read2=${sample}'_R2_001.fastq.gz'

    file1=${master_dir}/${read1}
    file2=${master_dir}/${read2}

    # Run trimming and fastqc
    fqc_args="\"--outdir "${fqc_out}"\""

    trim_galore --paired ${file1} ${file2} --output_dir ${out_dir}
done
