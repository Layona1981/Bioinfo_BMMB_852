# Variables
GENOME_URL = ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
GFF_URL = 
SRA_ID = 
GENOME_FILE = genome_data/Ecoli.fna
GFF_FILE = 
BAM_SRA = alignments/Ecoli.sorted.bam
FILTERED_BAM = alignments/Ecoli.filtered.bam

# Tools
BWA = bwa
SAMTOOLS = samtools
FASTQ_DUMP = fastq-dump

# Targets
.PHONY: usage genome sra_data index align stats filter compare clean unaligned primary_secondary_supplementary properly_paired_reverse filter_bam compare_flagstats

# Help
usage:
	@echo "Makefile targets:"
	@echo "  genome    - Download and unzip the genome and GFF annotation file"
	@echo "  sra_data  - Download SRA data for analysis"
	@echo "  index     - Index the reference genome with BWA"
	@echo "  align     - Align SRA reads to the reference genome"
	@echo "  stats     - Generate flagstats for the original BAM file"
	@echo "  filter    - Filter the BAM file"
	@echo "  compare   - Compare stats for original and filtered BAM files"
	@echo "  clean     - Remove all generated files to start fresh"
	@echo "  unaligned - Count reads that did not align with the reference genome"
	@echo "  primary_secondary_supplementary - Count primary, secondary, and supplementary alignments"
	@echo "  properly_paired_reverse - Count properly-paired alignments on the reverse strand for the first pair"
	@echo "  filter_bam - Create a new BAM file with properly paired primary alignments with mapping_quality >10"
	@echo "  compare_flagstats - Compare flagstats for original and filtered BAM files"

# Download and prepare the genome and annotation files
genome:
	mkdir -p genome_data
	wget $(GENOME_URL) -O genome_data/Ecoli.fna.gz
	gunzip genome_data/Ecoli.fna.gz

# Index the reference genome with BWA
index:
	$(BWA) index $(GENOME_FILE)

# Align the SRA reads to the reference genome and sort the BAM files
align:
	$(BWA) mem $(GENOME_FILE) Ecoli_simulated1.fq.gz | $(SAMTOOLS) view -Sb - | $(SAMTOOLS) sort -o $(BAM_SRA)
	$(SAMTOOLS) index $(BAM_SRA)

# Generate flagstat report for the original BAM file
stats:
	$(SAMTOOLS) flagstat $(BAM_SRA)

# Filter BAM file to retain properly paired primary alignments with a mapping_quality >10
filter:
	$(SAMTOOLS) view -h -f 2 -q 10 -b $(BAM_SRA) > $(FILTERED_BAM)
	$(SAMTOOLS) index $(FILTERED_BAM)

# Compare flagstats for original and filtered BAM files
compare:
	$(SAMTOOLS) flagstat $(BAM_SRA)
	$(SAMTOOLS) flagstat $(FILTERED_BAM)

# Run all the above targets
all: genome index align stats filter compare

# Clean up generated files
clean:
	rm -rf genome_data alignments

# Print usage message
usage:
	@echo "Usage: make <target>"

# Phony targets
.PHONY: all clean usage
```

-----
# Variables
GENOME_URL := ftp://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
GFF_URL := ftp://ftp.ensembl.org/pub/release-105/gff3/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.105.gff3.gz
SRA_ID := SRR387901
GENOME_FILE := genome_data/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
GFF_FILE := genome_data/Saccharomyces_cerevisiae.R64-1-1.105.gff3
BAM_SRA := alignments/sra_reads_sorted.bam
FILTERED_BAM := alignments/sra_reads_filtered.bam

# Tools
BWA := bwa
SAMTOOLS := samtools
FASTQ_DUMP := fastq-dump

# Targets
.PHONY: usage genome sra_data index align stats filter compare clean unaligned primary_secondary_supplementary properly_paired_reverse filter_bam compare_flagstats

# Help
usage:
	@echo "Makefile targets:"
	@echo "  genome    - Download and unzip the genome and GFF annotation file"
	@echo "  sra_data  - Download SRA data for analysis"
	@echo "  index     - Index the reference genome with BWA"
	@echo "  align     - Align SRA reads to the reference genome"
	@echo "  stats     - Generate flagstats for the original BAM file"
	@echo "  filter    - Filter the BAM file"
	@echo "  compare   - Compare stats for original and filtered BAM files"
	@echo "  clean     - Remove all generated files to start fresh"
	@echo "  unaligned - Count reads that did not align with the reference genome"
	@echo "  primary_secondary_supplementary - Count primary, secondary, and supplementary alignments"
	@echo "  properly_paired_reverse - Count properly-paired alignments on the reverse strand for the first pair"
	@echo "  filter_bam - Create a new BAM file with properly paired primary alignments with mapping quality >10"
	@echo "  compare_flagstats - Compare flagstats for original and filtered BAM files"

# Download and prepare the genome and annotation files
genome:
	mkdir -p genome_data
	@echo "Downloading reference genome..."
	wget -P genome_data $(GENOME_URL)
	@echo "Unzipping reference genome..."
	gunzip -f genome_data/*.fa.gz
	@echo "Downloading GFF annotation file..."
	wget -P genome_data $(GFF_URL)
	@echo "Unzipping GFF file..."
	gunzip -f genome_data/*.gff3.gz

# Download the SRA data
sra_data:
	mkdir -p sra_data
	@echo "Downloading SRA data..."
	$(FASTQ_DUMP) --split-files --outdir sra_data $(SRA_ID)

# Index the reference genome with BWA
index: genome
	@echo "Indexing the reference genome with BWA..."
	$(BWA) index $(GENOME_FILE)

# Align the SRA reads to the reference genome and sort the BAM files
align: index sra_data
	mkdir -p alignments
	@echo "Aligning SRA reads to the reference genome..."
	$(BWA) mem $(GENOME_FILE) sra_data/$(SRA_ID)_1.fastq | $(SAMTOOLS) view -Sb - > alignments/sra_reads.bam
	$(SAMTOOLS) sort alignments/sra_reads.bam -o $(BAM_SRA)
	$(SAMTOOLS) index $(BAM_SRA)

# Generate flagstat report for the original BAM file
stats: align
	@echo "Generating flagstats for the original BAM file..."
	$(SAMTOOLS) flagstat $(BAM_SRA)

# Filter BAM file to retain properly paired primary alignments with a mapping quality >10
filter: align
	@echo "Filtering BAM file..."
	$(SAMTOOLS) view -h -f 2 -q 10 -b $(BAM_SRA) > $(FILTERED_BAM)
	$(SAMTOOLS) index $(FILTERED_BAM)

# Compare flagstats for original and filtered BAM files
compare: filter
	@echo "Comparing flagstats for original and filtered BAM files..."
	@echo "Original BAM:"
	$(SAMTOOLS) flagstat $(BAM_SRA)
	@echo "Filtered BAM:"
	$(SAMTOOLS) flagstat $(FILTERED_BAM)

# Clean up all generated files to start fresh
clean:
	rm -rf genome_data sra_data alignments

# Count reads that did not align with the reference genome
unaligned: stats
	@echo "Counting reads that did not align with the reference genome..."
	@echo "$$(($(SAMTOOLS) flagstat $(BAM_SRA) | grep 'in total' | cut -d ' ' -f 1) - $(SAMTOOLS) flagstat $(BAM_SRA) | grep 'mapped (' | cut -d ' ' -f 1)) reads did not align with the reference genome."

# Count primary, secondary, and supplementary alignments
primary_secondary_supplementary: stats
	@echo "Counting primary, secondary, and supplementary alignments..."
	@echo "Primary alignments: $$(SAMTOOLS) flagstat $(BAM_SRA) | grep 'mapped (' | cut -d ' ' -f 1"
	@echo "Secondary alignments: $$(SAMTOOLS) flagstat $(BAM_SRA) | grep 'secondary' | cut -d ' ' -f 1"
	@echo "Supplementary alignments: $$(SAMTOOLS) flagstat $(BAM_SRA) | grep 'supplementary' | cut -d ' ' -f 1"

# Count properly-paired alignments on the reverse strand for the first pair
properly_paired_reverse: align
	@echo "Counting properly-paired alignments on the reverse strand for the first pair..."
	@echo "$$(SAMTOOLS) view -f 2 -F 256 -F 2048 -q 10 $(BAM_SRA) | grep -c '99'"

# Create a new BAM file with properly paired primary alignments with mapping quality >10
filter_bam: align
	@echo "Creating a new BAM file with properly paired primary alignments with mapping quality >10..."
	$(SAMTOOLS) view -h -f 2 -F 256 -F 2048 -q 10 -b $(BAM_SRA) > $(FILTERED_BAM)
	$(SAMTOOLS) index $(FILTERED_BAM)

# Compare flagstats for original and filtered BAM files
compare_flagstats: filter_bam
	@echo "Comparing flagstats for original and filtered BAM files..."
	@echo "Original BAM:"
	$(SAMTOOLS) flagstat $(BAM_SRA)
	@echo "Filtered BAM:"
	$(SAMTOOLS) flagstat $(FILTERED_BAM)
```
