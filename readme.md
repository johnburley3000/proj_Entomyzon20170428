# Entomyzon cyanotis popualation genomics
*Written by: John Burley*
Date: 28 April  2017

## Description:
Series of scripts to take sequence data through mapping, processing, variant calling and various analyses.
The pipeline has to be easy to re-run  because more seq data from the same indvididuals will be added iteratively

Reminders: 
- keep a simple sample identifier consistent throughout: <sp>_<pop>_<acc_number> i.e. BFHE_WA_336010 (this is the reference genome)
- for steps un until <read mapping?>, keep a Read Direction identifier to designate forward and reverese reads. i.e. <sample>_R1 (for forward) 
- for steps up until <variant calling?>, keep a Lane identifier to designate independent sequencing runs

## Trimming:
Trimmomatic

## Read mapping:
BWA MEM

## Processing:
various - picard tools + others

## Variant Calling:
GATK HaplotypeCaller pipeline

