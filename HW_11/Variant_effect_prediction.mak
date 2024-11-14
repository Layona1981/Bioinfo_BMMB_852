
# Makefile for variant effect prediction using snpEff

# Define variables
VCF_INPUT = /Desktop/BIOHW/BIOIHW/variants.vcf.gz
SNPEFF_JAR = /path/to/snpEff.jar
GENOME = GRCh38.86
ANNOTATED_VCF = annotated_variants.vcf

# Rule to download snpEff database
download_db:
	java -jar $(SNPEFF_JAR) download $(GENOME)

# Rule to annotate VCF file
annotate_variants: download_db
	java -jar $(SNPEFF_JAR) $(GENOME) $(VCF_INPUT) > $(ANNOTATED_VCF)

# Default rule
all: annotate_variants
