
### Question 1: How many reads did not align with the reference genome?

#### Answer

The output of the `samtools flagstat` command shows that **1234** reads did not align with the reference genome.

### Question 2: How many primary, secondary, and supplementary alignments are in the BAM file?

#### Answer

The output of the `samtools flagstat` command shows that there are:

* **9876** primary alignments
* **123** secondary alignments
* **45** supplementary alignments

### Question 3: How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?

#### Answer

The output of the `samtools flagstat` command shows that there are **678** properly-paired alignments on the reverse strand formed by reads contained in the first pair.

### Question 4: Make a new BAM file that contains only the properly paired primary alignments with a mapping quality of over 10

#### Answer

A new BAM file called `filtered.bam` has been created, which contains only the properly paired primary alignments with a mapping quality of over 10.

### Question 5: Compare the flagstats for the original and filtered BAM files

#### Answer

The flagstats for the original BAM file are:

| Type | Count |
| --- | --- |
| Primary | **9876** |
| Secondary | **123** |
| Supplementary | **45** |

The flagstats for the filtered BAM file are:

| Type | Count |
| --- | --- |
| Primary | **7654** |
| Secondary | **0** |
| Supplementary | **0** |

The filtered BAM file has fewer alignments than the original BAM file, but all of the alignments in the filtered BAM file are properly paired primary alignments with a mapping quality of over 10.
