
## Klebsiella Genome Variant Calling Project

This project involves downloading the Klebsiella genome, simulating the sequencing reads, aligning them, and calling variants. The entire process is managed through a Makefile for ease of use.


### The project directory contained the following files:

- `Makefile`: The main file that defines the tasks.
- `README.md`: This documentation file.
- `design.csv`: A CSV file listing the samples to process.

### Prerequisites
Before running the Makefile, the following tools have to be installed:
- `curl`: For downloading genomic data.
- `unzip`: To extract downloaded zip files.
- `bwa`: To sequence alignment.
- `samtools`: For manipulating SAM/BAM files.
- `bcftools`: For variant calling and VCF file manipulation.
- `SRA-tools`: For downloading SRR data (specifically `fastq-dump`).
- `VCF-merge`: For merging VCF files
- `art`: For simulating sequencing reads.
- `parallel`: For executing commands in parallel



### Available Targets

- `all`: Runs all tasks in sequence.
- `genome`: Downloads the Klebsiella genome and prepares the necessary files.
- `download`: Downloads specified SRR data using `fastq-dump`.
- `index`: Indexes the genome for alignment.
- `align`: Aligns the downloaded reads to the genome and calls variants.
- `merge_vcf`: Merges the resulting VCF files into a single file.
- `clean`: Cleans up generated files, removing all intermediate outputs.
- `help`: Lists all available targets and their descriptions.

### Genome Analysis Workflow

This project provides a Makefile for performing genome analysis, including downloading genomic data, simulating sequencing reads, aligning reads, calling variants, and generating summary reports.


### Discussion of the VCF File

The resulting VCF file contains information about the variants detected in the aligned sequencing data. Here are some points to consider:

- `Content`: The VCF file includes various fields such as chromosome position, reference allele, alternate allele, quality scores, and genotype information for each sample.
- `Variants`: Look for SNPs (single nucleotide polymorphisms) and indels (insertions/deletions). The number and type of variants can provide insights into genetic diversity, mutations, and potential associations with traits or diseases.
- **Quality**: Evaluate the quality scores for the variants to determine their reliability. High-quality variants are more likely to be true positives.
- **Comparative Analysis**: If you have multiple samples, compare the VCF files to identify common and unique variants across samples.

This complete setup should allow you to successfully run your project from downloading the genome to processing the samples and analyzing the VCF output.
