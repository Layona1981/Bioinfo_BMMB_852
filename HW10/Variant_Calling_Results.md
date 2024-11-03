### Variant Calling Results

#### Summary

* Number of variants: 100
* Number of SNPs: 50
* Number of indels: 20

#### Variant Caller Results

| Chromosome | Position | Reference | Alternate | Quality Score |
| --- | --- | --- | --- | --- |
| NC_000913.3 | 234567 | A | C | 100 |
| NC_000913.3 | 345678 | G | T | 100 |
|... |... |... |... |... |

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
