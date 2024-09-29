
**Part one**

***Report the Size of the FASTA File*** 

4.5M

***Total size of genom***

4699673

***The number of chromosomes in the genome***
1

***ID name and length of chromosome*** 
````
NC_000913.3 Escherichia coli s 4641652 

````

E. coli Genome FASTA File

```sh
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz
```

***Unzip the FASTA File

```sh
gunzip Ecoli.fna.gz
```

***Number of reads:***

154656

***Average read length:***

150bp

***FASTQ files size:*** 

52M 
After compression: 9.8 M. 
Saved:42.2 M

***To chek FASTA file size:***

```sh
du -h Ecoli.fna
```
***To generate FASTA file output:***

```sh
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
```


***Discuss whether you could get the same coverage with different parameter settings (read length vs. read number)***

As long as the number of bases sequenced (i.e., read length times the number of reads) remains constant, I can achieve the same coverage using various combinations of read length and count,

***Estimate Coverage for Other Genomes***

****Yeast (12 Mb genome)****

30x coverage = 12 Mb × 30 = 360 Mb total bases.

If we assume 150 bp reads, the number of reads required would be:
360,000,000 bp / 150 bp = 2.4 million reads


****Drosophila (180 Mb genome)****  
30x coverage = 180 Mb × 30 = 5.4 Gb total bases.

****Human (3.2 Gb genome)****

30x coverage = 3.2 Gb × 30 = 96 Gb total bases.

Number of reads = 96,000,000,000 / 150 bp = 640 million reads

***Estimated file size***

Yeast: 180MB

Drosophila: 2700 MB

Human: 48000 MB

Genome	Genome Size	30x Coverage	Number of Reads (150 bp)	Estimated File Size
Yeast	12 Mb	360 Mb	2.4 million	180 MB
Drosophila	180 Mb	5.4 Gb	36 million	2700 MB
Human	3.2 Gb	96 Gb	640 million	48000 MB



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

***Generate Simulated FASTQ Output




###Number of Reads Generated and Average Read Length

4.5M



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




