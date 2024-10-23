

# Genome variables

GENOME_URL := ftp://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
GENOME_FILE_GZ := Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
GENOME_FILE := Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
SIM_READS_1 := simulated_reads_1.fastq
SIM_READS_2 := simulated_reads_2.fastq
TRIMMED_FILE := $(SRA_ID)_trimmed.fastq
IMPROVED_TRIMMED_FILE := $(SRA_ID)_trimmed_improved.fastq

# Variables for simulation

BAM_SIM := alignments/simulated_reads.bam
BAM_SRA := alignments/sra_reads.bam
BAM_SIM_SORTED := alignments/simulated_reads_sorted.bam
BAM_SRA_SORTED := alignments/sra_reads_sorted.bam
TRIMMOMATIC_VERSION := 0.39
TRIMMOMATIC_DIR := Trimmomatic-$(TRIMMOMATIC_VERSION)
TRIMMOMATIC_JAR := $(TRIMMOMATIC_DIR)/trimmomatic-$(TRIMMOMATIC_VERSION).jar
ADAPTER_FILE := $(TRIMMOMATIC_DIR)/adapters/TruSeq3-SE.fa
FASTQC_CMD := fastqc
SRA_DIR := sra_data/$(SRA_ID)
QC_DIR := qcreports
TRIM_DIR := $(SRA_DIR)/trimmedGENOME_URL := ftp://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
GENOME_FILE_GZ := Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
GENOME_FILE := Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
SIM_READS_1 := simulated_reads_1.fastq
SIM_READS_2 := simulated_reads_2.fastq
TRIMMED_FILE := $(SRA_ID)_trimmed.fastq
IMPROVED_TRIMMED_FILE := $(SRA_ID)_trimmed_improved.fastq
BAM_SIM := alignments/simulated_reads.bam
BAM_SRA := alignments/sra_reads.bam
BAM_SIM_SORTED := alignments/simulated_reads_sorted.bam
BAM_SRA_SORTED := alignments/sra_reads_sorted.bam
TRIMMOMATIC_VERSION := 0.39
TRIMMOMATIC_DIR := Trimmomatic-$(TRIMMOMATIC_VERSION)
TRIMMOMATIC_JAR := $(TRIMMOMATIC_DIR)/trimmomatic-$(TRIMMOMATIC_VERSION).jar
ADAPTER_FILE := $(TRIMMOMATIC_DIR)/adapters/TruSeq3-SE.fa
FASTQC_CMD := fastqc
SRA_DIR := sra_data/$(SRA_ID)
QC_DIR := qcreports
TRIM_DIR := $(SRA_DIR)/trimmed



# Targets
.PHONY: usage genome simulate download trim index align fastqc

# Help
usage:
	@echo "Makefile targets:"
	@echo "  genome   - Download and unzip the genome"
	@echo "  simulate - Simulate reads from the genome"
	@echo "  download - Download reads from SRA"
	@echo "  trim     - Trim reads using Trimmomatic"
	@echo "  index    - Index the reference genome"
	@echo "  align    - Align reads to the reference genome"
	@echo "  fastqc   - Generate FastQC reports"

# Download genome
genome:
	mkdir -p genome_data
	cd genome_data && wget $(GENOME_URL)
	cd genome_data && gunzip $(GENOME_FILE_GZ)

# Simulate reads from the genome
simulate: genome
	@echo "Simulating FASTQ reads..."
	wgsim -N 240000 -1 150 -2 150 genome_data/$(GENOME_FILE) $(SIM_READS_1) $(SIM_READS_2)

# Download Trimmomatic if not present
trimmomatic:
	@if [ ! -f "$(TRIMMOMATIC_JAR)" ]; then \
		echo "Downloading Trimmomatic..."; \
		wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-$(TRIMMOMATIC_VERSION).zip; \
		unzip Trimmomatic-$(TRIMMOMATIC_VERSION).zip; \
	fi

# Download reads from SRA and run FastQC
download:
	mkdir -p $(SRA_DIR) $(QC_DIR)   # Ensure both directories are created
	fastq-dump --split-files --outdir $(SRA_DIR) $(SRA_ID)
	$(FASTQC_CMD) $(SRA_DIR)/$(SRA_ID)_1.fastq -o $(QC_DIR)

# Trim reads using Trimmomatic with less aggressive parameters and run FastQC
trim: trimmomatic download
	@echo "Trimming reads with Trimmomatic..."
	mkdir -p $(TRIM_DIR)
	

# Index the reference genome
index: genome
	@echo "Indexing the reference genome with BWA..."
	$(BWA) index genome_data/$(GENOME_FILE)

# Align the reads to the reference genome and sort the BAM files
align: index trim simulate
	mkdir -p alignments
	@echo "Aligning simulated reads to the reference genome..."
	$(BWA) mem genome_data/$(GENOME_FILE) $(SIM_READS_1) $(SIM_READS_2) | $(SAMTOOLS) view -Sb - > $(BAM_SIM)
	$(SAMTOOLS) sort $(BAM_SIM) -o $(BAM_SIM_SORTED)
	$(SAMTOOLS) index $(BAM_SIM_SORTED)
	@echo "Aligning SRA reads to the reference genome..."
	$(BWA) mem genome_data/$(GENOME_FILE) $(SRA_DIR)/$(SRA_ID)_1.fastq | $(SAMTOOLS) view -Sb - > $(BAM_SRA)
	$(SAMTOOLS) sort $(BAM_SRA) -o $(BAM_SRA_SORTED)
	$(SAMTOOLS) index $(BAM_SRA_SORTED)

# Generate FastQC reports
fastqc: download trim
	@echo "Running FastQC on all trimmed reads..."
	$(FASTQC_CMD) $(TRIMMED_FILE) -o $(QC_DIR)
	$(FASTQC_CMD) $(IMPROVED_TRIMMED_FILE) -o $(QC_DIR)
