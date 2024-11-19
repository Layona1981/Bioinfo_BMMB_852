
Makefile for variant effect prediction using snpEff

# Variables
VCF_INPUT = /Desktop/BIOHW/BIOIHW/variants.vcf.gz
SNPEFF_JAR = /path/to/snpEff.jar
GENOME = GRCh38.86
ANNOTATED_VCF = annotated_variants.vcf
OUTPUT_DIR = ./output

# Targets
.PHONY: usage download_db annotate_variants view_annotations clean

# Help
usage:
	@echo "Makefile targets:"
	@echo "  download_db       - Download snpEff database"
	@echo "  annotate_variants - Annotate variants using snpEff"
	@echo "  view_annotations  - View the annotated variants"
	@echo "  clean             - Remove all generated files to start fresh"

# Create output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Download snpEff database
download_db: $(OUTPUT_DIR)
	java -jar $(SNPEFF_JAR) download $(GENOME)
	@echo "snpEff database downloaded."

# Annotate variants using snpEff
annotate_variants: download_db
	java -jar $(SNPEFF_JAR) $(GENOME) $(VCF_INPUT) > $(OUTPUT_DIR)/$(ANNOTATED_VCF)
	@echo "Variants annotated."

# View the annotated variants
view_annotations:
	head $(OUTPUT_DIR)/$(ANNOTATED_VCF)
	@echo "Displayed first few lines of the annotated variants file."

# Clean up generated files
clean:
	rm -f $(OUTPUT_DIR)/$(ANNOTATED_VCF)
	@echo "Cleaned up generated files."
