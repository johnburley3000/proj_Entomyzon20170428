#!/bin/bash

#SBATCH -p serial_requeue
#SBATCH -n 16
#SBATCH -N 1
#SBATCH --mem 15000
#SBATCH -t 2:00:00
#SBATCH -J trimFastq_jb
#SBATCH -o trim_%j.out
#SBATCH -e trim_%j.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu

#trims Illumina adaptors from paired-end sequencing using Trimmomatic
#may need to adjust parameters for specific circumstances
#requires Trimmomatic 0.32 or greater
#requires all fastq files to be trimmed to use the same adaptor file and be in the same directory

#this is based on a local install of Trimmomatc; change $TRIMPATH as necessary

#TRIMPATH=~/sw/progs/Trimmomatic-0.32/trimmomatic-0.32.jar
#TRIMPATH=/n/sw/odyssey-apps/modules-3.2.6/Modules/modulefiles/centros6/Trimmomatic-0.32:
TRIMPATH=/n/sw/centos6/Trimmomatic-0.32/trimmomatic-0.32.jar

DATE=`date +%Y-%m-%d`
mkdir logs/trim


#make adapter file; assumes that all fastq files to be trimmed use the same adaptor sequence
#note that this current file merges nextera and other adapters which should be okay but may not be ideal for final processing
#nextera sequences are derived from files distributed with Trimmomatic but look correct
if [ ! -s adapters.fa ]
then
	echo -e ">PrefixPE/1\nAATGATACGGCGACCACCGAGATCTACACTCTTTCCCTACACGACGCTCTTCCGATCT\n>PrefixPE/2\nGATCGGAAGAGCACACGTCTGAACTCCAGTCAC" > adapters.fa #Apollo
	echo -e ">PrefixNX/1\nAGATGTGTATAAGAGACAG\n>PrefixNX/2\nAGATGTGTATAAGAGACAG" >> adapters.fa #Nextera
	echo -e ">Trans1\nTCGTCGGCAGCGTCAGATGTGTATAAGAGACAG\n>Trans1_rc\nCTGTCTCTTATACACATCTGACGCTGCCGACGA\n>Trans2\nGTCTCGTGGGCTCGGAGATGTGTATAAGAGACAG\n>Trans2_rc\nCTGTCTCTTATACACATCTCCGAGCCCACGAGAC\n" >> adapters.fa #Nextera
fi

#specify the name of the first pair as the first argument on the command line and the base name for the output as the second argument

INSTEM=$1

java -jar $TRIMPATH PE -threads 16 -trimlog logs/trim/${DATE}_${INSTEM} -basein data/untrimmed/${INSTEM}_R1_L5.fastq.gz -baseout data/trimmed/${INSTEM}_trimmed_R1_L5.fastq.gz ILLUMINACLIP:adapters.fa:2:30:10:1:true

