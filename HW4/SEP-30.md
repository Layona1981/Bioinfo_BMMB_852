

#!/bin/bash

# Set the error handling and trace
set -uex

# Define all variables at the top

# URLs for downloading the files
URL_FNA="zhttps://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.fna.gz "
URL_GFF="zhttps://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz "


# Names of the files
FNA_FILE="GCF_000027325.1_ASM2732v1_genomic.fna.gz"
GFF_FILE="GCF_000027325.1_ASM2732v1_genomic.gff.gz"
UNZIPPED_FNA_FILE="GCF_000027325.1_ASM2732v1_genomic.fna"
UNZIPPED_GFF_FILE="GCF_000027325.1_ASM2732v1_genomic.gff"

# Output files for extracted features
GENES_FILE="accipiter_nisus_genes.gff"
CDS_FILE="accipiter_nisus_CDS.gff"
MRNA_FILE="accipiter_nisus_mRNA.gff"
EXONS_FILE="accipiter_nisus_exons.gff"

# ------ ALL THE ACTIONS FOLLOW ------

# Download the genomic files
wget ${URL_FNA}
wget ${URL_GFF}

# Unzip the files
gunzip ${FNA_FILE}
gunzip ${GFF_FILE}

# Extract genes from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "gene"' > ${GENES_FILE}

# Extract CDS from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "CDS"' > ${CDS_FILE}

# Extract mRNA from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "mRNA"' > ${MRNA_FILE}

# Extract exons from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "exon"' > ${EXONS_FILE}

# Print the number of genes
echo "Number of genes:"
cat ${GENES_FILE} | wc -l

# Print the number of CDS
echo "Number of CDS:"
cat ${CDS_FILE} | wc -l

# Print the number of mRNA
echo "Number of mRNA:"
cat ${MRNA_FILE} | wc -l

# Print the number of exons
echo "Number of exons:"
cat ${EXONS_FILE} | wc -l

# Optional: Show the first few lines of each output file
echo "First few lines of genes file:"
head ${GENES_FILE}

echo "First few lines of CDS file:"
head ${CDS_FILE}

echo "First few lines of mRNA file:"
head ${MRNA_FILE}

echo "First few lines of exons file:"
head ${EXONS_FILE}


 ## The top-ten feature types 
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


## Commands Used


1. To download the file I used:
   ```bash
   curl -O https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz 

## 
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



- 
  ```bash
  gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz
  ```

-
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
