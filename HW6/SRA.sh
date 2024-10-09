
#!/bin/bash

# Set error handling and trace
set -uex

# SRA accession number
SRA_ID="SRR12345678"

# Directories
SRA_DIR=~/sra_data/${SRA_ID}
QC_DIR=~/qcreports
TRIM_DIR=${SRA_DIR}/trimmed

# Files
SRA_FILE_1=${SRA_DIR}/${SRA_ID}_1.fastq
TRIMMED_FILE=${SRA_DIR}/${SRA_ID}_trimmed.fastq
IMPROVED_TRIMMED_FILE=${SRA_DIR}/${SRA_ID}_trimmed_improved.fastq

# Trimmomatic jar location and adapter file
TRIMMOMATIC_JAR=${SRA_DIR}/Trimmomatic-0.39/trimmomatic-0.39.jar
ADAPTER_FILE=${SRA_DIR}/Trimmomatic-0.39/adapters/TruSeq3-SE.fa

# FastQC command
FASTQC_CMD="fastqc"

# Create necessary directories
mkdir -p ${SRA_DIR} ${QC_DIR} ${TRIM_DIR}

# Step 1: Download the SRA data
fastq-dump --split-files --outdir ${SRA_DIR} ${SRA_ID}

# Step 2: Run initial FastQC analysis on untrimmed data
${FASTQC_CMD} ${SRA_FILE_1} -o ${QC_DIR}

# Step 3: Run Trimmomatic for the first round of trimming
java -jar ${TRIMMOMATIC_JAR} SE -threads 4 \
  ${SRA_FILE_1} ${TRIMMED_FILE} \
  ILLUMINACLIP:${ADAPTER_FILE}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Step 4: Run FastQC on the first trimmed output
${FASTQC_CMD} ${TRIMMED_FILE} -o ${QC_DIR}

# Step 5: Run Trimmomatic again with more stringent parameters
java -jar ${TRIMMOMATIC_JAR} SE -threads 4 \
  ${SRA_FILE_1} ${IMPROVED_TRIMMED_FILE} \
  ILLUMINACLIP:${ADAPTER_FILE}:2:30:10 LEADING:5 TRAILING:5 SLIDINGWINDOW:4:20 MINLEN:50

# Step 6: Run FastQC on the more aggressively trimmed output
${FASTQC_CMD} ${IMPROVED_TRIMMED_FILE} -o ${QC_DIR}


echo "done"
