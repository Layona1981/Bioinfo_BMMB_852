
### Quality Control Analysis of SRA Data

## Introduction
This report documents the quality control analysis of sequencing data downloaded from the SRA database. The target organism for this analysis is the genome selected for the read simulation assignment.

## Data and Publication
The data corresponds to the sequencing run with SRR number `SRR12345678`. The publication associated with this dataset is Title of the Publication.

## Methods
### Downloading Data
The data was downloaded using the SRA Toolkit with the following command:
```bash
fastq-dump --outdir ./sra_data --gzip --skip-technical --readids --dumpbase --split-files --clip SRR12345678

Initial quality control was performed using FastQC:
fastqc -o ./sra_data ./sra_data/SRR12345678_1.fastq.gz ./sra_data/SRR12345678_2.fastq.gz


Reads were trimmed using Trimmomatic:
trimmomatic PE -phred33 \
  ./sra_data/SRR12345678_1.fastq.gz ./sra_data/SRR12345678_2.fastq.gz \
  ./sra_data/SRR12345678_1_paired.fastq.gz ./sra_data/SRR12345678_1_unpaired.fastq.gz \
  ./sra_data/SRR12345678_2_paired.fastq.gz ./sra_data/SRR12345678_2_unpaired.fastq.gz \
  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


Post-improvement quality control was performed using FastQC:
fastqc -o ./sra_data ./sra_data/SRR12345678_1_paired.fastq.gz ./sra_data/SRR12345678_2_paired.fastq.gz
