
# Makefile for Klebsiella RNA-Seq Analysis

# SRR dataset identifiers
SRR_IDS = SRR31447817 SRR31486905 SRR31316866
ACC = https://api.ncbi.nlm.nih.gov/datasets/v2/genome/accession/GCF_020099175.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF&include_annotation_type=RNA_FASTA&include_annotation_type=CDS_FASTA&include_annotation_type=PROT_FASTA&include_annotation_type=SEQUENCE_REPORT&hydrated=FULLY_HYDRATED
GENOME_FASTA = GCF_020099175.1_Klebsiella_genome.fna  
GENOME_GFF = GCF_020099175.1_Klebsiella_annotations.gff 
SRA_DATA_DIR = sra_data 

# Output count file
COUNTS_FILE = counts.txt

# Default target
all: $(COUNTS_FILE)

# Rule to download SRA data
$(SRA_DATA_DIR)/%.fastq.gz: 
	mkdir -p $(SRA_DATA_DIR)
	cd $(SRA_DATA_DIR) && \
	for srr in $(SRR_IDS); do \
		fastq-dump --split-files --gzip $$srr; \
	done

# Rule to align reads to the genome
%.sam: $(SRA_DATA_DIR)/%.fastq.gz
	hisat2 -x $(GENOME_INDEX) -1 $*_1.fastq.gz -2 $*_2.fastq.gz -S $@

# Rule to convert SAM to sorted BAM
%.sorted.bam: %.sam
	samtools view -bS $< | samtools sort -o $@

# Rule to count features and create count matrix
$(COUNTS_FILE): $(addsuffix .sorted.bam, $(SRR_IDS))
	featureCounts -a $(ANNOTATION) -o $(COUNTS_FILE) $^

# Clean up intermediate files
clean:
	rm -f $(SRA_DATA_DIR)/*.fastq.gz
	rm -f $(SRA_DATA_DIR)/*.sam
	rm -f $(SRR_IDS:.srr=.sorted.bam)
	rm -f $(COUNTS_FILE)

# Phony targets
.PHONY: all clean

