
**Part one**

***Report the Size of the FASTA File*** 

4.5M

***Total size of genom***

4699673

***Number of chromosomes in the genome***
1

***ID name and length of chromosome*** 
````
NC_000913.3 Escherichia coli s 4641652 

````

E. coli Genome FASTA File

```sh
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz -O Ecoli.fna.gz
```

***Unzip the FASTA File***

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

***Size of FASTQ Files***

```sh
du -h Ecoli_simulated1.fq
du -h Ecoli_simulated2.fq
```

#### To Compress FASTQ Files


```sh
gzip Ecoli_simulated1.fq
gzip Ecoli_simulated2.fq
```
#### Compressed file size:***


```sh
du -h Ecoli_simulated1.fq.gz
du -h Ecoli_simulated2.fq.gz
```

#### To chek FASTA file size:***


```sh
du -h Ecoli.fna
```

#### To generate FASTA file output:***


```sh
art_illumina -ss HS25 -i Ecoli.fna -p -l 100 -f 10 -m 200 -s 10 -o Ecoli_simulated
```

****Discuss whether you could get the same coverage with different parameter settings (read length vs. read number)****

As long as the number of bases sequenced (i.e., read length times the number of reads) remains constant, I can achieve the same coverage using various combinations of read length and count.


## Estimate Coverage for Other Genomes

| Genome      | Genome Size | 30x Coverage | Number of Reads (150 bp) | Estimated File Size |
|-------------|-------------|--------------|--------------------------|---------------------|
| Yeast       | 12 Mb       | 360 Mb       | 2.4 million              | 180 MB              |
| Drosophila  | 180 Mb      | 5.4 Gb       | 36 million               | 2700 MB             |
| Human       | 3.2 Gb      | 96 Gb        | 640 million              | 48000 MB            |






