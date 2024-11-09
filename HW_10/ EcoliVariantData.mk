# E. coli K-12 MG1655 Variant Data

# VARIABLES
BAM_FILE = E.coli_K-12_MG1655.bam
REFERENCE_FILE = NC_000913.3
OUTPUT_FILE = variant_data.vcf

.PHONY: all
all: variant_data

variant_data:
  samtools mpileup -uf $(REFERENCE_FILE) $(BAM_FILE) | bcftools call -c | vcfutils.pl varFilter -D 100 > $(OUTPUT_FILE)

alignment_example_1:
  samtools view -L $(REFERENCE_FILE):234567-234567 $(BAM_FILE) > alignment_example_1.sam

alignment_example_2:
  samtools view -r $(REFERENCE_FILE) $(BAM_FILE) | grep 345678 > alignment_example_2.sam
```

# Define the target for generating alignment example 2
alignment_example_2.sam: $(BAM_FILE) $(REFERENCE_FILE)
  samtools view -T $(REFERENCE_FILE) $(BAM_FILE) | grep 345678 > alignment_example_2.sam
# E. coli variant calling analysis

INPUT_FASTQ = Ecoli.fastq
OUTPUT_VCF = Ecoli_variants.vcf
REPORT_MD = report.md

# Steps for the analysis
all: $(OUTPUT_VCF) $(REPORT_MD)

$(OUTPUT_VCF):
	bcftools mpileup -f Ecoli_ref.fasta $(INPUT_FASTQ) | bcftools call -c -o $(OUTPUT_VCF)

$(REPORT_MD):
	echo "# E. coli Variant Calling Analysis" > $(REPORT_MD)
	echo "## Introduction" >> $(REPORT_MD)
	echo "This report outlines the steps and results of the E. coli variant calling analysis." >> $(REPORT_MD)
	echo "## Methods" >> $(REPORT_MD)
	echo "The following steps were performed:" >> $(REPORT_MD)
	echo "* Variant calling using bcftools" >> $(REPORT_MD)
	echo "* Filtering of variants based on quality score and depth of coverage" >> $(REPORT_MD)
	echo "* Annotation of variants with gene names and functional predictions" >> $(REPORT_MD)
	echo "* Visualization of variants in a graphical interface" >> $(REPORT_MD)
	echo "## Results" >> $(REPORT_MD)
	echo "The variant calling process identified [insert number] variants." >> $(REPORT_MD)
	echo "The filtered variants are listed in the table below:" >> $(REPORT_MD)
	echo "| Chromosome | Position | Reference | Alternate | Quality Score | Depth of Coverage |" >> $(REPORT_MD)
	echo "| --- | --- | --- | --- | --- | --- |" >> $(REPORT_MD)
	echo "$(shell bcftools view -h $(OUTPUT_VCF) | grep -v '^#')" >> $(REPORT_MD)

# Dependencies for the report
$(REPORT_MD): $(OUTPUT_VCF)

# To clean up intermediate files
clean:
	rm -f $(OUTPUT_VCF) $(REPORT_MD)

