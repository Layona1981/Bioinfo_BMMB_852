

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
```

### Download and prepare the genome and annotation files
```makefile
genome:
	mkdir -p genome_data
	@echo "Downloading reference genome..."
	wget -P genome_data $(GENOME_URL)
	@echo "Unzipping reference genome..."
	gunzip -f genome_data/*.fa.gz
	@echo "Downloading GFF annotation file..."
	wget -P genome_data $(GFF_URL)
	@echo "Unzipping GFF file..."
	gunzip -f genome_data/*.gff3.gz
```

### Download the SRA data
```makefile
sra_data:
	mkdir -p sra_data
	@echo "Downloading SRA data..."
	$(FASTQ_DUMP) --split-files --outdir sra_data $(SRA_ID)
```

### Index the reference genome with BWA
```makefile
index: genome
	@echo "Indexing the reference genome with BWA..."
	$(BWA) index $(GENOME_FILE)
```

### Align the SRA reads to the reference genome and sort the BAM files
```makefile
align: index sra_data
	mkdir -p alignments
	@echo "Aligning SRA reads to the reference genome..."
	$(BWA) mem $(GENOME_FILE) sra_data/$(SRA_ID)_1.fastq | $(SAMTOOLS) view -Sb - > alignments/sra_reads.bam
	$(SAMTOOLS) sort alignments/sra_reads.bam -o $(BAM_SRA)
	$(SAMTOOLS) index $(BAM_SRA)
```

### Generate flagstat report for the original BAM file
```makefile
stats: align
	@echo "Generating flagstats for the original BAM file..."
	$(SAMTOOLS) flagstat $(BAM_SRA)
```

### Filter BAM file to retain properly paired primary alignments with a mapping quality >10
```makefile
filter: align
	@echo "Filtering BAM file..."
	$(SAMTOOLS) view -h -f 2 -q 10 -b $(BAM_SRA) > $(FILTERED_BAM)
	$(SAMTOOLS) index $(FILTERED_BAM)
```

### Compare flagstats for original and filtered BAM files
```makefile
compare: filter
	@echo "Comparing flagstats for original and filtered BAM files..."
	@echo "Original BAM:"
	$(SAMTOOLS) flagstat $(BAM_SRA)
	@echo "Filtered BAM:"
	$(SAMTOOLS) flagstat $(FILTERED_BAM)
```

### Clean up all generated files to start fresh
```makefile
clean:
	rm -rf genome_data sra_data alignments
```
``

