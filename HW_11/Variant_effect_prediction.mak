# Define variables
VCF_INPUT = /Desktop/BIOHW/BIOIHW/variants.vcf.gz
SNPEFF_JAR = /path/to/snpEff.jar
GENOME = GRCh38.86
ANNOTATED_VCF = annotated_variants.vcf

# Phony targets
.PHONY: all download_db annotate_variants

# Rule to download snpEff database
download_db:
	@echo "Downloading snpEff database for $(GENOME)..."
	java -jar $(SNPEFF_JAR) download $(GENOME)
	@echo "Download complete."

# Rule to annotate VCF file
annotate_variants: download_db
	@echo "Annotating VCF file $(VCF_INPUT) using snpEff..."
	java -jar $(SNPEFF_JAR) $(GENOME) $(VCF_INPUT) > $(ANNOTATED_VCF)
	@echo "Annotation complete. Output saved to $(ANNOTATED_VCF)."

# Default rule
all: annotate_variants
	@echo "All tasks completed."

