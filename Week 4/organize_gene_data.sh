#!/bin/bash

# Define the input and output file paths
input_file="BIOHW/Gene Intervals Report.md"
output_file="BIOHW/Organized_Gene_Intervals_Report.md"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found!"
    exit 1
fi

# Function to parse and format each line
parse_line() {
    local line=$1
    local id=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /ID=gene:/) print $i}')
    local name=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /Name=/) print $i}')
    local biotype=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /biotype=/) print $i}')
    local description=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /description=/) print $i}')
    local gene_id=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /gene_id=/) print $i}')
    local logic_name=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /logic_name=/) print $i}')
    local version=$(echo "$line" | awk -F';' '{for(i=1;i<=NF;i++) if($i ~ /version=/) print $i}')
    local scaffold=$(echo "$line" | awk '{print $1}')
    local start=$(echo "$line" | awk '{print $4}')
    local end=$(echo "$line" | awk '{print $5}')
    local strand=$(echo "$line" | awk '{print $7}')

    # Print the parsed data in a formatted way
    echo -e "Scaffold: $scaffold\nStart: $start\nEnd: $end\nStrand: $strand\n$id\n$name\n$biotype\n$description\n$gene_id\n$logic_name\n$version\n"
}

# Read the input file line by line and parse each line
while IFS= read -r line; do
    if [[ $line == *"ID=gene:"* ]]; then
        parse_line "$line" >> "$output_file"
    fi
done < "$input_file"

echo "Data organized and saved to $output_file"
