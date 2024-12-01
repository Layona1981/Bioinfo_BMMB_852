
# Klebsiella Genome Variant Calling Project

This project involves downloading the Klebsiella genome, simulating the sequencing reads, aligning them, and calling variants. The entire process is managed through a Makefile for ease of use.

## Prerequisites

Ensure you have the following tools installed:

- **curl**: For downloading files from the internet.
- **unzip**: To extract downloaded zip files.
- **BWA**: For sequence alignment.
- **SAMtools**: For manipulating sequence data.
- **BCFtools**: For variant calling.
- **SRA-tools**: For downloading SRR data (specifically `fastq-dump`).
- **VCF-merge**: For merging VCF files.

I have installed these tools using a package manager `brew`

## File Structure

The project directory should contain the following files:

- `Makefile`: The main file that defines the tasks.
- `README.md`: This documentation file.
- `design.csv`: A CSV file listing the samples to process.

## Usage

To run the entire workflow, simply execute the following command in your terminal:

```bash
make all
