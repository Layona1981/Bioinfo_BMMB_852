


 **Escherichia coli** 



## Makefile Overview
Two key targets, `index` and `align`, were added to the Makefile to handle the indexing of the reference genome and the alignment of both simulated and real reads.

### Key Targets in the Makefile

- **genome**: Downloads and extracts the reference genome.
- **download**: Downloads the real sequencing data from SRA.
- **trim**: Trims the SRA reads using Trimmomatic.
- **index**: Indexes the reference genome using BWA.
- **align**: Aligns both simulated and SRA reads to the indexed reference genome and produces sorted BAM files.



### Results from BAM files visualized in IGV:

Simulated Reads: The alignments were perfect, with 100% of the reads mapping to the reference genome. The coverage was uniform across the entire genome, as expected from simulated data.
SRA Reads: The real sequencing data showed much lower alignment rates. This could indicate that the reads either had low quality or came from a strain that differs from the reference genome. There were also significant gaps in the coverage.
Simulated Reads: These reads aligned perfectly to the reference genome (100% alignment), which is expected since the reads were generated directly from the reference genome sequence.
SRA Reads: Only a portion of the SRA reads are mapped to the reference genome. This low mapping rate suggests that the SRA reads may come from a different Escherichia coli strain or could be of lower quality compared to the simulated reads.

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
