#!/bin/bash
#SBATCH --output='trimmed_parallel.out'
#SBATCH --error='trimmed_parallel.error'
#SBATCH -c 6 
ml load SAMtools/1.11-GCC-10.2.0
ml load parallel/20200422-GCCcore-8.3.0

# Read sample list
sample_list='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/names_30-426856138.txt'
LIST=$(cat "$sample_list")

# Define directory of mapping BAM files
master_dir=/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/trimmed_reads/STAR_mapping/rn_mm_map

# Extract all reads mapped uniquely to rat
# Take reads with MAPQ=255 (unique mappings)
# Take all headers (^@), take only reads with <tab>rn., exclude mouse headers
parallel -j 6 "samtools view -h -q 255 $master_dir/{}/{}-Aligned.out.bam | \
sed -n '/^@/ p; /\trn\./ p' | sed -n '/SN:mm\./! p' | \
samtools view -b > $master_dir/{}/{}-rn.Aligned.out.bam" ::: $LIST

# Extract all reads mapped uniquely to mouse
# Take reads with MAPQ=255 (unique mappings)
# Take all headers (^@), take only reads with <tab>mm., exclude rat headers
parallel -j 6 "samtools view -h -q 255 $master_dir/{}/{}-Aligned.out.bam | \
sed -n '/^@/ p; /\tmm\./ p' | sed -n '/SN:rn\./! p' | \
samtools view -b > $master_dir/{}/{}-mm.Aligned.out.bam" ::: $LIST

