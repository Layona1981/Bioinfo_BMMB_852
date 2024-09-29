
## Simulating FASTQ files

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

9.8 M

***Discuss whether you could get the same coverage with different parameter settings (read length vs. read number)***

Yes, I can achieve the same coverage with different combinations of read length and number of reads as long as the total number of bases sequenced (i.e., read length multiplied by number of reads) remains the same.

Example:
If I generate shorter reads, I'll need more reads to cover the same genome size.

If I generate longer reads, I'll need fewer reads to cover the same genome size

***Estimate Coverage for Other Genomes***


***Yeast (12 Mb genome)***

30x coverage = 12 Mb × 30 = 360 Mb total bases.

If we assume 150 bp reads, the number of reads required would be:
360,000,000 bp / 150 bp = 2.4 million reads

***Drosophila (180 Mb genome)***

30x coverage = 180 Mb × 30 = 5.4 Gb total bases.

Number of reads = 5,400,000,000 / 150 bp = 36 million reads.

***Human (3.2 Gb genome)***

30x coverage = 3.2 Gb × 30 = 96 Gb total bases.

Number of reads = 96,000,000,000 / 150 bp = 640 million reads

***Estimated file Size Uncompressed***

Yeast: 180MB

Drosophila: 2700 MB

Human: 48000 MB
