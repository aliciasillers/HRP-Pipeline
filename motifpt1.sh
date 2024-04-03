#!/bin/bash
#
#SBATCH --job-name=motifpt1
#SBATCH --ntasks=4 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=32G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=motifpt1.out # File to which STDOUT will be written
#SBATCH --error=motifpt1.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=8:00:00

module load meme

meme NB_Pfam_Domain_Sequences.fasta -o meme_out -protein -mod zoops -nmotifs 19 -minw 4 -maxw 7 -objfun classic -markov_order 0
