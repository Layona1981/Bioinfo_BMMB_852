
# Makefile for Genome Analysis and Read Processing

# Variables
R1 = Ecoli_simulated1.fq.gz
R2 = Ecoli_simulated2.fq.gz
SRR = SRR12345678
ACC = ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
GENOME = Ecoli.fna
N = 1000000
FASTQC_CMD = fastqc
TRIMMOMATIC_JAR = /path/to/Trimmomatic-0.39/trimmomatic-0.39.jar
ADAPTER_FILE = /path/to/Trimmomatic-0.39/adapters/TruSeq3-SE.fa
SRA_DIR = ./sra_data/$(SRR)
QC_DIR = ./qcreports
TRIM_DIR = $(SRA_DIR)/trimmed

# Targets
.PHONY: usage genome simulate download trim report clean

usage:
	@echo "Usage:"
	@echo "  make genome     - Download the genome"
	@echo "  make simulate   - Simulate reads for the genome"
	@echo "  make download   - Download reads from SRA"
	@echo "  make trim       - Trim reads"
	@echo "  make report     - Generate a report"
	@echo "  make clean      - Clean up generated files"

genome:
	wget $(ACC) -O $(GENOME).gz
	gunzip $(GENOME).gz
	@echo "Genome downloaded and unzipped."
	@echo "Size of the FASTA file:"
	du -h $(GENOME)

simulate:
	art_illumina -ss HS25 -i $(GENOME) -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
	gzip Ecoli_simulated1.fq Ecoli_simulated2.fq
	@echo "Simulated reads generated and compressed."
	@echo "Number of reads generated: $$(($(N) / 100))"
	@echo "Average read length: 100 base pairs"
	@echo "Compressed size of the FASTQ files:"
	du -h Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz

download:
	mkdir -p $(SRA_DIR)
	fastq-dump --split-files --outdir $(SRA_DIR) $(SRR)
	$(FASTQC_CMD) $(SRA_DIR)/$(SRR)_1.fastq -o $(QC_DIR)
	@echo "SRA data downloaded and initial FastQC report generated."

trim:
	mkdir -p $(TRIM_DIR) $(QC_DIR)
	java -jar $(TRIMMOMATIC_JAR) SE -threads 4 \
	  $(SRA_DIR)/$(SRR)_1.fastq $(TRIM_DIR)/$(SRR)_trimmed.fastq \
	  ILLUMINACLIP:$(ADAPTER_FILE):2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	$(FASTQC_CMD) $(TRIM_DIR)/$(SRR)_trimmed.fastq -o $(QC_DIR)
	@echo "Reads trimmed and FastQC report generated for trimmed data."

report:
	@echo "This Makefile automates the process of downloading, simulating, and processing genomic data."
	@echo "Targets:"
	@echo "  genome: Downloads and unzips the E. coli genome."
	@echo "  simulate: Simulates reads from the genome using ART."
	@echo "  download: Downloads reads from SRA and generates a FastQC report."
	@echo "  trim: Trims the downloaded reads and generates a FastQC report."
	@echo "  clean: Removes generated files to clean up the workspace."

clean:
	rm -rf $(GENOME) Ecoli_simulated*.fq.gz $(SRA_DIR) $(QC_DIR) $(TRIM_DIR)
	@echo "Cleaned up generated files."
