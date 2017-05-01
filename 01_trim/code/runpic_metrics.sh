#!/bin/bash
#SBATCH -p serial_requeue
#SBATCH --mem 20000
#SBATCH -n 8
#SBATCH -N 1
#SBATCH -t 3:00:00
#SBATCH -J pic_multimetrics
#SBATCH -e pic_multimetrics_%j.err
#SBATCH -o pic_multimetrics_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu

module load java/1.8.0_45-fasrc01
module load picard-tools/1.119-fasrc01
module load gcc/4.8.2-fasrc01 R/3.3.0-fasrc02

SAMPLE=$1

#java -Xmx7g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar CollectRawWgsMetrics \
#INPUT=${SAMPLE}-pe-sort-head-dup.bam \
#OUTPUT=${SAMPLE}-pe-sort-head-dup-rawWGSmets.txt \
#R=in.BFHE_WA336010.fasta \
#INCLUDE_BQ_HISTOGRAM=true

# Collect more metrics

java  -Xmx7g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar CollectMultipleMetrics \
I=${SAMPLE}-pe-sort-head-dup.bam \
O=${SAMPLE}-pe-sort-head-dup-multimets \
R=in.BFHE_WA336010.fasta
