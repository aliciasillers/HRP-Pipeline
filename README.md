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

You will need a genome fasta file, a protein fasta file, and ideally an annotation file

3. Protein Domain Search: interpro.sh


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
