

## Makefile Overview
Two key targets, `index` and `align`, were added to the Makefile to handle the indexing of the reference genome and the alignment of both simulated and real reads.

### Key Targets in the Makefile

- **genome**: Downloads and extracts the reference genome.
- **download**: Downloads the real sequencing data from SRA.
- **trim**: Trims the SRA reads using Trimmomatic.
- **index**: Indexes the reference genome using BWA.
- **align**: Aligns both simulated and SRA reads to the indexed reference genome and produces sorted BAM files.



### Results from BAM files:

**Simulated Reads:** The alignments were perfect, with 100% of the reads mapping to the reference genome. The coverage was uniform across the entire genome, as expected from simulated data.

**SRA Reads:** The real sequencing data showed much lower alignment rates. This could indicate that the reads either had low quality or came from a strain that differs from the reference genome. There were also significant gaps in the coverage.

**Simulated Reads:** These reads aligned perfectly to the reference genome (100% alignment), which is expected since the reads were generated directly from the reference genome sequence.


**SRA Reads:** Only a portion of the SRA reads are mapped to the reference genome. This low mapping rate suggests that the SRA reads may come from a different Escherichia coli strain or could be of lower quality compared to the simulated reads.


````
wget ftp://ftp.ensembl.org/pub/release-105/fasta/saccharomyces_cerevisiae/dna/Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
gunzip Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa.gz
````
````
wgsim -N 240000 -1 150 -2 150 Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa simulated_reads_1.fastq simulated_reads_2.fastq
````
````
fastq-dump --split-files --outdir sra_data SRR387901
````
````
java -jar Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 sra_data/SRR387901_1.fastq sra_trimmed.fastq \
  ILLUMINACLIP:Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
````
````
# Simulated reads
bwa mem Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa simulated_reads_1.fastq simulated_reads_2.fastq | samtools view -Sb - > simulated_reads.bam
samtools sort simulated_reads.bam -o simulated_reads_sorted.bam
samtools index simulated_reads_sorted.bam

# SRA reads
bwa mem Saccharomyces_cerevisiae.R64-1-1.dna.toplevel.fa sra_trimmed.fastq | samtools view -Sb - > sra_reads.bam
samtools sort sra_reads.bam -o sra_reads_sorted.bam
samtools index sra_reads_sorted.bam
````
````
samtools flagstat simulated_reads_sorted.bam
````

````
480000 + 0 in total (QC-passed reads + QC-failed reads)
480000 + 0 mapped (100.00% : N/A)
480000 + 0 properly paired (100.00% : N/A)
````
````
samtools flagstat sra_reads_sorted.bam
````
````
18402980 + 0 in total (QC-passed reads + QC-failed reads)
2022016 + 0 mapped (10.99% : N/A)
0 + 0 properly paired (N/A : N/A)
````

### Download SRA data

```bash
fastq-dump --split-files --outdir sra_data SRR12345678
```

### Trim SRA reads

```bash
java -jar /path/to/Trimmomatic-0.39/trimmomatic-0.39.jar SE -threads 4 sra_data/SRR12345678_1.fastq sra_trimmed.fastq \
  ILLUMINACLIP:/path/to/Trimmomatic-0.39/adapters/TruSeq3-SE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```

### Align simulated reads

```bash
bwa mem Ecoli.fna Ecoli_simulated1.fq.gz Ecoli_simulated2.fq.gz | samtools view -Sb - > simulated_reads.bam
samtools sort simulated_reads.bam -o simulated_reads_sorted.bam
samtools index simulated_reads_sorted.bam
```

### Align SRA reads

```bash
bwa mem Ecoli.fna sra_trimmed.fastq | samtools view -Sb - > sra_reads.bam
samtools sort sra_reads.bam -o sra_reads_sorted.bam
samtools index sra_reads_sorted.bam
```

### Generate alignment statistics

```bash
samtools flagstat simulated_reads_sorted.bam > simulated_reads_stats.txt
samtools flagstat sra_reads_sorted.bam > sra_reads_stats.txt
```
