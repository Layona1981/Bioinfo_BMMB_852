


###E. coli Genome FASTA File


```sh
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz
```

###Unzip the FASTA File


```sh
gunzip Ecoli.fna.gz
```

###Report the Size of the FASTA File


```sh
du -h Ecoli.fna
```

### Step 4: Calculate the Total Size of the Genome and Number of Chromosomes


def calculate_genome_stats(fasta_file):
    total_genome_size = 0
    num_chromosomes = 0
    chromosome_lengths = {}
mosome_length
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

###Generate Simulated FASTQ Output


```sh
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
```

###Number of Reads Generated and Average Read Length





###Size of the FASTQ Files



```sh
du -h Ecoli_simulated1.fq
du -h Ecoli_simulated2.fq
```

### Step 8: Compress the FASTQ Files


```sh
gzip Ecoli_simulated1.fq
gzip Ecoli_simulated2.fq
```

Compressed file sizes:

```sh
du -h Ecoli_simulated1.fq.gz
du -h Ecoli_simulated2.fq.gz
```




