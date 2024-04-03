#!/bin/bash
#
#SBATCH --job-name=select
#SBATCH --ntasks=8 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=36G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=select.out # File to which STDOUT will be written
#SBATCH --error=select.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=06:00:00

join -t $'\t' -1 1 -2 1 -o 1.1,1.2,2.2 <( sort -bk1 genblastG-output_FbL_clusters) <(sort -bk1 genblastG-output_FbL_length) | sort -bk2,2 -bk3,3 -nr | sort -uk2,2 | cut -f1 > R-gene_ID_list
