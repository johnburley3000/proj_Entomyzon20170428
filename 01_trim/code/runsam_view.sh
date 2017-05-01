#!/bin/bash
#SBATCH -p serial_requeue
#SBATCH --mem 10000
#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 5:00:00
#SBATCH -J runsamview
#SBATCH -e runsamview_%j.err
#SBATCH -o runsamview_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu
module load samtools/1.3.1-fasrc01

#samtools view  -Sb  BFHE_WA336010-pe.sam -o BFHE_WA336010-pe.bam

samtools view  -Sb  BFHE_NSW76677_2-pe.sam -o BFHE_NSW76677_2-pe.bam
