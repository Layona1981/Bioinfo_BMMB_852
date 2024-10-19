# Variables
R1 := Ecoli_simulated1.fq.gz
R2 := Ecoli_simulated2.fq.gz
SRR := SRR12345678
ACC := ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
GENOME := Ecoli.fna
N := 1000000
FASTQC_CMD := fastqc
TRIMMOMATIC_JAR := /path/to/Trimmomatic-0.39/trimmomatic-0.39.jar
ADAPTER_FILE := /path/to/Trimmomatic-0.39/adapters/TruSeq3-SE.fa
SRA_DIR := ./sra_data/$(SRR)
QC_DIR := ./qcreports
TRIM_DIR := $(SRA_DIR)/trimmed

# Tools
BWA := bwa
SAMTOOLS := samtools

# Targets
.PHONY: usage genome download trim index align fastqc

# Help
usage:
	@echo "Makefile targets:"
	@echo "  genome   - Download and unzip the genome"
	@echo "  download - Download reads from SRA"
	@echo "  trim     - Trim reads using Trimmomatic"
	@echo "  index    - Index the reference genome"
	@echo "  align    - Align reads to the reference genome"
	@echo "  fastqc   - Generate FastQC reports"

# Download genome
genome:
	mkdir -p genome_data
	cd genome_data && wget $(ACC)
	cd genome_data && gunzip $(GENOME)

# Download reads from SRA and run FastQC
download:
	mkdir -p $(SRA_DIR) $(QC_DIR)
	fastq-dump --split-files --outdir $(SRA_DIR) $(SRR)
	$(FASTQC_CMD) $(SRA_DIR)/$(SRR)_1.fastq -o $(QC_DIR)

# Trim reads using Trimmomatic and run FastQC
trim: download
	@echo "Trimming reads with Trimmomatic..."
	mkdir -p $(TRIM_DIR)
	java -jar $(TRIMMOMATIC_JAR) SE -threads 4 $(SRA_DIR)/$(SRR)_1.fastq $(TRIM_DIR)/$(SRR)_trimmed.fastq \
	  ILLUMINACLIP:$(ADAPTER_FILE):2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	$(FASTQC_CMD) $(TRIM_DIR)/$(SRR)_trimmed.fastq -o $(QC_DIR)

# Index the reference genome
index: genome
	@echo "Indexing the reference genome with BWA..."
	$(BWA) index genome_data/$(GENOME)

# Align the reads to the reference genome and sort the BAM files
align: index trim
	mkdir -p alignments
	@echo "Aligning reads to the reference genome..."
	$(BWA) mem genome_data/$(GENOME) $(TRIM_DIR)/$(SRR)_trimmed.fastq | $(SAMTOOLS) view -Sb - > alignments/$(SRR)_aligned.bam
	$(SAMTOOLS) sort alignments/$(SRR)_aligned.bam -o alignments/$(SRR)_aligned_sorted.bam
	$(SAMTOOLS) index alignments/$(SRR)_aligned_sorted.bam

# Generate FastQC reports
fastqc: trim
	@echo "Running FastQC on trimmed reads..."
	$(FASTQC_CMD) $(TRIM_DIR)/$(SRR)_trimmed.fastq -o $(QC_DIR)
