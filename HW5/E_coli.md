


### Step 1: Download the E. coli Genome FASTA File


```sh
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz
```

### Step 2: Unzip the FASTA File

Use `gunzip` to unzip the downloaded file:

```sh
gunzip Ecoli.fna.gz
```

### Step 3: Report the Size of the FASTA File

You can use the `du` command to check the file size:

```sh
du -h Ecoli.fna
```

### Step 4: Calculate the Total Size of the Genome and Number of Chromosomes



def calculate_genome_stats(fasta_file):
    total_genome_size = 0
    num_chromosomes = 0
    chromosome_lengths = {}

    with open(fasta_file, 'r') as f:
        chromosome_id = ""
        chromosome_length = 0
        for line in f:
            if line.startswith('>'):
                if chromosome_id:
                    chromosome_lengths[chromosome_id] = chromosome_length
                    total_genome_size += chromosome_length
                    num_chromosomes += 1
                chromosome_id = line.split()[0][1:]
                chromosome_length = 0
            else:
                chromosome_length += len(line.strip())
        if chromosome_id:
            chromosome_lengths[chromosome_id] = chromosome_length
            total_genome_size += chromosome_length
            num_chromosomes += 1

    print(f"Total size of the genome: {total_genome_size} base pairs")
    print(f"Number of chromosomes in the genome: {num_chromosomes}")
    print("Chromosome lengths:")
    for chrom_id, length in chromosome_lengths.items():
        print(f"{chrom_id}: {length} base pairs")


```

Run the script with:

```sh
python calculate_genome_stats.py Ecoli.fna
```

### Step 5: Generate Simulated FASTQ Output

Use ART to generate the simulated FASTQ files:

```sh
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
```

### Step 6: Report the Number of Reads Generated and Average Read Length



```sh
# Assuming genome size is 4.6 million base pairs
genome_size=4600000
coverage=10
read_length=100

num_reads=$((genome_size * coverage / read_length))
echo "Number of reads generated: $num_reads"
echo "Average read length: $read_length base pairs"
```

### Step 7: Report the Size of the FASTQ Files

Use the `du` command to check the file sizes:

```sh
du -h Ecoli_simulated1.fq
du -h Ecoli_simulated2.fq
```

### Step 8: Compress the FASTQ Files

Use `gzip` to compress the FASTQ files:

```sh
gzip Ecoli_simulated1.fq
gzip Ecoli_simulated2.fq
```

Compressed file sizes:

```sh
du -h Ecoli_simulated1.fq.gz
du -h Ecoli_simulated2.fq.gz
```

### Example Shell Script (Ecoli.sh)



```sh
#!/bin/bash

# Step 1: Download the E. coli genome FASTA file
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz

# Step 2: Unzip the FASTA file
gunzip Ecoli.fna.gz

# Step 3: Report the size of the FASTA file
echo "Size of the FASTA file:"
du -h Ecoli.fna

# Step 4: Calculate the total size of the genome and number of chromosomes
python calculate_genome_stats.py Ecoli.fna

# Step 5: Generate simulated FASTQ output using ART with 10x coverage
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated

# Step 6: Report the number of reads generated and average read length
genome_size=4600000
coverage=10
read_length=100
num_reads=$((genome_size * coverage / read_length))
echo "Number of reads generated: $num_reads"
echo "Average read length: $read_length base pairs"

# Step 7: Report the size of the FASTQ files
echo "Size of the FASTQ file 1:"
du -h Ecoli_simulated1.fq
echo "Size of the FASTQ file 2:"
du -h Ecoli_simulated2.fq

# Step 8: Compress the FASTQ files and report the compressed sizes
gzip Ecoli_simulated1.fq
gzip Ecoli_simulated2.fq
echo "Compressed size of the FASTQ file 1:"
du -h Ecoli_simulated1.fq.gz
echo "Compressed size of the FASTQ file 2:"
du -h Ecoli_simulated2.fq.gz
```





