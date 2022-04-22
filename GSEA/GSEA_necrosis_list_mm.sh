#!/bin/bash
#SBATCH --output=gsea_mm_necrosis.out
#SBATCH --error=gsea_mm_necrosis.error
#SBATCH --mem=128G
#SBATCH -c 4
#SBATCH --partition=campus-new


rank_file='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/bk_analysis_2022_02_11/rank_files/Angptl7_KD3_in-NT4_in_mm_ensembl.rnk'
out_folder='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/GSEA_high_perm_out'
gene_list='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/necrosis_gene_lists/necrosis_gene_list_ensembl_logFC_1_FDR_0.001.grp'
Nperm=1000000
analysis_name='mm_Angptl7KD_vs_NT_inside_GSEA_necrosis_genes_logFC_1_FDR_0.001_nperm_'$Nperm

~/GSEA_4.2.3/gsea-cli.sh GSEAPreranked -gmx $gene_list -collapse No_Collapse -mode Abs_max_of_probes -norm meandiv -nperm $Nperm -rnd_seed timestamp -rnk $rank_file -scoring_scheme weighted -rpt_label $analysis_name -create_svgs false -include_only_symbols true -make_sets true -plot_top_x 20 -set_max 500 -set_min 15 -zip_report false -out $out_folder

rank_file='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/bk_analysis_2022_02_11/rank_files/Angptl7_KD3_in-NT4_in_mm_ensembl.rnk'
out_folder='/fh/fast/cheung_k/Ami/2022_01_25_Angptl7_KD_RNA_seq/GSEA_high_perm_out'
gene_list='/fh/fast/cheung_k/Ami/NewNecrosisRNAseq/necrosis_gene_lists/necrosis_gene_list_ensembl_logFC_2_FDR_0.001.grp'
Nperm=1000000
analysis_name='mm_Angptl7KD_vs_NT_inside_GSEA_necrosis_genes_logFC_2_FDR_0.001_nperm_'$Nperm

~/GSEA_4.2.3/gsea-cli.sh GSEAPreranked -gmx $gene_list -collapse No_Collapse -mode Abs_max_of_probes -norm meandiv -nperm $Nperm -rnd_seed timestamp -rnk $rank_file -scoring_scheme weighted -rpt_label $analysis_name -create_svgs false -include_only_symbols true -make_sets true -plot_top_x 20 -set_max 500 -set_min 15 -zip_report false -out $out_folder
