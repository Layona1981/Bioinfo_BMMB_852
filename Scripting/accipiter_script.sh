
#!/bin/bash

# Set the error handling and trace
set -uex

# Define all variables at the top

# URLs for downloading the files
URL_GFF="https://ftp.ensembl.org/pub/current_gff3/accipiter_nisus/Accipiter_nisus.Accipiter_nisus_ver1.0.112.abinitio.gff3.gz"



# Unzip the file
gunzip ${ccipiter_nisus.Accipiter_nisus_ver1.0.112.abinitio.gff3.gz}


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
