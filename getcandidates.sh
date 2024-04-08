#!/bin/bash
#
#SBATCH --job-name=getcandidates
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getcandidates.out # File to which STDOUT will be written
#SBATCH --error=getcandidates.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

module load bedtools2

#bedtools intersect -a ../Genome/farr1.gene_models_updated.gff -b R-gene_coordinates.bed -wa | grep 'mRNA' | awk -F'\t|=|;' '{print$10}' | uniq > Rgene_candidates.txt

bedtools intersect -a ../Genome/farr1.gene_models_updated.gff -b new_nlrs.bed -wa | grep 'gene' | awk -F'\t|=|;' '{print$10}' > new_nlr_genes.txt
