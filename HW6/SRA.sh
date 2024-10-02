
#!/bin/bash

# Install necessary tools
brew install sratoolkit
brew install fastqc
brew install trimmomatic

# Define variables
SRA_ID="SRR12345678"  
OUTPUT_DIR="./sra_data"
FASTQ_FILE="${./sra_data}/${SRR12345678}.fastq"

# Output directory
mkdir -p ./sra_data

# Download SRA data
echo "Downloading SRA data..."
fastq-dump --outdir ./sra_data --gzip --skip-technical --readids --dumpbase --split-files --clip $SRR12345678

# Initial quality control
echo "Performing initial quality control..."
fastqc -o $./sra_data ${./sra_data}/${SRR12345678}_1.fastq.gz ${./sra_data}/${SRR12345678}_2.fastq.gz

# Improve quality of reads using Trimmomatic
echo "Improving quality of reads..."
trimmomatic PE -phred33 \
  ${./sra_data}/${SRR12345678}_1.fastq.gz ${./sra_data}/${SRR12345678}_2.fastq.gz \
  ${./sra_data}/${SRR12345678}_1_paired.fastq.gz ${./sra_data}/${SRR12345678}_1_unpaired.fastq.gz \
  ${./sra_data}/${SRR12345678}_2_paired.fastq.gz ${./sra_data}/${SRR12345678}_2_unpaired.fastq.gz \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

# Quality control after trimming
echo "Performing quality control after trimming..."
fastqc -o $./sra_data ${./sra_data}/${SRR12345678}_1_paired.fastq.gz ${./sra_data}/${SRR12345678}_2_paired.fastq.gz

# To replace SRR data, I have replaced my SRR with the following variable and run the same steps above:

# New variables
SRA_ID="SRR925811" 
OUTPUT_DIR="./r_sra_data"ec

"Analysis complete. 
