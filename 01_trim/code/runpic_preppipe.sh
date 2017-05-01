#!/bin/bash
#SBATCH -p serial_requeue
#SBATCH --mem 100000
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 20:00:00
#SBATCH -J pic_preppipe
#SBATCH -e pic_preppipe_%j.err
#SBATCH -o pic_preppipe_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu

# Specify sample:

SAMPLE=$1

# To run this set of programs, go: sbatch runpic_preppipe.sh <SAMPLE>
# there must be a SAMPLE.bam file in the wd
# i.e. <BFHE_NSW76677_2-pe>	<BFHE_WA336010-pe> (used 18 Jan 2017)

# wd is 

# Samsort:

module load java/1.8.0_45-fasrc01         # picard needs java v1.8
module load picard-tools/1.119-fasrc01

#java -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar SortSam \
#INPUT=${SAMPLE}.bam \
#OUTPUT=${SAMPLE}-sort.bam \
#SORT_ORDER=coordinate \

# Add header

java -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar AddOrReplaceReadGroups \
I=${SAMPLE}-sort.bam \
O=${SAMPLE}-sort-head.bam \
RGID=${SAMPLE} \
RGLB=${SAMPLE} \
RGPL=illumina \
RGPU=hg19PU \
RGSM=hg19 \

# Find Duplicates

java -Xmx19g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar MarkDuplicates \
REMOVE_DUPLICATES= false \
MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=8000 \
INPUT=${SAMPLE}-sort-head.bam \
OUTPUT=${SAMPLE}-sort-head-dup.bam \
METRICS_FILE=${SAMPLE}-sort-head-mets.txt

# Convert back to Sam:

java -Xmx19g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar SamFormatConverter \
INPUT=${SAMPLE}-sort-head-dup.bam \
OUTPUT=${SAMPLE}-sort-head-dup.sam

# Collect some metrics

java -Xmx19g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar CollectRawWgsMetrics \
INPUT=${SAMPLE}-sort-head-dup.bam \
OUTPUT=${SAMPLE}-sort-head-dup-rawWGSmets.txt \
R=in.BFHE_WA336010.fasta \
INCLUDE_BQ_HISTOGRAM=true

# Collect more metrics

module load gcc/4.8.2-fasrc01 R/3.3.0-fasrc02

java  -Xmx19g -jar /n/home12/pcwang/picard/picard-2.8.0/picard.jar CollectMultipleMetrics \
I={SAMPLE}-sort-head-dup.bam \
O={SAMPLE}-sort-head-dup-multimets \
R=in.BFHE_WA336010.fasta

# Copy bams to GATK dir

cp -r {SAMPLE}-sort-head-dup.bam /n/regal/edwards_lab/jburley/GATK

# Index bams to prepare for HaplotypeCaller

# Now run HaplotypeCaller and Depth of Coverage separately for each sample

