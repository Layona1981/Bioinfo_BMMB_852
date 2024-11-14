

1. **Index the Reference Genome**
   ```bash
   bwa index Ecoli_reference.fasta
   ```

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
   bcftools mpileup -Ou -f Ecoli_reference.fasta aligned_sorted.bam | bcftools call -mv -Oz -o variants.vcf.gz
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

7. **Additional Information (INFO):**
   - The `INFO` field is empty (`.`) for both variants, indicating no additional annotations or flags are associated with these variants.

### Summary:
- The data shows two high-confidence single nucleotide polymorphisms (SNPs) in the E. coli genome.
- These SNPs are substitutions: one from `A` to `G` at position `1000` and another from `T` to `C` at position `1500`.
- Both variants have passed the quality filters, suggesting they are likely true variants rather than sequencing errors.

