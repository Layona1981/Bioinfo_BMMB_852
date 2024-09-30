Mahib's modefied script 

#!/bin/bash

# Set the error handling and trace
set -uex

# Define all variables at the top

# URLs for downloading the files
URL_FNA="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/009/771/035/GCA_009771035.1_CNRS_Lalb_1.0/GCA_009771035.1_CNRS_Lalb_1.0_genomic.fna.gz"
URL_GFF="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/009/771/035/GCA_009771035.1_CNRS_Lalb_1.0/GCA_009771035.1_CNRS_Lalb_1.0_genomic.gff.gz"

# Names of the files
FNA_FILE="GCA_009771035.1_CNRS_Lalb_1.0_genomic.fna.gz"
GFF_FILE="GCA_009771035.1_CNRS_Lalb_1.0_genomic.gff.gz"
UNZIPPED_FNA_FILE="GCA_009771035.1_CNRS_Lalb_1.0_genomic.fna"
UNZIPPED_GFF_FILE="GCA_009771035.1_CNRS_Lalb_1.0_genomic.gff"

# Output files for extracted features
GENES_FILE="lupinus_genes.gff"
CDS_FILE="lupinus_cds.gff"
MRNA_FILE="lupinus_mRNA.gff"
EXONS_FILE="lupinus_exons.gff"
BIO_REGION_FILE="lupinus_biological_region.gff"
TRANSCRIPT_FILE="lupinus_transcript.gff"
RRNA_FILE="lupinus_rRNA.gff"
NCRNA_GENE_FILE="lupinus_ncRNA_gene.gff"

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

# Extract biological regions from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "biological_region"' > ${BIO_REGION_FILE}

# Extract transcripts from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "transcript"' > ${TRANSCRIPT_FILE}

# Extract rRNA from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "rRNA"' > ${RRNA_FILE}

# Extract ncRNA genes from the GFF file
cat ${UNZIPPED_GFF_FILE} | awk '$3 == "ncRNA_gene"' > ${NCRNA_GENE_FILE}

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

# Print the number of biological regions
echo "Number of biological regions:"
cat ${BIO_REGION_FILE} | wc -l

# Print the number of transcripts
echo "Number of transcripts:"
cat ${TRANSCRIPT_FILE} | wc -l

# Print the number of rRNA
echo "Number of rRNA:"
cat ${RRNA_FILE} | wc -l

# Print the number of ncRNA genes
echo "Number of ncRNA genes:"
cat ${NCRNA_GENE_FILE} | wc -l

# Optional: Show the first few lines of each output file
echo "First few lines of genes file:"
head ${GENES_FILE}

echo "First few lines of CDS file:"
head ${CDS_FILE}

echo "First few lines of mRNA file:"
head ${MRNA_FILE}

echo "First few lines of exons file:"
head ${EXONS_FILE}

echo "First few lines of biological region file:"
head ${BIO_REGION_FILE}

echo "First few lines of transcript file:"
head ${TRANSCRIPT_FILE}

echo "First few lines of rRNA file:"
head ${RRNA_FILE}

echo "First few lines of ncRNA gene file:"
head ${NCRNA_GENE_FILE}