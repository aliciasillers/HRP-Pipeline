#!/bin/bash
#
#SBATCH --job-name=filter
#SBATCH --ntasks=8 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=36G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=filter.out # File to which STDOUT will be written
#SBATCH --error=filter.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=06:00:00

module load conda/lastest
conda activate hrpenv

agat_sp_filter_gene_by_length.pl --gff genblastG-output.gff --size 20000 --test "<" -o genblastG-output_FbL.gff
