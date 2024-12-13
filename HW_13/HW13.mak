
# Makefile for Klebsiella RNA-Seq Analysis

# SRR dataset identifiers
SRR1 = SRR31486905
SRR2 = SRR31447817
SRR3 = SRR31316866 
ACC = https://api.ncbi.nlm.nih.gov/datasets/v2/genome/accession/GCF_020099175.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF&include_annotation_type=RNA_FASTA&include_annotation_type=CDS_FASTA&include_annotation_type=PROT_FASTA&include_annotation_type=SEQUENCE_REPORT&hydrated=FULLY_HYDRATED
GENOME_FASTA = GCF_020099175.1_Klebsiella_genome.fna  
GENOME_GFF = GCF_020099175.1_Klebsiella_annotations.gff 
SRA_DATA_DIR = sra_data
VCF_OUTPUT = merged_variants.vcf  # Output file for merged VCF
COUNT_MATRIX = count_matrix.tsv  # Output file for count matrix

# Targets
.PHONY: all genome download_sra align call_variants merge_vcf create_count_matrix clean

# Default target
all: genome download_sra align call_variants merge_vcf create_count_matrix

# Target to download and prepare the genome
genome:
	@echo "Downloading genome..."
	curl -L "$(ACC)" -o genome_data.zip
	unzip genome_data.zip -d genome_data
	mv genome_data/ncbi_dataset/data/GCF_020099175.1/GCF_020099175.1_ASM2009917v1_genomic.fna $(GENOME_FASTA)
	mv genome_data/ncbi_dataset/data/GCF_020099175.1/genomic.gff $(GENOME_GFF)
	rm -rf genome_data genome_data.zip
	@echo "Genome downloaded and files renamed to $(GENOME_FASTA) and $(GENOME_GFF)."

# Target to download SRA data
download_sra:
	@echo "Downloading SRA data..."
	mkdir -p $(SRA_DATA_DIR)  # Ensure the directory exists
	fasterq-dump $(SRR1) --outdir $(SRA_DATA_DIR)
	fasterq-dump $(SRR2) --outdir $(SRA_DATA_DIR)
	fasterq-dump $(SRR3) --outdir $(SRA_DATA_DIR)  # Download third dataset
	@echo "SRA data downloaded to $(SRA_DATA_DIR)."

# Target to align reads
align:
	@echo "Aligning reads..."
	bwa index $(GENOME_FASTA)
	bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$(SRR1).fastq $(SRA_DATA_DIR)/$(SRR2).fastq $(SRA_DATA_DIR)/$(SRR3).fastq > aligned_reads.sam
	@echo "Reads aligned to $(GENOME_FASTA)."

# Target to call variants
call_variants:
	@echo "Calling variants..."
	samtools view -bS aligned_reads.sam > aligned_reads.bam
	samtools sort aligned_reads.bam -o sorted_reads.bam
	samtools index sorted_reads.bam
	bcftools mpileup -f $(GENOME_FASTA) sorted_reads.bam | bcftools call -mv -o $(SRR1)_variants.vcf
	bcftools mpileup -f $(GENOME_FASTA) sorted_reads.bam | bcftools call -mv -o $(SRR2)_variants.vcf
	bcftools mpileup -f $(GENOME_FASTA) sorted_reads.bam | bcftools call -mv -o $(SRR3)_variants.vcf  # Call variants for third dataset
	@echo "Variants called and saved to $(SRR1)_variants.vcf, $(SRR2)_variants.vcf, and $(SRR3)_variants.vcf."

# Target to merge VCF files
merge_vcf: $(SRR1)_variants.vcf $(SRR2)_variants.vcf $(SRR3)_variants.vcf
	@echo "Merging VCF files..."
	vcf-merge $(SRR1)_variants.vcf $(SRR2)_variants.vcf $(SRR3)_variants.vcf > $(VCF_OUTPUT)
	@echo "Merged VCF file created: $(VCF_OUTPUT)."

# Target to create count matrix
create_count_matrix:
	@echo "Creating count matrix..."
	# Example using featureCounts from Subread package
	featureCounts -a $(GENOME_GFF) -o $(COUNT_MATRIX) sorted_reads.bam
	@echo "Count matrix created: $(COUNT_MATRIX)."

# Clean up generated files
clean:
	rm -rf $(SRA_DATA_DIR)/*.fastq aligned_reads.sam aligned_reads.bam sorted_reads.bam sorted_reads.bam.bai $(SRR1)_variants.vcf $(SRR2)_variants.vcf $(SRR3)_variants.vcf $(VCF_OUTPUT) $(COUNT_MATRIX)
	@echo "Cleaned up generated files."
