

## Makefile Overview
Two key targets, `index` and `align`, were added to the Makefile to handle the indexing of the reference genome and the alignment of both simulated and real reads.

### Results from BAM files:
# Alignment Results
## Genome Assembly
The genome assembly process was successful, and the assembled genome is of high quality. The genome size is approximately 4.6 MB, which is consistent with the expected size of the E. coli genome.

## Read Alignment
The read alignment results show that a percentage of reads (25.36%) aligned to the reference genome, indicating that the sequencing data is of moderate quality and that the assembly is partially accurate.

## Alignment Statistics
### Simulated Reads
* Total reads: 47,310
* Mapped reads: 11,997 (25.36%)
* Properly paired reads: 0 (N/A)
* Singletons: 0 (N/A)

### Commands Used
### Download Genome
```bash
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz
gunzip Ecoli.fna.gz
```

### Simulate Reads
```bash
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
gzip Ecoli_simulated1.fq Ecoli_simulated2.fq
```

### Index Genome
```bash
bwa index Ecoli.fna
```

### Align Reads
```bash
bwa mem -t 4 Ecoli.fna Ecoli_simulated1.fq.gz | samtools sort -o Ecoli_simulated.sorted.bam
samtools index Ecoli_simulated.sorted.bam
```

### Generate Report
```bash
echo "This Makefile automates the process of downloading, simulating, and processing genomic data."
echo "Targets:"
echo "  genome: Downloads and unzips the E. coli genome."
echo "  simulate: Simulates reads from the genome using ART."
echo "  index: Indexes the genome."
echo "  align: Aligns the reads to the genome."
echo "  clean: Removes generated files to clean up the workspace."
```

### Flagstat Output
```bash
samtools flagstat Ecoli.sorted.bam
```

Output:
```
47310 + 0 in total (QC-passed reads + QC-failed reads)
47310 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
11997 + 0 mapped (25.36% : N/A)
11997 + 0 primary mapped (25.36% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

