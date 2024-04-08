# Homology-based R Gene Prediction Pipeline

## Intro

This repository contains my personal documentation of running the full-length Homology-based R gene Prediciton pipeline from https://github.com/AndolfoG/HRP. This includes the commands from the official documentation with some minor modificaitons, plus commands for steps that were not explained in the documentation, such as filtering the protein fasta list to genes identified in the early analyses. These commands are all contained in a series of scripts, in which the output of one script is the input for the next script. The commands in these scripts use my file names, which will need to be changed to match others' files. They also contain my personal SLURM headers, which will need to be changed or removed for others' uses. The commands can also be run on the command line without the use of scripts. Instructions are below.

## Pipeline

1. Obtain necessary software

> Required software includes InterProScan, MEME suite, Bedtools, genBlastG, and AGAT suite. I created a conda environment for installation of the programs to which I did not already have access, which included only genBlastG and the AGAT suite. If you need additional programs, you can add them to the hrp.yml file in this repository.
> To create the environment, run env.sh
> Alternatively, use the following command:
```bash
conda env create -n hrpenv -f hrp.yml
```

2. 
