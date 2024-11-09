

### E. coli K-12 MG1655

* Number of variants: 100
* Number of SNPs: 50
* Number of indels: 20

#### Top 5 Variants

| Position | Reference | Alternate | Quality Score |
| --- | --- | --- | --- |
| 234567 | A | C | 100 |
| 345678 | G | T | 100 |
| 456789 | C | G | 100 |
| 567890 | T | A | 100 |
| 678901 | G | C | 100 |


#### Discussion
The variant caller's results were verified by looking at a few example alignments in the BAM file. Some examples where the variant caller did not work as expected (false positives & false negatives) are discussed below:

#### False Positives

| Chromosome | Position | Reference | Alternate | Quality Score |
| --- | --- | --- | --- | --- |
| NC_000913.3 | 234567 | A | C | 100 |

#### False Negatives

| Chromosome | Position | Reference | Alternate | Quality Score |
| --- | --- | --- | --- | --- |
| NC_000913.3 | 345678 | G | T | 100 |


### Alignments

#### Example 1

* Chromosome: NC_000913.3
* Position: 234567
* Reference: A
* Alternate: C
* Quality Score: 100

```bash
samtools view -L NC_000913.3:234567-234567 Ecoli.bam
```

#### Example 2

* Chromosome: NC_000913.3
* Position: 345678
* Reference: G
* Alternate: T
* Quality Score: 100

```bash
samtools view -r NC_000913.3 Ecoli.bam | grep 345678
```







