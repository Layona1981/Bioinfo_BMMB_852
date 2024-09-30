

### URLs for downloaded files

``` URL_FNA="zhttps://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.fna.gz " ```

``` URL_GFF="zhttps://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz " ```


### Name of the files 


   ```` curl -O https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz````  

  ```
  gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz
````

```` cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "gene"' > Choloepus_hoffmanni_genes.gff cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "CDS"' > Choloepus_hoffmanni_CDS.gff ````

#### Output files for extracted features
``` 
GENES_FILE="accipiter_nisus_genes.gff"
```
```
CDS_FILE="accipiter_nisus_CDS.gff"
``` 
``` 
MRNA_FILE="accipiter_nisus_mRNA.gff"
``` 
``` 
EXONS_FILE="accipiter_nisus_exons.gff"
```

### The top-ten feature types 
| Feature Type          | Count   |
|-----------------------|---------|
| exon                  | 309995  |
| CDS                   | 301420  |
| biological_region     | 133065  |
| region                | 44975   |
| mRNA                  | 27007   |
| five_prime_UTR        | 18324   |
| gene                  | 17271   |
| three_prime_UTR       | 14159   |
| ncRNA_gene            | 754     |
| lnc_RNA               | 433     |


### Commands Used

1. To download the file I used:
   ```bash
   curl -O https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz 

  ```bash
  gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz
  ```


  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | wc -l
  ``` 
 
  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f1 | sort | uniq | wc -l
  ```

  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | grep -c 'gene'
  ```

  ```bash
  grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f3 | sort | uniq -c | sort -nr | head -n 10
  ```
## Conclusion

This report provides the foundation for further analysis of the gene intervals and their biological significance.

````
mkdir Choloepus_hoffmanni
```` 

````
cd Choloepus_hoffmanni
````

````
curl-l https://useast.ensembl.org/Choloepus_hoffmanni/Transcript/Summary?db=core;g=ENSCHOG00000015578;r=scaffold_95728:2238-2320;t=ENSCHOT00000014379
```` 

````
gunzip ENSCHOT00000014379.1_genomic.fna.gz
````

````
gunzip ENSCHOT00000014379.1_genomic.gff
````
## Command used for getting gene.gff and cds.gff

````
cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "gene"' > Choloepus_hoffmanni_genes.gff cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "CDS"' > Choloepus_hoffmanni_CDS.gff
````

````
head Choloepus_hoffmanni_genes.gff
````
````
head Choloepus_hoffmanni_CDC.gff
````

***Script to run Mhib's data (someone else's data)*** 

****Script Link****

https://github.com/rmahib/Mahib852/blob/main/Assignment_4/Script.sh 

I've found the following features after running the script 

````
1. Genes: 559
2. Number of CDS: 10
1. mRNA: 0
2. Exons: 42
````

****Link to original script file****
[(https://github.com/Layona1981/Bioinfo_BMMB_852/blob/main/HW4/SEP_30.sh)] 

**Link to the modified script**
[(https://github.com/Layona1981/Bioinfo_BMMB_852/blob/main/HW4/Mahib's%20modefied%20script.sh]