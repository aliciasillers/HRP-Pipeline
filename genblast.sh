#!/bin/bash
#
#SBATCH --job-name=genblast
#SBATCH --ntasks=8 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=36G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=genblast.out # File to which STDOUT will be written
#SBATCH --error=genblast.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=06:00:00

module load conda/lastest
conda activate hrpenv

genblastG -q Full-length_NB-LRRs.fasta -t ../../Genome/farr1.fa -gff -cdna -pro -o genblastG-output
