
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
TRIM_DIR := $(SRA_DIR)/trimmed

# Paths to tools
BWA := /linasallam/BIOHW/bwa
SAMTOOLS := /linasallam/BIOHW/samtools

# Targets
.PHONY: usage genome simulate download trim index align fastqc count_unaligned count_alignments count_properly_paired filter_bam compare_flagstats

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
	@echo "  count_unaligned - Count unaligned reads"
	@echo "  count_alignments - Count primary, secondary, and supplementary alignments"
	@echo "  count_properly_paired - Count properly paired alignments on the reverse strand"
	@echo "  filter_bam - Filter BAM file for properly paired primary alignments with mapping quality > 10"
	@echo "  compare_flagstats - Compare flagstats of original and filtered BAM files"

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

# Count unaligned reads
count_unaligned:
	@echo "Counting unaligned reads..."
	$(SAMTOOLS) view -c -f 4 $(BAM_SRA_SORTED)

# Count primary, secondary, and supplementary alignments
count_alignments:
	@echo "Counting primary, secondary, and supplementary alignments..."
	$(SAMTOOLS) view -c -F 256 $(BAM_SRA_SORTED)  # Primary
	$(SAMTOOLS) view -c -f 256 $(BAM_SRA_SORTED)  # Secondary
	$(SAMTOOLS) view -c -f 2048 $(BAM_SRA_SORTED) # Supplementary

# Count properly paired alignments on the reverse strand from the first pair
count_properly_paired:
	@echo "Counting properly paired alignments on the reverse strand from the first pair..."
	$(SAMTOOLS) view -c -f 99 $(BAM_SRA_SORTED)

# Filter BAM file for properly paired primary alignments with mapping quality > 10
filter_bam:
	@echo "Filtering BAM file for properly paired primary alignments with mapping quality > 10..."
	$(SAMTOOLS) view -h -f 2 -q 10 $(BAM_SRA_SORTED) | $(SAMTOOLS) view -Sb - > alignments/filtered.bam
	$(SAMTOOLS) sort alignments/filtered.bam -o alignments/filtered_sorted.bam
	$(SAMTOOLS) index alignments/filtered_sorted.bam

# Compare flagstats of original and filtered BAM files
compare_flagstats:
	@echo "Comparing flagstats of original and filtered BAM files..."
	$(SAMTOOLS) flagstat $(BAM_SRA_SORTED) > alignments/original_flagstat.txt
	$(SAMTOOLS) flagstat alignments/filtered_sorted.bam > alignments/filtered_flagstat.txt
	diff alignments/original_flagstat.txt alignments/filtered_flagstat.txt
