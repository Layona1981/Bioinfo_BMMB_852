
set -uex

#!/bin/bash

# Array of GFF files
files=("accipiter_nisus_genes.gff" "accipiter_nisus_CDS.gff" "accipiter_nisus_mRNA.gff" "accipiter_nisus_exons.gff")

# Loop through each file and extract top 10 features
for file in "${files[@]}"
do
  echo "Top features in $file:"
  grep -v '^#' "$file" | cut -f3 | sort | uniq -c | sort -nr | head -n 10
  echo ""
done
