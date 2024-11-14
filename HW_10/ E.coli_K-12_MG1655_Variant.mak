# Makefile for E. coli variant calling pipeline

# Variables
REF=Ecoli_reference.fasta
READS=E.COLI.fastq
SAM=aligned.sam
BAM=aligned.bam
SORTED_BAM=aligned_sorted.bam
VCF=variants.vcf.gz

# Phony targets
.PHONY: all index_ref align_reads convert_sam_to_bam sort_bam index_bam call_variants index_vcf view_variants clean

# Rules
all: index_ref align_reads convert_sam_to_bam sort_bam index_bam call_variants index_vcf view_variants

index_ref:
	@echo "Indexing the reference genome..."
	bwa index $(REF)

align_reads: index_ref
	@echo "Aligning the reads..."
	bwa mem $(REF) $(READS) > $(SAM)

convert_sam_to_bam: align_reads
	@echo "Converting SAM to BAM..."
	samtools view -S -b $(SAM) > $(BAM)

sort_bam: convert_sam_to_bam
	@echo "Sorting the BAM file..."
	samtools sort $(BAM) -o $(SORTED_BAM)

index_bam: sort_bam
	@echo "Indexing the sorted BAM file..."
	samtools index $(SORTED_BAM)

call_variants: index_bam
	@echo "Calling variants..."
	bcftools mpileup -Ou -f $(REF) -d 500 $(SORTED_BAM) | bcftools call -mv -Oz -o $(VCF)

index_vcf: call_variants
	@echo "Indexing the VCF file..."
	bcftools index $(VCF)

view_variants: index_vcf
	@echo "Viewing the first few variants..."
	bcftools view $(VCF) | head

clean:
	@echo "Cleaning up intermediate files..."
	rm -f $(SAM) $(BAM) $(SORTED_BAM) $(VCF) $(VCF).csi


