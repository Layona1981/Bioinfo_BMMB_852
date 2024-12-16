
# RNA-Seq Analysis Pipeline

## Overview
This project performs RNA-Seq analysis using data obtained from the SRA database for E.coli The analysis includes alignment of reads, counting features, and generating a count matrix.

## Requirements
- HISAT2
- SAMtools
- FeatureCounts (from Subread)
- R (for analysis and visualization)


## Genome and Annotation
- Genome FASTA: `GCF_020099175.1_ecoli_genome.fna`
- Genome GFF: `GCF_020099175.1_ecoli_annotations.gff`

## Steps
1. Download RNA-Seq data using SRA Toolkit.
2. Download genome and annotation files.
3. Align reads to the reference genome.
4. Convert SAM files to sorted BAM files.
5. Count features using FeatureCounts.
6. Analyze the count matrix in R.

## Results
The resulting count matrix shows consistent gene expression levels for certain genes.
