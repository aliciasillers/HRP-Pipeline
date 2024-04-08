#!/bin/bash
#
#SBATCH --job-name=select
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=select.out # File to which STDOUT will be written
#SBATCH --error=select.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=04:00:00

join -1 1 -2 1 -o 1.1,1.2,2.2,1.3,1.4,1.5 <( sort -bk1 genblastG-output_FbL_clusters) <(sort -bk1 genblastG-output_FbL_length) | sort -bk2,2 -bk3,3 -nr | sort -uk2,2 | awk '{OFS="\t"} {print $4,$5,$6}' | sort | uniq > R-gene_coordinates.bed

