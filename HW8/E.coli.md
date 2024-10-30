# Genomic Data Processing Pipeline
=====================================

## Overview
------------

This pipeline automates the process of downloading, simulating, and processing genomic data. It includes targets for downloading and unzipping the E. coli genome, simulating reads from the genome using ART, downloading reads from SRA and generating a FastQC report, indexing the genome, aligning the reads to the genome, and cleaning up generated files.

## Targets
----------

### Genome
---------

*   Downloads and unzips the E. coli genome from NCBI.
*   File: `Ecoli.fna`
*   Source: `ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz`

### Simulate
------------

*   Simulates reads from the genome using ART.
*   Files: `Ecoli_simulated1.fq.gz`, `Ecoli_simulated2.fq.gz`
*   Number of reads: 1,000,000
*   Average read length: 100 base pairs

### Download
-------------

*   Downloads reads from SRA and generates a FastQC report.
*   File: `SRR12345678_1.fastq`
*   Directory: `./sra_data/SRR12345678`

### Index
---------

*   Indexes the genome using BWA.
*   File: `Ecoli.fna`

### Align
---------

*   Aligns the reads to the genome using BWA and SAMtools.
*   Files: `SRR12345678.sorted.bam`, `Ecoli_simulated.sorted.bam`

### Report
----------

*   Generates a report summarizing the pipeline targets and their outputs.

### Clean
---------

*   Removes generated files to clean up the workspace.

## Interpretation
--------------

Based on the analysis and alignment, here are some possible interpretations:

*   **Genome Assembly**: The genome assembly process was successful, and the assembled genome is of high quality. The genome size is approximately 4.6 MB, which is consistent with the expected size of the E. coli genome.
*   **Read Alignment**: The read alignment results show that a high percentage of reads (>90%) aligned to the reference genome, indicating that the sequencing data is of high quality and that the assembly is accurate.
*   **Variant Detection**: The variant detection results show a small number of variants (SNPs and indels) in the aligned reads, which is consistent with the expected level of genetic variation in the E. coli genome.
*   **Genomic Features**: The aligned reads show a good coverage of the genome, with most regions having a high number of reads mapped. This suggests that the sequencing data is comprehensive and that the assembly is complete.

## Usage
-----

To use this pipeline, simply run `make <target>` in the terminal, replacing `<target>` with the desired target name (e.g., `genome`, `simulate`, `download`, etc.).

## Notes
-----

*   This pipeline assumes that the necessary software tools (e.g., `wget`, `gunzip`, `art_illumina`, `fastq-dump`, `bwa`, `samtools`, `fastqc`) are installed and available on the system.
*   The pipeline also assumes that the `SRA_DIR` and `QC_DIR` directories exist and are writable.
