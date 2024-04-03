#!/bin/bash
#
#SBATCH --job-name=overlaps
#SBATCH --ntasks=8 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=36G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=overlaps.out # File to which STDOUT will be written
#SBATCH --error=overlaps.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=06:00:00

grep transcript genblastG-output_FbL.gff | gff2bed | sortBed | clusterBed -s | cut -f4,11  > genblastG-output_FbL_clusters
