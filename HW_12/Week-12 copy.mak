
# Variables
SRR1 = SRR12345678
SRR2 = SRR12345679
SRR3 = SRR12345680
ACC = ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
GENOME = Ecoli.fna

# Targets
.PHONY: genome simulate download index align call_variants report clean help

genome:
	wget $(ACC) -O $(GENOME).gz
	gunzip $(GENOME).gz
	@echo "Genome downloaded and unzipped."

simulate:
	art_illumina -ss HS25 -i $(GENOME) -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
	gzip Ecoli_simulated1.fq Ecoli_simulated2.fq

download:
	fastq-dump $(SRR1) -O ./sra_data/
	fastq-dump $(SRR2) -O ./sra_data/
	fastq-dump $(SRR3) -O ./sra_data/

index:
	bwa index $(GENOME)

align:
	bwa mem $(GENOME) ./sra_data/$(SRR1).fastq ./sra_data/$(SRR1).fastq | samtools view -bS - > $(SRR1).bam
	bwa mem $(GENOME) ./sra_data/$(SRR2).fastq ./sra_data/$(SRR2).fastq | samtools view -bS - > $(SRR2).bam
	bwa mem $(GENOME) ./sra_data/$(SRR3).fastq ./sra_data/$(SRR3).fastq | samtools view -bS - > $(SRR3).bam

call_variants:
	samtools sort $(SRR1).bam -o $(SRR1).sorted.bam
	samtools sort $(SRR2).bam -o $(SRR2).sorted.bam
	samtools sort $(SRR3).bam -o $(SRR3).sorted.bam
	bcftools mpileup -f $(GENOME) $(SRR1).sorted.bam | bcftools call -mv -o $(SRR1)_variants.vcf
	bcftools mpileup -f $(GENOME) $(SRR2).sorted.bam | bcftools call -mv -o $(SRR2)_variants.vcf
	bcftools mpileup -f $(GENOME) $(SRR3).sorted.bam | bcftools call -mv -o $(SRR3)_variants.vcf

report:
	@echo "Report generated."

clean:
	rm -f *.bam *.sorted.bam *.vcf *.fq.gz

help:
	@echo "Available targets:"
	@echo "  genome          - Download and prepare the genome."
	@echo "  simulate        - Simulate sequencing reads."
	@echo "  download        - Download SRR data."
	@echo "  index           - Index the genome."
	@echo "  align           - Align reads to the genome."
	@echo "  call_variants   - Call variants from aligned reads."
	@echo "  report          - Generate a report."
	@echo "  clean           - Clean up generated files."


# Targets
.PHONY: usage genome simulate download index align call_variants report clean unaligned primary_secondary_supplementary properly_paired_reverse filter_bam compare_flagstats

# Targets
.PHONY: download align call_variants

download:
    fastq-dump $(SRR1) -O ./sra_data/
    fastq-dump $(SRR2) -O ./sra_data/
    fastq-dump $(SRR3) -O ./sra_data/

align:
    bwa mem $(GENOME) ./sra_data/$(SRR1).fastq ./sra_data/$(SRR1).fastq | samtools view -bS - > $(SRR1).bam
    bwa mem $(GENOME) ./sra_data/$(SRR2).fastq ./sra_data/$(SRR2).fastq | samtools view -bS - > $(SRR2).bam
    bwa mem $(GENOME) ./sra_data/$(SRR3).fastq ./sra_data/$(SRR3).fastq | samtools view -bS - > $(SRR3).bam

call_variants:
    samtools sort $(SRR1).bam -o $(SRR1).sorted.bam
    samtools sort $(SRR2).bam -o $(SRR2).sorted.bam
    samtools sort $(SRR3).bam -o $(SRR3).sorted.bam
    bcftools mpileup -f $(GENOME) $(SRR1).sorted.bam | bcftools call -mv -o $(SRR1)_variants.vcf
    bcftools mpileup -f $(GENOME) $(SRR2).sorted.bam | bcftools call -mv -o $(SRR2)_variants.vcf
    bcftools mpileup -f $(GENOME) $(SRR3).sorted.bam | bcftools call -mv -o $(SRR3)_variants.vcf

# Help
usage:
	@echo "Makefile targets:"
	@echo "  genome          - Download the genome"
	@echo "  simulate        - Simulate reads for the genome"
	@echo "  download        - Download reads from SRA"
	@echo "  index           - Index the reference genome with BWA"
	@echo "  align           - Align SRA reads to the reference genome"
	@echo "  call_variants   - Call variants from the aligned BAM file"
	@echo "  report          - Generate a report"
	@echo "  clean           - Remove all generated files to start fresh"
	@echo "  unaligned       - Count reads that did not align with the reference genome"
	@echo "  primary_secondary_supplementary - Count primary, secondary, and supplementary alignments"
	@echo "  properly_paired_reverse - Count properly-paired alignments on the reverse strand for the first pair"
	@echo "  filter_bam      - Create a new BAM file with properly paired primary alignments with mapping_quality >10"
	@echo "  compare_flagstats - Compare flagstats for original and filtered BAM files"

# Download and prepare the genome and annotation files
genome:
	wget $(ACC) -O $(GENOME).gz
	gunzip $(GENOME).gz
	@echo "Genome downloaded and unzipped."
	@echo "Size of the FASTA file:"
	du -h $(GENOME)

# Simulate reads for the genome
simulate:
	art_illumina -ss HS25 -i $(GENOME) -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
	gzip Ecoli_simulated1.fq Ecoli_simulated2.fq
	@echo "Simulated reads generated and compressed."
	@echo "Number of reads generated: $$(($(N) / 100))"
	@echo "Average read length: 100 base pairs"
	@echo "Compressed size of the FASTQ files:"
	du -h Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz

# Download SRA data
download:
	mkdir -p $(SRA_DIR)
	fastq-dump --split-files --outdir $(SRA_DIR) $(SRR)
	$(FASTQC_CMD) $(SRA_DIR)/$(SRR)_1.fastq -o $(QC_DIR)
	@echo "SRA data downloaded and initial FastQC report generated."

# Index the reference genome with BWA
index:
	bwa index $(GENOME)
	@echo "Genome indexed."

# Align SRA reads to the reference genome
align:
	bwa mem -t 4 $(GENOME) $(SRA_DIR)/$(SRR)_1.fastq | samtools sort -o $(BAM_FILE)
	samtools index $(BAM_FILE)
	bwa mem -t 4 $(GENOME) Ecoli_simulated1.fq.gz | samtools sort -o Ecoli.sorted.bam
	samtools index Ecoli.sorted.bam
	@echo "Reads aligned and indexed."

# Call variants from the aligned BAM file
call_variants:
	samtools mpileup -uf $(GENOME) $(BAM_FILE) | bcftools call -mv -Ov -o $(VCF_FILE)
	@echo "Variants called and saved to $(VCF_FILE)."

# Generate a report
report:
	@echo "This Makefile automates the process of downloading, simulating, and processing genomic data."
	@echo "Targets:"
	@echo "  genome: Downloads and unzips the E. coli genome."
	@echo "  simulate: Simulates reads from the genome using ART."
	@echo "  download: Downloads reads from SRA and generates a FastQC report."
	@echo "  index: Indexes the genome."
	@echo "  align: Aligns the reads to the genome."
	@echo "  call_variants: Calls variants from the aligned BAM file."
	@echo "  clean: Removes generated files to clean up the workspace."

# Count reads that did not align with the reference genome
unaligned:
	samtools flagstat Ecoli.sorted.bam | grep "0x4"
	@echo "Number of reads that did not align with the reference genome:"

# Count primary, secondary, and supplementary alignments
primary_secondary_supplementary:
	samtools flagstat Ecoli.sorted.bam | grep "primary"
	samtools flagstat Ecoli.sorted.bam | grep "secondary"
	samtools flagstat Ecoli.sorted.bam | grep "supplementary"
	@echo "Number of primary, secondary, and supplementary alignments:"

# Count properly-paired alignments on the reverse strand for the first pair
properly_paired_reverse:
	samtools flagstat Ecoli.sorted.bam | grep "properly paired" | grep "reverse"
	@echo "Number of properly-paired alignments on the reverse strand for the first pair:"

# Create a new BAM file with properly paired primary alignments with mapping_quality >10
filter_bam:
	samtools view -h -f 2 -q 10 -b Ecoli.sorted.bam > $(FILTERED_BAM)
	samtools index $(FILTERED_BAM)
	@echo "New BAM file created with properly paired primary alignments with mapping_quality >10"

# Compare flagstats for original and filtered BAM files
compare_flagstats:
	samtools flagstat Ecoli.sorted.bam
	samtools flagstat $(FILTERED_BAM)
	@echo "Flagstats for original and filtered BAM files:"

# Clean up generated files
clean:
	rm -rf $(GENOME) Ecoli_simulated*.fq.gz $(SRA_DIR) $(QC_DIR) *.bam *.bai $(VCF_FILE)
	@echo "Cleaned up generated files."
