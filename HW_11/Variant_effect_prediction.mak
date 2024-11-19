# Variables
VEP_CMD = vep
VARIANTS = variants.vcf
ANNOTATED = annotated_variants.txt
OUTPUT_DIR = ./output

# Targets
.PHONY: usage download_db annotate_variants view_annotations clean

# Help
usage:
	@echo "Makefile targets:"
	@echo "  download_db       - Download VEP cache"
	@echo "  annotate_variants - Annotate variants using VEP"
	@echo "  view_annotations   - View the annotated variants"
	@echo "  clean             - Remove all generated files to start fresh"

# Create output directory
$(OUTPUT_DIR):
	mkdir -p $(OUTPUT_DIR)

# Download VEP cache
download_db: $(OUTPUT_DIR)
	vep_install --CACHE_VERSION 104 --ASSEMBLY GRCh37
	@echo "VEP cache downloaded."

# Annotate variants using VEP
annotate_variants: download_db
	$(VEP_CMD) -i $(VARIANTS) --cache --output_file $(OUTPUT_DIR)/$(ANNOTATED) --format vcf --force_overwrite
	@echo "Variants annotated."

# View the annotated variants
view_annotations:
	head $(OUTPUT_DIR)/$(ANNOTATED)
	@echo "Displayed first few lines of the annotated variants file."

# Clean up generated files
clean:
	rm -f $(OUTPUT_DIR)/$(ANNOTATED)
	@echo "Cleaned up generated files."


