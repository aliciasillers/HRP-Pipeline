#!/bin/bash
#
#SBATCH --job-name=getids
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=getids.out # File to which STDOUT will be written
#SBATCH --error=getids.err #  File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=4:00:00

awk '/SEQUENCE NAME/ && /DESCRIPTION/{print;flag=1;next} /^$/{flag=0} flag { print$1 }' mast_out/mast.txt | awk 'NR>=3' > geneids.txt
