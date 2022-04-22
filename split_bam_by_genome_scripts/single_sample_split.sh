#!/bin/bash
#SBATCH --output=samtools_single.out
#SBATCH --error=samtools_single.error

ml load SAMtools/1.11-GCC-10.2.0
sample='RatMammary1'
base_dir='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/STAR_mapping/cross_map_test'

# Extract all reads mapped uniquely to rat
# Take reads with MAPQ=255 (unique mappings)
# Take all headers (^@), take only reads with <tab>rn., exclude mouse headers
samtools view -h -q 255 ${base_dir}/${sample}/${sample}-Aligned.out.bam | \
sed -n '/^@/ p; /\trn\./ p' | sed -n '/SN:mm\./! p' | \
samtools view -b > ${base_dir}/${sample}/${sample}-rn.Aligned.out.bam

# Extract all reads mapped uniquely to mouse
# Take reads with MAPQ=255 (unique mappings)
# Take all headers (^@), take only reads with <tab>mm., exclude rat headers
samtools view -h -q 255 ${base_dir}/${sample}/${sample}-Aligned.out.bam | \
sed -n '/^@/ p; /\tmm\./ p' | sed -n '/SN:rn\./! p' | \
samtools view -b > ${base_dir}/${sample}/${sample}-mm.Aligned.out.bam
