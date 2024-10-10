# FastQC Workflow Makefile

This Makefile automates the process of downloading raw sequencing data, performing quality trimming, and generating FastQC reports for quality control analysis.

## Workflow Overview

The workflow consists of three main steps:
1. **Download**: Fetch raw sequencing data files.
2. **Trim**: Perform quality trimming on the raw data using Trimmomatic.
3. **FastQC**: Generate quality control reports using FastQC.

## Directory Structure

- **RAW_DATA_DIR**: Directory for storing raw data files.
- **TRIMMED_DATA_DIR**: Directory for storing trimmed data files.
- **FASTQC_REPORT_DIR**: Directory for storing FastQC reports.

## Configuration

- **R1**: Name of the first raw data file (e.g., `Ecoli_simulated1.fq.gz`).
- **R2**: Name of the second raw data file (e.g., `Ecoli_simulated2.fq.gz`).

## Makefile Targets

- **all**: Executes the entire workflow (download, trim, fastqc).
- **download**: Downloads the raw FASTQ files.
- **trim**: Trims the downloaded FASTQ files.
- **fastqc**: Runs FastQC on the trimmed FASTQ files.
- **clean**: Removes all generated files to clean up the directories.

## Usage

To execute the full workflow, open a terminal and run:

```bash
make all
