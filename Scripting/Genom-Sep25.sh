
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
