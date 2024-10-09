# Variables
R1 = read_1.fastq
R2 = read_2.fastq
SRR = SRR123456
ACC = ftp://ftp.ensembl.org/pub/release-100/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz
GENOME = genome.fa
N = 100000

# Tools
FASTQC = fastqc
TRIMMOMATIC = trimmomatic-0.39
SIMULATE_SCRIPT = simulate_reads.py

# Targets
.PHONY: usage genome simulate download trim fastqc clean all

usage:
	@echo "Makefile Usage:"
	@echo "  make genome   - Download the genome"
	@echo "  make simulate - Simulate reads for the genome"
	@echo "  make download - Download reads from SRA"
	@echo "  make trim     - Trim reads"
	@echo "  make fastqc   - Generate FastQC reports"
	@echo "  make clean    - Clean up the generated files"
	@echo "  make all      - Run the entire workflow"

genome: $(GENOME)

$(GENOME):
	wget -O $(GENOME).gz $(ACC)
	gunzip $(GENOME).gz

simulate: genome
	python $(SIMULATE_SCRIPT) --genome $(GENOME) --output1 $(R1) --output2 $(R2) --num_reads $(N)

download:
	fastq-dump --split-files --readids --outdir . $(SRR)

trim: $(R1) $(R2)
	java -jar $(TRIMMOMATIC).jar PE -phred33 $(R1) $(R2) trimmed_$(R1) unpaired_$(R1) trimmed_$(R2) unpaired_$(R2) ILLUMINACLIP:TruSeq3-PE.fa:2:30:10

fastqc: trim
	$(FASTQC) trimmed_$(R1) trimmed_$(R2)

clean:
	rm -f $(GENOME) $(R1) $(R2) trimmed_$(R1) trimmed_$(R2) *.zip *.html

all: genome simulate download trim fastqc
