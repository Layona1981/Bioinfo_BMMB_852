
# Variables
SRR_IDS = SRR31316866 SRR31447817 SRR31486905  # List of SRR datasets
ACC = https://api.ncbi.nlm.nih.gov/datasets/v2/genome/accession/GCF_020099175.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF&include_annotation_type=RNA_FASTA&include_annotation_type=CDS_FASTA&include_annotation_type=PROT_FASTA&include_annotation_type=SEQUENCE_REPORT&hydrated=FULLY_HYDRATED
GENOME_FASTA = GCF_020099175.1_Klebsiella_genome.fna  
GENOME_GFF = GCF_020099175.1_Klebsiella_annotations.gff 
SRA_DATA_DIR = sra_data
VCF_OUTPUT = merged_variants.vcf  # Output file for merged VCF

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

# Target to merge VCF files
merge_vcf:
	@echo "Merging VCF files..."
	vcf-merge $(SRR_IDS:_variants.vcf) > $(VCF_OUTPUT)
	@echo "Merged VCF file created: $(VCF_OUTPUT)."

# Target to download SRR data
download:
	mkdir -p $(SRA_DATA_DIR)
	for SRR in $(SRR_IDS); do \
		fastq-dump $$SRR -O $(SRA_DATA_DIR)/; \
	done
	@echo "SRR data downloaded."

# Target to index the genome
index:
	bwa index $(GENOME_FASTA)
	@echo "Genome indexed."

# Target to align reads to the genome
align:
	for SRR in $(SRR_IDS); do \
		bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$$SRR.fastq | samtools view -bS - > $$SRR.bam; \
	done
	@echo "Reads aligned."

# Target to call variants from aligned reads
call_variants:
	for SRR in $(SRR_IDS); do \
		samtools sort $$SRR.bam -o $$SRR.sorted.bam; \
		bcftools mpileup -f $(GENOME_FASTA) $$SRR.sorted.bam | bcftools call -mv -o $$SRR_variants.vcf; \
	done
	@echo "Variants called."

# Target to clean up generated files
clean:
	rm -f *.bam *.sorted.bam *.vcf *.fq.gz
	@echo "Cleaned up generated files."

# Help target to list available commands
help:
	@echo "Available targets:"
	@echo "  all             - Run all tasks."
	@echo "  genome          - Download and prepare the genome."
	@echo "  download        - Download SRR data."
	@echo "  index           - Index the genome."
	@echo "  align           - Align reads to the genome."
	@echo "  call_variants   - Call variants from aligned reads."
	@echo "  merge_vcf       - Merge VCF files."
	@echo "  clean           - Clean up generated files."
	@echo "  help            - Show this help message."
