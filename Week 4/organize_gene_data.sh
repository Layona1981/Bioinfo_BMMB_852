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
    local id=$(echo "$line" | grep -oP 'ID=gene:[^;]+')
    local name=$(echo "$line" | grep -oP 'Name=[^;]+')
    local biotype=$(echo "$line" | grep -oP 'biotype=[^;]+')
    local description=$(echo "$line" | grep -oP 'description=[^;]+')
    local gene_id=$(echo "$line" | grep -oP 'gene_id=[^;]+')
    local logic_name=$(echo "$line" | grep -oP 'logic_name=[^;]+')
    local version=$(echo "$line" | grep -oP 'version=[^;]+')
    local scaffold=$(echo "$line" | awk '{print $1}')
    local start=$(echo "$line" | awk '{print $4}')
    local end=$(echo "$line" | awk '{print $5}')
    local strand=$(echo "$line" | awk '{print $7}')

    echo -e "Scaffold: $scaffold\nStart: $start\nEnd: $end\nStrand: $strand\n$id\n$name\n$biotype\n$description\n$gene_id\n$logic_name\n$version\n"
}

# Read the input file line by line and parse each line
while IFS= read -r line; do
    parse_line "$line" >> "$output_file"
done < "$input_file"

echo "Data organized and saved to $output_file"
