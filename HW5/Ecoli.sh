#!/bin/bash

# Set error handling and trace
set -uex

# ----- DEFINITIONS -----

# URL for downloading the Escherichia coli genome
GENOME_URL="ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz"

# Genome file name after download
GENOME_FILE="GCF_000005845.2_ASM584v2_genomic.fna.gz"

# Unzipped genome file name
UNZIPPED_GENOME_FILE="GCF_000005845.2_ASM584v2_genomic.fna"

# Simulated FASTQ file names
SIM_READS_1="simulated_reads_1.fastq"
SIM_READS_2="simulated_reads_2.fastq"
SIM_READS_1_GZ="${SIM_READS_1}.gz"
SIM_READS_2_GZ="${SIM_READS_2}.gz"

# Number of reads and read lengths for wgsim
NUM_READS=154656  # Adjusted for 10x coverage
READ_LENGTH_1=150
READ_LENGTH_2=150

# ----- ACTIONS -----

# Step 1: Download Escherichia coli genome
wget ${GENOME_URL}

# Step 2: Unzip the genome file
gunzip ${GENOME_FILE}

# Step 3: Check the size of the unzipped genome file
du -sh ${UNZIPPED_GENOME_FILE}

# Step 4: Get the total genome size in base pairs (excluding headers)
grep -v ">" ${UNZIPPED_GENOME_FILE} | wc -c

# Step 5: Count the number of chromosomes (or sequences)
grep ">" ${UNZIPPED_GENOME_FILE} | wc -l

# Step 6: Extract the names (IDs) and lengths of each chromosome
awk '/^>/{if (seqlen){print seqlen}; printf substr($0, 2, 30) " "; seqlen=0; next}{seqlen += length($0)}END{print seqlen}' ${UNZIPPED_GENOME_FILE}

# Step 7: Generate simulated FASTQ reads using wgsim
wgsim -N ${NUM_READS} -1 ${READ_LENGTH_1} -2 ${READ_LENGTH_2} ${UNZIPPED_GENOME_FILE} ${SIM_READS_1} ${SIM_READS_2}

# Step 8: Count the number of reads in the FASTQ files
grep -c "^@" ${SIM_READS_1}
grep -c "^@" ${SIM_READS_2}

# Step 9: Calculate the average read length for the first FASTQ file
awk 'NR%4==2 {sum+=length($0); count++} END {print "Average read length for simulated_reads_1.fastq: " sum/count " bp"}' ${SIM_READS_1}

# Step 9: Calculate the average read length for the second FASTQ file
awk 'NR%4==2 {sum+=length($0); count++} END {print "Average read length for simulated_reads_2.fastq: " sum/count " bp"}' ${SIM_READS_2}

# Step 10: Check the size of the generated FASTQ files
du -sh ${SIM_READS_1} ${SIM_READS_2}

# Step 11: Compress the FASTQ files
gzip ${SIM_READS_1} ${SIM_READS_2}

# Step 12: Check the size of the compressed FASTQ files
du -sh ${SIM_READS_1_GZ} ${SIM_READS_2_GZ}

