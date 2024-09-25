
#!/bin/bash

# Unzip the file
gunzip Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3.gz

# Count total lines excluding comments
total_lines=$(grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | wc -l)
echo "Total lines excluding comments: $total_lines"

# Count unique entries in the first field
unique_first_field=$(grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f1 | sort | uniq | wc -l)
echo "Unique entries in the first field: $unique_first_field"

# Count occurrences of 'gene'
gene_count=$(grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | grep -c 'gene')
echo "Occurrences of 'gene': $gene_count"

# List the most common feature types
echo "Most common feature types:"
grep -v '^#' Accipiter_nisus.Accipiter_nisus_ver1.0.112.gff3 | cut -f3 | sort | uniq -c | sort -nr | head -n 10


# Most annotated feature types
echo "45991 genes"
echo "309995 exon"
echo "301420 CDS"
echo "133065 biological_region"
echo "44975 region"
echo "27007 mRNA"
echo "18324 five_prime_UTR"
echo "17271 gene"
echo "14159 three_prime_UTR"
echo "754 ncRNA_gene"
echo "433 lnc_RNA"
