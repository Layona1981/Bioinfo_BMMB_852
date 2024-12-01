
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
Sure! Below is a complete Makefile along with a README.md file, a design.csv file, and a discussion of the resulting VCF file.

### Complete Makefile

Here’s a Makefile that achieves the tasks you specified:

```makefile
# Variables
ACC = https://api.ncbi.nlm.nih.gov/datasets/v2/genome/accession/GCF_020099175.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF
GENOME_FASTA = GCF_020099175.1_Klebsiella_genome.fna
GENOME_GFF = GCF_020099175.1_Klebsiella_annotations.gff
SRA_DATA_DIR = sra_data
DESIGN_CSV = design.csv
VCF_OUTPUT = merged_variants.vcf
SAMPLES = $(shell cut -d, -f1 $(DESIGN_CSV))

# Targets
.PHONY: all genome download index align call_variants merge_vcf clean help

# Default target
all: genome download index align call_variants merge_vcf

# Target to download and prepare the genome
genome:
	@echo "Downloading genome..."
	curl -L "$(ACC)" -o genome_data.zip
	unzip genome_data.zip -d genome_data
	mv genome_data/ncbi_dataset/data/GCF_020099175.1/GCF_020099175.1_ASM2009917v1_genomic.fna $(GENOME_FASTA)
	mv genome_data/ncbi_dataset/data/GCF_020099175.1/genomic.gff $(GENOME_GFF)
	rm -rf genome_data genome_data.zip
	@echo "Genome downloaded and files renamed to $(GENOME_FASTA) and $(GENOME_GFF)."

# Target to download SRR data
download:
	mkdir -p $(SRA_DATA_DIR)
	@echo "Downloading SRR data..."
	while IFS=, read -r sample; do \
		fastq-dump $$sample -O $(SRA_DATA_DIR)/; \
	done < $(DESIGN_CSV)
	@echo "SRR data downloaded."

# Target to index the genome
index:
	bwa index $(GENOME_FASTA)
	@echo "Genome indexed."

# Target to align reads to the genome and call variants
align:
	@echo "Aligning reads and calling variants..."
	for sample in $(SAMPLES); do \
		bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$$sample.fastq | samtools view -bS - > $$sample.bam; \
		samtools sort $$sample.bam -o $$sample.sorted.bam; \
		samtools mpileup -uf $(GENOME_FASTA) $$sample.sorted.bam | bcftools call -mv -Oz -o $$sample.vcf.gz; \
	done
	@echo "Alignment and variant calling completed."

# Target to merge VCF files
merge_vcf:
	@echo "Merging VCF files..."
	vcf-merge $(addsuffix .vcf.gz, $(SAMPLES)) > $(VCF_OUTPUT)
	@echo "Merged VCF file created: $(VCF_OUTPUT)."

# Clean target to remove generated files
clean:
	rm -f *.bam *.vcf.gz *.sorted.bam *.vcf
	rm -f $(GENOME_FASTA) $(GENOME_GFF)
	@echo "Cleaned up generated files."

# Help target
help:
	@echo "Available targets:"
	@echo "  all               - Run all tasks."
	@echo "  genome            - Download and prepare the genome."
	@echo "  download          - Download SRR data."
	@echo "  index             - Index the genome."
	@echo "  align             - Align reads and call variants."
	@echo "  merge_vcf        - Merge VCF files into one."
	@echo "  clean             - Remove generated files."
	@echo "  help              - Show this help message."
```

### Sample `design.csv` File

Create a `design.csv` file that lists the SRR samples you want to process:

```csv
SRR31316866
SRR31447817
SRR31486905
```

### README.md File

Here’s a README.md file that explains how to run the Makefile:

```markdown
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

You can install these tools using package managers like `apt`, `brew`, or by downloading them from their respective websites.

## File Structure

The project directory should contain the following files:

- `Makefile`: The main file that defines the tasks.
- `README.md`: This documentation file.
- `design.csv`: A CSV file listing the samples to process.

## Usage

To run the entire workflow, simply execute the following command in your terminal:

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

## Example Workflow

1. **Prepare the `design.csv` file**: Add the SRR samples you want to process.
2. **Run the entire workflow**:
   ```bash
   make all
   ```
3. **Clean Up**:
   ```bash
   make clean
   ```

## Notes

- Ensure you have sufficient disk space for downloading and processing the genome data and reads.
- If you encounter any issues, check the output messages for guidance on what went wrong.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```

### Discussion of the VCF File

The resulting VCF (Variant Call Format) file contains information about the variants detected in the aligned sequencing data. Here are some points to consider:

- **Content**: The VCF file includes various fields such as chromosome position, reference allele, alternate allele, quality scores, and genotype information for each sample.
- **Variants**: Look for SNPs (single nucleotide polymorphisms) and indels (insertions/deletions). The number and type of variants can provide insights into genetic diversity, mutations, and potential associations with traits or diseases.
- **Quality**: Evaluate the quality scores for the variants to determine their reliability. High-quality variants are more likely to be true positives.
- **Comparative Analysis**: If you have multiple samples, compare the VCF files to identify common and unique variants across samples.

This complete setup should allow you to successfully run your project from downloading the genome to processing the samples and analyzing the VCF output.
