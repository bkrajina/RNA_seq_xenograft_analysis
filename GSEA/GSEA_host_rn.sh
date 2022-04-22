#!/bin/bash
#SBATCH --output=gsea_rn.out
#SBATCH --error=gsea_rn.error
#SBATCH --mem=64G
#SBATCH -c 4
#SBATCH --partition=campus-new


rank_file='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/bk_analysis_2022_02_11/rank_files/Angptl7_KD3_in-NT4_in_rn_ensembl.rnk'
out_folder='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/GSEA_high_perm_out'
Nperm=100000
analysis_name='rn_Angptl7KD_vs_NT_GSEA_nperm_'$Nperm

~/GSEA_4.2.3/gsea-cli.sh GSEAPreranked -gmx ftp.broadinstitute.org://pub/gsea/gene_sets/c5.go.v7.5.1.symbols.gmt -collapse Collapse -mode Abs_max_of_probes -norm meandiv -nperm $Nperm -rnd_seed timestamp -rnk $rank_file -scoring_scheme weighted -rpt_label $analysis_name -chip ftp.broadinstitute.org://pub/gsea/annotations_versioned/Rat_ENSEMBL_Gene_ID_Human_Orthologs_MSigDB.v7.5.chip -create_svgs false -include_only_symbols true -make_sets true -plot_top_x 20 -set_max 500 -set_min 15 -zip_report false -out $out_folder
