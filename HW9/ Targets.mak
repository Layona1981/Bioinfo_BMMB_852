
# Makefile for Genome Analysis

## Variables
- **GENOME_URL**: ftp://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
- **GFF_URL**: ftp://ftp.ensembl.org/pub/release-105/gff3/saccharomyces_cerevisiae/Saccharomyces_cerevisiae.R64-1-1.105.gff3.gz
- **SRA_ID**: SRR387901
- **GENOME_FILE**: genome_data/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa
- **GFF_FILE**: genome_data/Saccharomyces_cerevisiae.R64-1-1.105.gff3
- **BAM_SRA**: alignments/sra_reads_sorted.bam
- **FILTERED_BAM**: alignments/sra_reads_filtered.bam

## Tools
- **BWA**: bwa
- **SAMTOOLS**: samtools
- **FASTQ_DUMP**: fastq-dump

## Targets
### .PHONY
- **usage**: Display available Makefile targets
- **genome**: Download and unzip the genome and GFF annotation file
- **sra_data**: Download SRA data for analysis
- **index**: Index the reference genome with BWA
- **align**: Align SRA reads to the reference genome
- **stats**: Generate flagstats for the original BAM file
- **filter**: Filter the BAM file
- **compare**: Compare stats for original and filtered BAM files
- **clean**: Remove all generated files to start fresh

## Help
### usage
```makefile
usage:
	@echo "Makefile targets:"
	@echo "  genome    - Download and unzip the genome and GFF annotation file"
	@echo "  sra_data  - Download SRA data for analysis"
	@echo "  index     - Index the reference genome with BWA"
	@echo "  align     - Align SRA reads to the reference genome"
	@echo "  stats     - Generate flagstats for the original BAM file"
	@echo "  filter    - Filter the BAM file"
	@echo "  compare   - Compare stats for original and filtered BAM files"
	@echo "  clean     - Remove all generated files to start fresh"
