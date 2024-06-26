# Homology-based R Gene Prediction Pipeline

## Intro

This repository contains my personal documentation of running the full-length Homology-based R gene Prediciton pipeline from https://github.com/AndolfoG/HRP. This includes the commands from the official documentation with some minor modificaitons, plus commands for steps that were not explained in the documentation, such as filtering the protein fasta list to genes identified in the early analyses. These commands are all contained in a series of scripts, in which the output of one script is the input for the next script. The commands in these scripts use my file names, which will need to be changed to match others' files. They also contain my personal SLURM headers, which will need to be changed or removed for others' uses. The commands can also be run on the command line without the use of scripts. Instructions are below.

## Pipeline

1. Obtain necessary software: env.sh

Required software includes InterProScan, MEME suite, Bedtools, genBlastG, and AGAT suite. I created a conda environment for installation of the programs to which I did not already have access, which included only genBlastG and the AGAT suite. If you need additional programs, you can add them to the hrp.yml file in this repository.

```bash
conda env create -n hrpenv -f hrp.yml
```

2. Prepare data

You will need a genome fasta file, a protein fasta file, and ideally an annotation file. I am using data from the following link: https://datadryad.org/stash/dataset/doi:10.25338/B8TP7G 

3. Protein domain search: interpro.sh


```bash
interproscan.sh -f TSV -appl Pfam -i ../Genome/farr1.protein.fa -b farr1.interpro
```

4. Filter Interpro results for NB-ARC domain and put in BED format: format.sh

```bash
grep NB-ARC farr1.interpro.tsv | cut -f1,7,8 > NB.bed
```

5. Extract sequences of domains: extract.sh

```bash
bedtools getfasta -fi ../Genome/farr1.protein.fa -bed NB.bed -fo NB_Pfam_Domain_Sequences.fasta
```

6. Get motifs from domain sequences: motifpt1.sh

```bash
meme NB_Pfam_Domain_Sequences.fasta -o meme_out -protein -mod zoops -nmotifs 19 -minw 4 -maxw 7 -objfun classic -markov_order 0
```

7. Use motifs to identify additional domains: motifpt2.sh

```bash
mast meme_out/meme.txt ../../Genome/farr1.protein.fa -o mast_out
```

8. Get gene IDs from mast output (output from motifpt2.sh): getids.sh

```bash
awk '/SEQUENCE NAME/ && /DESCRIPTION/{print;flag=1;next} /^$/{flag=0} flag { print$1 }' mast_out/mast.txt | awk 'NR>=3' > geneids.txt
```

9. Get sequences of gene list from mast: faidx.sh

```bash
samtools faidx -r geneids.txt ../Genome/farr1.protein.fa -o farr1.protein.subset.fa
```

10. Check whether NLRs are complete or partial: HRPscript.sh

```bash
./IPS2fpGs.sh farr1.interpro2.tsv > nlrlengths.tsv
```

11. Get gene IDs for complete/full-length NLR genes: getids2.sh

```bash
awk '$2 == "full-length'' {print $1}' nlrlengths.tsv > geneids2.txt
```

12. Get sequences of full-length NLR genes: faidx2.sh

```
samtools faidx -r geneids2.txt ../Genome/farr1.transcript.fa -o full-lenth_NB-LRRs.fa
```

13. Identify paralogous gene models using genblastG: genblast.sh

```
genblastG -q full-length_NB-LRRs.fa -t ../Genome/farr1.fa -gff -cdna -pro -o genblastG-output
```

14. Filter gene models based on length: filter.sh

```
agat_sp_filter_gene_by_length.pl --gff genblastG-output_1.1c_2.3_s1_0_16_1.gff --size 20000 --test "<" -o genblastG-output_FbL.gff
```

15. Identify overlapping gene models gene models: overlaps.sh

```
grep transcript genblastG-output_FbL.gff | gff2bed | sortBed | clusterBed -s | awk -F'=|;|\t' '{ print $11,$16,$1,$2,$3 }'  > genblastG-output_FbL_clusters
```

16. Estimate protein sequence lengths: seqlengths.sh

```
awk 'BEGIN{FS="[> ]"} /^>/{val=$2;next}  {print val,length($0);val=""} END{if(val!=""){print val}}' genblastG-output_1.1c_2.3_s1_0_16_1.pro | tr ' ' \\t | sort > genblastG-output_FbL_length
```
 
