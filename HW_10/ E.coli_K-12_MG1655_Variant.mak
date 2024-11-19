# E. coli variant calling pipeline

# Variables
GENOME = Ecoli.fna
R1 = Ecoli_simulated1.fq.gz
R2 = Ecoli_simulated2.fq.gz
N = 1000000
OUTPUT_DIR = ./output
VCF_FILE = $(OUTPUT_DIR)/variants.vcf
SORTED_BAM = $(OUTPUT_DIR)/aligned.sorted.bam

# Targets
.PHONY: usage index align sort_bam index_bam call_variants filter_variants view_variants clean

# Help
usage:
	@echo "Makefile targets:"
	@echo "  index         - Index the reference genome with BWA"
	@echo "  align         - Align simulated reads to the reference genome"
	@echo "  sort_bam      - Sort the aligned BAM file"
	@echo "  index_bam     - Index the sorted BAM file"
	@echo "  call_variants - Call variants from the aligned BAM file"
	@echo "  filter_variants - Filter variants based on quality"
	@echo "  view_variants - View the first few lines of the VCF file"
	@echo "  clean         - Remove all generated files to start fresh"

# Create output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Index the reference genome with BWA
index: $(OUTPUT_DIR)
	bwa index $(GENOME)
	@echo "Genome indexed."

# Align simulated reads to the reference genome
align: $(OUTPUT_DIR)
	bwa mem -t 4 $(GENOME) $(R1) $(R2) | samtools sort -o $(SORTED_BAM)
	samtools index $(SORTED_BAM)
	@echo "Reads aligned and indexed."

# Sort the aligned BAM file
sort_bam: align
	samtools sort $(SORTED_BAM) -o $(SORTED_BAM)
	@echo "BAM file sorted."

# Index the sorted BAM file
index_bam: sort_bam
	samtools index $(SORTED_BAM)
	@echo "Sorted BAM file indexed."

# Call variants from the aligned BAM file
call_variants: index_bam
	bcftools mpileup -Ou -f $(GENOME) $(SORTED_BAM) | bcftools call -mv -Ov -o $(VCF_FILE)
	@echo "Variants called."

# Filter variants based on quality
filter_variants: call_variants
	bcftools filter -i 'QUAL>20' $(VCF_FILE) -o $(OUTPUT_DIR)/filtered_variants.vcf
	@echo "Variants filtered by quality."

# View the first few lines of the VCF file
view_variants: filter_variants
	head $(OUTPUT_DIR)/filtered_variants.vcf
	@echo "Displayed first few lines of the filtered variants file."

# Clean up generated files
clean:
	rm -rf $(OUTPUT_DIR)/*.bam $(OUTPUT_DIR)/*.vcf $(OUTPUT_DIR)/*.bai $(OUTPUT_DIR)
	@echo "Cleaned up generated files."



