
#!/bin/bash

# Install necessary tools
brew install sratoolkit
brew install fastqc
brew install trimmomatic

# Define variables
SRA_ID="SRR12345678"  
OUTPUT_DIR="./sra_data"
FASTQ_FILE="${OUTPUT_DIR}/${SRA_ID}.fastq"

# Output directory
mkdir -p $OUTPUT_DIR

# Download SRA data
echo "Downloading SRA data..."
fastq-dump --outdir $OUTPUT_DIR --gzip --skip-technical --readids --dumpbase --split-files --clip $SRA_ID

# Initial quality control
echo "Performing initial quality control..."
fastqc -o $OUTPUT_DIR ${FASTQ_FILE}_1.fastq.gz ${FASTQ_FILE}_2.fastq.gz

# Improve quality of reads using Trimmomatic
echo "Improving quality of reads..."
trimmomatic PE -phred33 \
  ${FASTQ_FILE}_1.fastq.gz ${FASTQ_FILE}_2.fastq.gz \
  ${OUTPUT_DIR}/${SRA_ID}_1_paired.fastq.gz ${OUTPUT_DIR}/${SRA_ID}_1_unpaired.fastq.gz \
  ${OUTPUT_DIR}/${SRA_ID}_2_paired.fastq.gz ${OUTPUT_DIR}/${SRA_ID}_2_unpaired.fastq.gz \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Quality control after trimming
echo "Performing quality control after trimming..."
fastqc -o $OUTPUT_DIR ${OUTPUT_DIR}/${SRA_ID}_1_paired.fastq.gz ${OUTPUT_DIR}/${SRA_ID}_2_paired.fastq.gz

echo "Analysis complete. Check the $OUTPUT_DIR directory for results."
