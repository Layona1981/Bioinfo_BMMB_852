
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


### The project directory contained the following files:

- `Makefile`: The main file that defines the tasks.
- `README.md`: This documentation file.
- `design.csv`: A CSV file listing the samples to process.

## Usage

I run the entire workflow, and execute the following command in my terminal:

```bash
make all
```

### Available Targets

- `all`: Runs all tasks in sequence.
- `genome`: Downloads the Klebsiella genome and prepares the necessary files.
- `download`: Downloads specified SRR data using `fastq-dump`.
- `index`: Indexes the genome for alignment.
- `align`: Aligns the downloaded reads to the genome and calls variants.
- `merge_vcf`: Merges the resulting VCF files into a single file.
- `clean`: Cleans up generated files, removing all intermediate outputs.
- `help`: Lists all available targets and their descriptions.

## Notes

- Ensure you have sufficient disk space for downloading and processing the genome data and reads.
- If you encounter any issues, check the output messages for guidance on what went wrong.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

### Discussion of the VCF File

The resulting VCF (Variant Call Format) file contains information about the variants detected in the aligned sequencing data. Here are some points to consider:

- **Content**: The VCF file includes various fields such as chromosome position, reference allele, alternate allele, quality scores, and genotype information for each sample.
- **Variants**: Look for SNPs (single nucleotide polymorphisms) and indels (insertions/deletions). The number and type of variants can provide insights into genetic diversity, mutations, and potential associations with traits or diseases.
- **Quality**: Evaluate the quality scores for the variants to determine their reliability. High-quality variants are more likely to be true positives.
- **Comparative Analysis**: If you have multiple samples, compare the VCF files to identify common and unique variants across samples.

This complete setup should allow you to successfully run your project from downloading the genome to processing the samples and analyzing the VCF output.
