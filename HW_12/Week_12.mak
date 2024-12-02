# Variables
SRR1 = SRR31486904
SRR2 = SRR31447817
SRR3 = SRR31486905
ACC = https://api.ncbi.nlm.nih.gov/datasets/v2/genome/accession/GCF_020099175.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF&include_annotation_type=RNA_FASTA&include_annotation_type=CDS_FASTA&include_annotation_type=PROT_FASTA&include_annotation_type=SEQUENCE_REPORT&hydrated=FULLY_HYDRATED
GENOME_FASTA = GCF_020099175.1_Klebsiella_genome.fna  
GENOME_GFF = GCF_020099175.1_Klebsiella_annotations.gff 
SRA_DATA_DIR = sra_data
VCF_OUTPUT = merged_variants.vcf  # Output file for merged VCF

# Targets
.PHONY: all genome simulate download index align call_variants report clean help merge_vcf

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
merge_vcf: $(SRR1).vcf.gz $(SRR2).vcf.gz $(SRR3).vcf.gz
	@echo "Merging VCF files..."
	vcf-merge $(SRR1).vcf.gz $(SRR2).vcf.gz $(SRR3).vcf.gz > $(VCF_OUTPUT)
	@echo "Merged VCF file created: $(VCF_OUTPUT)."


# Target to simulate sequencing reads
simulate:
	art_illumina -ss HS25 -i $(GENOME_FASTA) -p -l 100 -f 10 -m 200 -s 10 -o Klebsiella_simulated_reads
	gzip Klebsiella_simulated_reads1.fq Klebsiella_simulated_reads2.fq
	@echo "Simulated reads generated."

# Target to download SRR data
download:
	mkdir -p $(SRA_DATA_DIR)
	fastq-dump $(SRR1) -O $(SRA_DATA_DIR)/
	fastq-dump $(SRR2) -O $(SRA_DATA_DIR)/
	fastq-dump $(SRR3) -O $(SRA_DATA_DIR)/
	@echo "SRR data downloaded."

# Target to index the genome
index:
	bwa index $(GENOME_FASTA)
	@echo "Genome indexed."

# Target to align reads to the genome
align:
	bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$(SRR1).fastq | samtools view -bS - > $(SRR1).bam
	bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$(SRR2).fastq | samtools view -bS - > $(SRR2).bam
	bwa mem $(GENOME_FASTA) $(SRA_DATA_DIR)/$(SRR3).fastq | samtools view -bS - > $(SRR3).bam
	@echo "Reads aligned."

# Target to call variants from aligned reads
call_variants:
	samtools sort $(SRR1).bam -o $(SRR1).sorted.bam
	samtools sort $(SRR2).bam -o $(SRR2).sorted.bam
	samtools sort $(SRR3).bam -o $(SRR3).sorted.bam
	bcftools mpileup -f $(GENOME_FASTA) $(SRR1).sorted.bam | bcftools call -mv -o $(SRR1)_variants.vcf
	bcftools mpileup -f $(GENOME_FASTA) $(SRR2).sorted.bam | bcftools call -mv -o $(SRR2)_variants.vcf
	bcftools mpileup -f $(GENOME_FASTA) $(SRR3).sorted.bam | bcftools call -mv -o $(SRR3)_variants.vcf
	@echo "Variants called."

# Target to generate a report (placeholder)
report:
	@echo "Generating report..."
	# Add commands to generate a report here
	@echo "Report generated."

# Target to clean up generated files
clean:
	rm -f *.bam *.sorted.bam *.vcf *.fq.gz
	@echo "Cleaned up generated files."

# Help target to list available commands
help:
	@echo "Available targets:"
	@echo "  all             - Run all tasks."
	@echo "  genome          - Download and prepare the genome."
	@echo "  simulate        - Simulate sequencing reads."
	@echo "  download        - Download SRR data."
	@echo "  index           - Index the genome."
	@echo "  align           - Align reads to the genome."
	@echo "  call_variants   - Call variants from aligned reads."
	@echo "  report          - Generate a report."
	@echo "  clean           - Clean up generated files."
