#!/bin/bash
#
#SBATCH --job-name=faidx
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=faidx.out # File to which STDOUT will be written
#SBATCH --error=faidx.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

module load samtools

samtools faidx -r geneids.txt ../../Genome/farr1.protein.fa -o farr1.protein.subset.fa
