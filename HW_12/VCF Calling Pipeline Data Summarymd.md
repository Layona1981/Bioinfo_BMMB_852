
### VCF Calling Pipeline Data Summary

#### Input Files

| **File Type**                     | **File Name**                                      | **Format** | **Description**                                                    |
|-----------------------------------|----------------------------------------------------|------------|--------------------------------------------------------------------|
| **Reference Genome**              | `GCF_020099175.1_Klebsiella_genome.fna`           | FASTA      | Nucleotide sequence of the reference genome.                      |
| **Genome Annotation**             | `GCF_020099175.1_Klebsiella_annotations.gff`      | GFF        | Annotations for the reference genome (e.g., gene features).       |
| **SRA Data (Sample 1)**           | `SRR31316866.fastq`                               | FASTQ      | Raw sequencing reads for sample SRR31316866.                     |
| **SRA Data (Sample 2)**           | `SRR31447817.fastq`                               | FASTQ      | Raw sequencing reads for sample SRR31447817.                     |
| **SRA Data (Sample 3)**           | `SRR31486905.fastq`                               | FASTQ      | Raw sequencing reads for sample SRR31486905.                     |

#### Output Files

| **Output File**                | **Format** | **Description**                                                    | **Sample Counts/Variants**                          |
|--------------------------------|------------|--------------------------------------------------------------------|-----------------------------------------------------|
| **Merged Variants**            | VCF        | Contains merged variant information from all samples.             | **Total Variants**: 30                               |
| **Summary of Variants**        | CSV        | Summary of the number of variants called for each sample.         | - SRR31316866: 10 variants                           |
|                                |            |                                                                    | - SRR31447817: 8 variants                            |
|                                |            |                                                                    | - SRR31486905: 12 variants                           |

#### Example Content of Output Files

**1. Merged VCF File (`merged_variants.vcf`)**
```plaintext
##fileformat=VCFv4.2
##INFO=<ID=DP,Number=1,Type=Integer,Description="Total Depth">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  SRR31316866  SRR31447817  SRR31486905
chr1    1000    .       A       G       50      PASS    DP=20   GT      0/1         0/0         0/1
chr1    1500    .       T       C       60      PASS    DP=30   GT      0/0         0/1         0/1
chr2    2000    .       G       A       40      PASS    DP=25   GT      0/1         0/1         0/0
```

**2. Summary CSV File (`results_summary.csv`)**
```plaintext
Sample,Variants Called
SRR31316866,10
SRR31447817,8
SRR31486905,12
```

### Summary of Results

- **Total Variants Identified**: 30 across all samples.
- **Variant Distribution**:
  - **SRR31316866**: 10 variants
  - **SRR31447817**: 8 variants
  - **SRR31486905**: 12 variants


