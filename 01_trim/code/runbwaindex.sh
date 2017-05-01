#!/bin/bash
#SBATCH -p general
#SBATCH --mem 20000
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -t 5:00:00
#SBATCH -J runbwaindex_is
#SBATCH -e runbwaindex_is_%j.err
#SBATCH -o runbwaindex_is_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu
 
module load gcc/4.8.2-fasrc01 bwa/0.7.9a-fasrc02

bwa index -p BFHE_WA336010 -a is BFHE_WA336010.fasta
