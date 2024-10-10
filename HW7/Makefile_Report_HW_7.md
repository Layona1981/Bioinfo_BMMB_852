
# Makefile Report

## Introduction

This report explains the Makefile designed to automate the process of downloading, simulating, trimming, and generating FastQC reports for genomic data. The Makefile integrates previous scripts into a single automated workflow.

## Makefile Structure

The Makefile consists of several targets, each responsible for a specific task. The main targets are:

- `usage`: Prints the help message with available targets.
- `genome`: Downloads the genome file from Ensembl.
- `simulate`: Simulates reads for the downloaded genome using a custom script.
- `download`: Downloads reads from the SRA using the accession number.
- `trim`: Trims the downloaded or simulated reads using Trimmomatic.
- `fastqc`: Generates FastQC reports for quality assessment of the reads.
- `clean`: Cleans up all generated files to reset the workspace.

## Variables

The Makefile uses several variables for flexibility and ease of modification:

- `R1` and `R2`: The first and second read files, respectively.
- `SRR`: The accession number for downloading reads from the SRA.
- `ACC`: The URL or accession number for downloading the genome.
- `GENOME`: The name of the resulting genome file.
- `N`: The number of reads to simulate.

## Running the Makefile

To execute the tasks defined in the Makefile, use the following commands:

- To download the genome:
  ```bash
  make genome
  ```

- To simulate reads:
  ```bash
  make simulate
  ```

- To download reads from SRA:
  ```bash
  make download
  ```

- To trim the reads:
  ```bash
  make trim
  ```

- To generate FastQC reports:
  ```bash
  make fastqc
  ```

- To clean up generated files:
  ```bash
  make clean
  ```

## Conclusion

This Makefile provides a streamlined and automated approach to managing genomic data workflows. By using variables and modular targets, it is easy to adapt and extend for different datasets and analysis requirements.
