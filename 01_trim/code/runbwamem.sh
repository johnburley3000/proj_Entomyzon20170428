#!/bin/bash
#SBATCH -p serial_requeue
#SBATCH --mem 100000
#SBATCH -n 32
#SBATCH -N 1
#SBATCH -t 18:00:00
#SBATCH -J runbwamem
#SBATCH -e runbwamem_%j.err
#SBATCH -o runbwamem_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu
 
module load gcc/4.8.2-fasrc01 bwa/0.7.9a-fasrc02

#bwa mem -t 32 BFHE_WA336010 \
#/n/regal/edwards_lab/jburley/reseq_BFHE_WA_NSW/reads/BFHE_WA336010_read1.fq \
#/n/regal/edwards_lab/jburley/reseq_BFHE_WA_NSW/reads/BFHE_WA336010_read2.fq > BFHE_WA336010-pe.sam

bwa mem -t 32 BFHE_WA336010 \
/n/regal/edwards_lab/jburley/reseq_BFHE_WA_NSW/reads/BFHE_NSW76677_2_read1.fq \
/n/regal/edwards_lab/jburley/reseq_BFHE_WA_NSW/reads/BFHE_NSW76677_2_read2.fq > BFHE_NSW76677_2-pe.sam

