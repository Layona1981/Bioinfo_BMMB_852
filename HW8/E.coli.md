


 **Escherichia coli** 



## Makefile Overview
Two key targets, `index` and `align`, were added to the Makefile to handle the indexing of the reference genome and the alignment of both simulated and real reads.

### Key Targets in the Makefile

- **genome**: Downloads and extracts the reference genome.
- **download**: Downloads the real sequencing data from SRA.
- **trim**: Trims the SRA reads using Trimmomatic.
- **index**: Indexes the reference genome using BWA.
- **align**: Aligns both simulated and SRA reads to the indexed reference genome and produces sorted BAM files.

### Makefile Code
Here is the core section of the Makefile that includes the `index` and `align` targets:

```makefile
# Index the reference genome
index: genome
	@echo "Indexing the reference genome with BWA..."
	$(BWA) index genome_data/$(GENOME)

# Align the reads to the reference genome and sort the BAM files
align: index trim
	mkdir -p alignments
	@echo "Aligning reads to the reference genome..."
	$(BWA) mem genome_data/$(GENOME) $(TRIM_DIR)/$(SRR)_trimmed.fastq | $(SAMTOOLS) view -Sb - > alignments/$(SRR)_aligned.bam
	$(SAMTOOLS) sort alignments/$(SRR)_aligned.bam -o alignments/$(SRR)_aligned_sorted.bam
	$(SAMTOOLS) index alignments/$(SRR)_aligned_sorted.bam
