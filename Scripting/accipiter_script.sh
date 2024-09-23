
#!/bin/bash

# Set the error handling and trace
set -uex

# Define all variables at the top

# URLs for downloading the files
URL_GFF="https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.abinitio.gff3.gz"

# Names of the files
GFF_FILE="Accipiter_nisus.Accipiter_nisus_ver1.0.112.abinitio.gff3.gz"
UNZIPPED_GFF_FILE="Accipiter_nisus.Accipiter_nisus_ver1.0.112.abinitio.gff3"

# Output files for extracted features
GENES_FILE="accipiter_nisus_genes.gff"
CDS_FILE="accipiter_nisus_CDS.gff"
MRNA_FILE="accipiter_nisus_mRNA.gff"
EXONS_FILE="accipiter_nisus_exons.gff"

# ------ ALL THE ACTIONS FOLLOW ------

# Download the genomic file using curl
curl -o ${GFF_FILE} ${URL_GFF}

# Unzip the file
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
