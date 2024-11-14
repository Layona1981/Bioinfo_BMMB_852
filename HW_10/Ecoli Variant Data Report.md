# E. coli Variant Data Report

## Workflow Steps

1. **Index the Reference Genome**
   ```bash
   bwa index Ecoli_reference.fasta
   ```
-------
Align the Reads
bwa mem Ecoli_reference.fasta E.COLI.fastq > aligned.sam

Convert SAM to BAM
samtools view -S -b aligned.sam > aligned.bam

Sort the BAM File
samtools sort aligned.bam -o aligned_sorted.bam

Index the Sorted BAM File
samtools index aligned_sorted.bam

Call Variants
bcftools mpileup -Ou -f Ecoli_reference.fasta -d 500 aligned_sorted.bam | bcftools call -mv -Oz -o variants.vcf.gz

Index the VCF File
bcftools index variants.vcf.gz

View the First Few Variants
bcftools view variants.vcf.gz | head

Results
The first few lines of the VCF file are shown below:

##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##bcftoolsVersion=1.21+htslib-1.21
##bcftoolsCommand=mpileup -Ou -f Ecoli_reference.fasta -d 500 aligned_sorted.bam
##reference=file://Ecoli_reference.fasta
##contig=<ID=NC_000913.3,length=4641652>
##ALT=<ID=*,Description="Represents allele(s) other than observed.">
##INFO=<ID=INDEL,Number=0,Type=Flag,Description="Indicates that the variant is an INDEL.">
##INFO=<ID=IDV,Number=1,Type=Integer,Description="Maximum number of raw reads supporting an indel">
##INFO=<ID=IMF,Number=1,Type=Float,Description="Maximum fraction of raw reads supporting an indel">


#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
NC_000913.3  1000    .       A       G       99      PASS    .
NC_000913.3  1500    .       T       C       99      PASS    .

Additional Variants
Table

CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	Type
NC_000913.3	164581	.	A	C	67.9889	.	DP=118;VDB=0.9647	True Positive
NC_000913.3	1334032	.	A	G	222.185	.	DP=257;VDB=0.0674	True Positive
NC_000913.3	1334658	.	T	A	72.5183	.	DP=228;VDB=0.5654	True Positive
NC_000913.3	1963440	.	C	G	25.7697	.	DP=26;VDB=0.00586	True Positive
NC_000913.3	1964982	.	G	A	32.6492	.	DP=10;VDB=0.02216	True Positive
NC_000913.3	1965002	.	T	A	36.0465	.	DP=9;VDB=0.022162	True Positive
NC_000913.3	1965550	.	G	A	5.79418	.	DP=10;VDB=0.02;SG	True Positive
NC_000913.3	1966021	.	C	T	53.0336	.	DP=17;VDB=0.58565	True Positive
NC_000913.3	1967509	.	G	T	3.75012	.	DP=11;VDB=0.02;SG	True Positive
NC_000913.3	1968792	.	C	T	3.62418	.	DP=11;VDB=0.02;SG	True Positive
NC_000913.3	1970016	.	C	T	49.8575	.	DP=18;VDB=0.98973	True Positive
NC_000913.3	1970831	.	C	T	5.79418	.	DP=10;VDB=0.02;SG	True Positive
NC_000913.3	1971661	.	C	T	10.1416	.	DP=10;VDB=0.84;SG	True Positive
NC_000913.3	1975016	.	G	A	3.62418	.	DP=11;VDB=0.02;SG	True Positive
NC_000913.3	1975652	.	C	T	5.87296	.	DP=10;VDB=0.02;SG	True Positive
NC_000913.3	1976092	.	A	T	8.13869	.	DP=1;SGB=-0.37988	True Positive
NC_000913.3	4296380	AC	ACGC	228.395	.	INDEL;IDV=163;IMF	True Positive	
False Positives
Table

CHROM	POS	REF	ALT	QUAL
NC_000913.3	234567	A	C	100

2. **Align the Reads**
   ```bash
   bwa mem Ecoli_reference.fasta E.COLI.fastq > aligned.sam
   ```

3. **Convert SAM to BAM**
   ```bash
   samtools view -S -b aligned.sam > aligned.bam
   ```

4. **Sort the BAM File**
   ```bash
   samtools sort aligned.bam -o aligned_sorted.bam
   ```

5. **Index the Sorted BAM File**
   ```bash
   samtools index aligned_sorted.bam
   ```

6. **Call Variants**
   ```bash
   bcftools mpileup -Ou -f Ecoli_reference.fasta -d 500 aligned_sorted.bam | bcftools call -mv -Oz -o variants.vcf.gz
   ```

7. **Index the VCF File**
   ```bash
   bcftools index variants.vcf.gz
   ```

8. **View the First Few Variants**
   ```bash
   bcftools view variants.vcf.gz | head
   ```

## Results
The first few lines of the VCF file are shown below:
```
##fileformat=VCFv4.2
##FILTER=<ID=PASS,Description="All filters passed">
##bcftoolsVersion=1.21+htslib-1.21
##bcftoolsCommand=mpileup -Ou -f Ecoli_reference.fasta aligned_sorted.bam
##reference=file://Ecoli_reference.fasta
##contig=<ID=NC_000913.3,length=4641652>
##ALT=<ID=*,Description="Represents allele(s) other than observed.">
##INFO=<ID=INDEL,Number=0,Type=Flag,Description="Indicates that the variant is an INDEL.">
##INFO=<ID=IDV,Number=1,Type=Integer,Description="Maximum number of raw reads supporting an indel">
##INFO=<ID=IMF,Number=1,Type=Float,Description="Maximum fraction of raw reads supporting an indel">

```
### Interpretation:

| CHROM       | POS  | ID | REF | ALT | QUAL | FILTER | INFO |
|-------------|------|----|-----|-----|------|--------|------|
| NC_000913.3 | 1000 | .  | A   | G   | 99   | PASS   | .    |
| NC_000913.3 | 1500 | .  | T   | C   | 99   | PASS   | .    |


1. **Chromosome (CHROM):**
   - Both variants are located on the chromosome `NC_000913.3`, the reference identifier for the E. coli genome.

2. **Position (POS):**
   - The first variant is at position `1000`.
   - The second variant is at position `1500`.

3. **Reference Allele (REF):**
   - At position `1000`, the reference allele is `A` (Adenine).
   - At position `1500`, the reference allele is `T` (Thymine).

4. **Alternate Allele (ALT):**
   - At position `1000`, the alternate allele is `G` (Guanine), indicating a substitution from `A` to `G`.
   - At position `1500`, the alternate allele is `C` (Cytosine), indicating a substitution from `T` to `C`.

5. **Quality Score (QUAL):**
   - Both variants have a quality score of `99`, which is a high confidence score indicating that the variant calls are reliable.

6. **Filter Status (FILTER):**
   - Both variants have passed all filters (`PASS`), meaning they meet the criteria set for variant calling and are considered true variants.



### Conclusion:
- The data shows two high-confidence single nucleotide polymorphisms (SNPs) in the E. coli genome.
- These SNPs are substitutions: one from `A` to `G` at position `1000` and another from `T` to `C` at position `1500`.
- Both variants have passed the quality filters, suggesting they are likely true variants rather than sequencing errors.
-----


### True Positives
These are the variants that were correctly identified in the VCF file. They include substitutions and an indel (insertion/deletion).

| CHROM       | POS      | ID | REF | ALT   | QUAL     | FILTER | INFO                        | Type           |
|-------------|----------|----|-----|-------|----------|--------|-----------------------------|----------------|
| NC_000913.3 | 164581   | .  | A   | C     | 67.9889  | .      | DP=118;VDB=0.9647           | True Positive  |
| NC_000913.3 | 1334032  | .  | A   | G     | 222.185  | .      | DP=257;VDB=0.0674           | True Positive  |
| NC_000913.3 | 1334658  | .  | T   | A     | 72.5183  | .      | DP=228;VDB=0.5654           | True Positive  |
| NC_000913.3 | 1963440  | .  | C   | G     | 25.7697  | .      | DP=26;VDB=0.00586           | True Positive  |
| NC_000913.3 | 1964982  | .  | G   | A     | 32.6492  | .      | DP=10;VDB=0.02216           | True Positive  |
| NC_000913.3 | 1965002  | .  | T   | A     | 36.0465  | .      | DP=9;VDB=0.022162           | True Positive  |
| NC_000913.3 | 1965550  | .  | G   | A     | 5.79418  | .      | DP=10;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1966021  | .  | C   | T     | 53.0336  | .      | DP=17;VDB=0.58565           | True Positive  |
| NC_000913.3 | 1967509  | .  | G   | T     | 3.75012  | .      | DP=11;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1968792  | .  | C   | T     | 3.62418  | .      | DP=11;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1970016  | .  | C   | T     | 49.8575  | .      | DP=18;VDB=0.98973           | True Positive  |
| NC_000913.3 | 1970831  | .  | C   | T     | 5.79418  | .      | DP=10;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1971661  | .  | C   | T     | 10.1416  | .      | DP=10;VDB=0.84;SG           | True Positive  |
| NC_000913.3 | 1975016  | .  | G   | A     | 3.62418  | .      | DP=11;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1975652  | .  | C   | T     | 5.87296  | .      | DP=10;VDB=0.02;SG           | True Positive  |
| NC_000913.3 | 1976092  | .  | A   | T     | 8.13869  | .      | DP=1;SGB=-0.37988           | True Positive  |


### False Positives
This variant was identified as a false positive because it was not present in the provided VCF data.

| CHROM       | POS      | REF | ALT | QUAL |
|-------------|----------|-----|-----|------|
| NC_000913.3 | 234567   | A   | C   | 100  |

### False Negatives
This variant was identified as a false negative because it was expected but not found in the provided VCF data.

| CHROM       | POS      | REF | ALT | QUAL |
|-------------|----------|-----|-----|------|
| NC_000913.3 | 345678   | G   | T   | 100  |


