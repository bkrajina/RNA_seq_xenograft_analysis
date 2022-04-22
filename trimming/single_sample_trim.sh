#!/bin/bash
#SBATCH --output=out_single_trim
#SBATCH --error=error_single_trim
#SBATCH --partition=campus-new

# Load necessary modules
ml load Trim_Galore/0.6.5-GCCcore-8.3.0-Java-11-Python-3.7.4
ml load FastQC/0.11.9-Java-11

# Define i/o
sample='4T1'
master_dir='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/30-426856138/'
out_dir='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/trimmed_reads/30-426856138_trimmed/'
fqc_out='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/trimmed_reads/30-426856138_fastqc/'
read1=${sample}'_R1_001.fastq.gz'
read2=${sample}'_R2_001.fastq.gz'

file1=${master_dir}/${read1}
file2=${master_dir}/${read2}

# Run trimming and fastqc
fqc_args="\"--outdir "${fqc_out}"\""
#trim_galore --o ${out_dir} --fastqc --fastqc_args ${fqc_args} --paired ${file1} ${file2}

trim_galore --paired ${file1} ${file2} --output_dir ${out_dir}
