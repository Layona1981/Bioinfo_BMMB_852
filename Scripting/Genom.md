## Commands Used

**To  download the file**  

   ```bash
   curl -O https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz```` 
 
 **To extract the GFF file** 

  ```` gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz ````

  ```` grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | wc -l ````
 

 ```` grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f1 | sort | uniq | wc -l ````
 
  ```` grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | grep -c 'gene' ````
 

```` grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f3 | sort | uniq -c | sort -nr | head -n 10 ````

 ```` gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz ````


**The most annotated feature types**

```` 45991 genes ````

```` 309995 exon ````

```` 301420 CDS ````

```` 309995 exon ````

```` 301420 CDS ````

```` 133065 biological_region ```` 

```` 44975 region ````

```` 27007 mRNA ````

```` 18324 five_prime_UTR ```` 

```` 17271 gene ```` 

```` 14159 three_prime_UTR ````

```` 754 ncRNA_gene ````

```` 433 lnc_RNA ````








