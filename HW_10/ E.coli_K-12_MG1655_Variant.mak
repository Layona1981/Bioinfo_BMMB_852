# Makefile for E. coli variant calling pipeline

# Variables
REF=Ecoli_reference.fasta
READS=E.COLI.fastq
SAM=aligned.sam
BAM=aligned.bam
SORTED_BAM=aligned_sorted.bam
VCF=variants.vcf.gz

# Rules
all: index_ref align_reads convert_sam_to_bam sort_bam index_bam call_variants index_vcf view_variants

index_ref:
	bwa index $(REF)

align_reads: index_ref
	bwa mem $(REF) $(READS) > $(SAM)

convert_sam_to_bam: align_reads
	samtools view -S -b $(SAM) > $(BAM)

sort_bam: convert_sam_to_bam
	samtools sort $(BAM) -o $(SORTED_BAM)

index_bam: sort_bam
	samtools index $(SORTED_BAM)

call_variants: index_bam
	bcftools mpileup -Ou -f $(REF) $(SORTED_BAM) | bcftools call -mv -Oz -o $(VCF)

index_vcf: call_variants
	bcftools index $(VCF)

view_variants: index_vcf
	bcftools view $(VCF) | head

clean:
	rm -f $(SAM) $(BAM) $(SORTED_BAM) $(VCF) $(VCF).csi
