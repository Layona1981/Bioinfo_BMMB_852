

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


#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO
NC_000913.3  1000    .       A       G       99      PASS    .
NC_000913.3  1500    .       T       C       99      PASS    .
```

