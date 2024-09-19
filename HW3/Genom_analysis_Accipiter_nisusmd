
## Genome Feature Analysis

### Questions and Answers

1. **How many features does the file contain?**  
   867,929

2. **How many sequence regions (chromosomes) does the file contain?**  
   44,975

3. **How many genes are listed for this organism?**  
   45,991

4. **What are the top-ten most annotated feature types (column 3) across the genome?**

   - 309,995 exon
   - 301,420 CDS
   - 133,065 biological_region
   - 44,975 region
   - 27,007 mRNA
   - 18,324 five_prime_UTR
   - 17,271 gene
   - 14,159 three_prime_UTR
   - 754 ncRNA_gene
   - 433 lnc_RNA

5. **Having analyzed this GFF file, does it seem like a complete and well-annotated organism?**  
   The high number of features indicates a rich annotation. Multiple sequence regions also suggest a complete genome. In addition, the diverse types of features imply a well-annotated genome.

## Commands Used

- To download the file:  
  ```bash
  curl -O https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz
  ```

- To extract the GFF file:  
  ```bash
  gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz
  ```

- To answer Q2:  
  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | wc -l
  ```

- For Q3:  
  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f1 | sort | uniq | wc -l
  ```

- For Q4:  
  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | grep -c 'gene'
  ```

- For Q5:  
  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f3 | sort | uniq -c | sort -nr | head -n 10
  ```

