#!/bin/bash
#
#SBATCH --job-name=annotate
#SBATCH --ntasks=8 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=24G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=annotate.out # File to which STDOUT will be written
#SBATCH --error=annotate.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=06:00:00

module load deprecated/interproscan/5.32-71.0

interproscan.sh -f TSV,GFF3 -i NB-LRR_gene_candidates.fa -b NLR_final_candidates
