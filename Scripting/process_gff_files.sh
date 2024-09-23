
#!/bin/bash

# Set the error handling and trace
set -uex

 # Define all variables at the top


# Output files for extracted features
GENES_FILE="accipiter_nisus_genes.gff"
CDS_FILE= "accipiter_nisus_CDS.gff"
MRNA_FILE= "accipiter_nisus_mRNA.gff" 
EXONS_FILE= "accipiter_nisus_exons.gff"


# Loop through each file and extract top 10 features
for file in "${files[@]}"
do
  echo "Top features in $file:"
  grep -v '^#' "$file" | cut -f3 | sort | uniq -c | sort -nr | head -n 10
  echo ""
done


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