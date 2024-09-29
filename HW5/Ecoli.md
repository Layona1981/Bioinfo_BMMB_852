

## Part 1

**Simulating FASTQ files

***Size of the file***

4.5M

***The total size of the genome***

4699673

***The number of chromosomes in the genome***

1

***The name (id) and length of each chromosome in the genome***
````
NC_000913.3 Escherichia coli s 4641652 

````

***How many reads have you generated?***

154656

***What is the average read length?***

150bp

***How big are the FASTQ files?***

52M

***After Compression***

9.8 M. 
Saved:42.2 M

***Discuss whether you could get the same coverage with different parameter settings (read length vs. read number)***

Yes, I can achieve the same coverage using various combinations of read length and count, as long as the number of bases sequenced (i.e., read length times the number of reads) remains constant. For example, if I produce shorter reads, I'll need more of them to cover the same genome size. Conversely, fewer reads will be required to cover the same genome size if I produce longer reads.

***Estimate Coverage for Other Genomes***


****Yeast (12 Mb genome)****

30x coverage = 12 Mb × 30 = 360 Mb total bases.

If we assume 150 bp reads, the number of reads required would be:
360,000,000 bp / 150 bp = 2.4 million reads


****Drosophila (180 Mb genome)****

30x coverage = 180 Mb × 30 = 5.4 Gb total bases.

Number of reads = 5,400,000,000 / 150 bp = 36 million reads.


****Human (3.2 Gb genome)****

30x coverage = 3.2 Gb × 30 = 96 Gb total bases.

Number of reads = 96,000,000,000 / 150 bp = 640 million reads


***Estimated file Size Uncompressed***

Yeast: 180MB

Drosophila: 2700 MB

Human: 48000 MB


***Script link***

```` 

https://github.com/Layona1981/Bioinfo_BMMB_852/blob/main/HW5/Ecoli.sh

````
