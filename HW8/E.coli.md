


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

# Download the reference genome
```bash
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz


# Simulate reads
wgsim -N 1000000 -1 150 -2 150 Ecoli.fna Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz


# Download SRA data
fastq-dump --split-files --outdir sra_data SRR12345678

# Trim SRA reads
java -jar /path/to/Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 sra_data/SRR12345678_1.fastq sra_trimmed.fastq \
  ILLUMINACLIP:/path/to/Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36


# Generate alignment statistics
samtools flagstat simulated_reads_sorted.bam > simulated_reads_stats.txt
samtools flagstat sra_reads_sorted.bam > sra_reads_stats.txt

Sure, here is the entire content formatted with each step in a separate code block. You can copy and paste it all at once:

```markdown
# Download the reference genome

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz
gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz
```

# Simulate reads
```bash
wgsim -N 1000000 -1 150 -2 150 Ecoli.fna Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz
```

# Download SRA data
```bash
fastq-dump --split-files --outdir sra_data SRR12345678
```

# Trim SRA reads
```bash
java -jar /path/to/Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 sra_data/SRR12345678_1.fastq sra_trimmed.fastq \
  ILLUMINACLIP:/path/to/Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```

# Align simulated reads
```bash
bwa mem Ecoli.fna Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz | samtools view -Sb - > simulated_reads.bam
samtools sort simulated_reads.bam -o simulated_reads_sorted.bam
samtools index simulated_reads_sorted.bam
```

# Align SRA reads
```bash
bwa mem Ecoli.fna sra_trimmed.fastq | samtools view -Sb - > sra_reads.bam
samtools sort sra_reads.bam -o sra_reads_sorted.bam
samtools index sra_reads_sorted.bam
```

# Generate alignment statistics
```bash
samtools flagstat simulated_reads_sorted.bam > simulated_reads_stats.txt
samtools flagstat sra_reads_sorted.bam > sra_reads_stats.txt
```
