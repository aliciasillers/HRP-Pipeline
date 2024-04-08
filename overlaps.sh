#!/bin/bash
#
#SBATCH --job-name=overlaps
#SBATCH --ntasks=2 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=overlaps.out # File to which STDOUT will be written
#SBATCH --error=overlaps.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=04:00:00

module load bedtools2
module load bedops

grep transcript genblastG-output_FbL.gff | gff2bed | sortBed | clusterBed -s | awk -F'=|;|\t' '{ print $11,$16,$1,$2,$3 }'  > genblastG-output_FbL_clusters
