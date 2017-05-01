
#!/bin/bash
#SBATCH -p general
#SBATCH --mem 100000
#SBATCH -n 32
#SBATCH -N 1
#SBATCH -t 24:00:00
#SBATCH -J runbwamem
#SBATCH -e runbwamem_%j.err
#SBATCH -o runbwamem_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=john.burley@evobio.eu
 
module load gcc/4.8.2-fasrc01 bwa/0.7.9a-fasrc02

#run bwa

### REQUIRES EDIT to source files

SAMPLE=$1

bwa mem -t 32 /n/edwards_lab/jburley/proj_Entomyzon20710428/data/BFHE_WA_336010.fasta \
/n/edwards_lab/jburley/proj_Entomyzon20710428/01_trim/data/trimmed/<something>$SAMPLE<something>.fasta.gz \
<pathtoreads>/something including read 1 > $SAMPLE.sam

#convert sam to bam:
module load samtools/1.4-fasrc01

samtools view  -Sb  $SAMPLE.sam -o $SAMPLE.bam


