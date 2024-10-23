

```markdown
# BAM File Analysis Report

## Commands and Answers

### 1. How many reads did not align with the reference genome?
```bash
make count_unaligned
```
Output:
```bash
X reads did not align with the reference genome.
```

### 2. How many primary, secondary, and supplementary alignments are in the BAM file?
```bash
make count_alignments
```
Output:
```bash
Primary alignments: X
Secondary alignments: Y
Supplementary alignments: Z
```

### 3. How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?
```bash
make count_properly_paired
```
Output:
```bash
X properly-paired alignments on the reverse strand from the first pair.
```

### 4. Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10
```bash
make filter_bam
```
Output:
```bash
Filtered BAM file created at alignments/filtered_sorted.bam
```

### 5. Compare the flagstats for your original and your filtered BAM file
```bash
make compare_flagstats
```
Output:
```bash
Original BAM file flagstats: alignments/original_flagstat.txt
Filtered BAM file flagstats: alignments/filtered_flagstat.txt
Differences: diff alignments/original_flagstat.txt alignments/filtered_flagstat.txt
```
```

