#!/bin/bash
#
#SBATCH --job-name=interpro
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=interpro.out # File to which STDOUT will be written
#SBATCH --error=interpro.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=8:00:00

deprecated/interproscan/5.32-71.0

interproscan.sh -f TSV -appl Pfam -i ../Genome/farr1.protein.fa -b farr1.interpro
