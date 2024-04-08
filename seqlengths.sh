#!/bin/bash
#
#SBATCH --job-name=seqlengths
#SBATCH --ntasks=1 # Number of cores
#SBATCH --nodes=1 # Ensure that all cores are on one machine
#SBATCH --mem=20G # Memory pool for all cores in MB (see also --mem-per-cpu)
#SBATCH --partition=bmh # Partition to submit to
#SBATCH --output=seqlengths.out # File to which STDOUT will be written
#SBATCH --error=seqlengths.err # File to which STDERR will be written
#SBATCH --mail-type=END,FAIL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=asillers@ucdavis.edu # Email to which notifications will be$
#SBATCH --time=04:00:00

awk 'BEGIN{FS="[> ]"} /^>/{val=$2;next}  {print val,length($0);val=""} END{if(val!=""){print val}}' genblastG-output_1.1c_2.3_s1_0_16_1.pro | tr ' ' \\t | sort > genblastG-output_FbL_length
