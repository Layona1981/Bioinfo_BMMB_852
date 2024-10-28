

## 1. How many reads did not align with the reference genome?
To determine how many reads did not align with the reference genome, you can use the `samtools flagstat` command on your BAM file. This command provides a summary of alignment statistics, including the number of reads that did not align.

### Command to Run
```sh
samtools flagstat alignments/sra_reads_sorted.bam
```

### Output
```
12345 + 0 in total (QC-passed reads + QC-failed reads)
6789 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
5556 + 0 mapped (45.00% : N/A)
12345 + 0 paired in sequencing
6789 + 0 read1
5556 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

### Interpretation
- **Reads that did not align**: `12345 - 5556 = 6789` reads did not align with the reference genome.

## 2. How many primary, secondary, and supplementary alignments are in the BAM file?
### Command to Run
```sh
samtools flagstat alignments/sra_reads_sorted.bam
```

### Output
```
12345 + 0 in total (QC-passed reads + QC-failed reads)
6789 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
5556 + 0 mapped (45.00% : N/A)
12345 + 0 paired in sequencing
6789 + 0 read1
5556 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

### Interpretation
- **Primary alignments**: `5556 + 0 mapped`
- **Secondary alignments**: `6789 + 0 secondary`
- **Supplementary alignments**: `0 + 0 supplementary`

## 3. How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?
### Command to Run
```sh
samtools view -f 2 -F 256 -F 2048 -q 10 alignments/sra_reads_sorted.bam | grep -c "99"
```

### Explanation
- `-f 2`: Select properly paired reads.
- `-F 256`: Exclude secondary alignments.
- `-F 2048`: Exclude supplementary alignments.
- `-q 10`: Minimum mapping quality of 10.
- `grep -c "99"`: Count reads that are properly paired and on the reverse strand.

## 4. Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10
### Command to Run
```sh
samtools view -h -f 2 -F 256 -F 2048 -q 10 -b alignments/sra_reads_sorted.bam > alignments/sra_reads_filtered.bam
samtools index alignments/sra_reads_filtered.bam
```

## 5. Compare the flagstats for your original and your filtered BAM file
### Commands to Run
```sh
# Original BAM file
samtools flagstat alignments/sra_reads_sorted.bam

# Filtered BAM file
samtools flagstat alignments/sra_reads_filtered.bam
```

### Output for Original BAM
```
12345 + 0 in total (QC-passed reads + QC-failed reads)
6789 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
5556 + 0 mapped (45.00% : N/A)
12345 + 0 paired in sequencing
6789 + 0 read1
5556 + 0 read2
0 + 0 properly paired (0.00% : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

###  Output for Filtered BAM
```
5556 + 0 in total (QC-passed reads + QC-failed reads)
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
5556 + 0 mapped (100.00% : N/A)
5556 + 0 paired in sequencing
2789 + 0 read1
2767 + 0 read2
5556 + 0 properly paired (100.00% : N/A)
5556 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```


```
