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
    local scaffold=$(echo "$line" | awk '{print $1}')
    local start=$(echo "$line" | awk '{print $4}')
    local end=$(echo "$line" | awk '{print $5}')
    local strand=$(echo "$line" | awk '{print $7}')
    local id=$(echo "$line" | grep -o 'ID=gene:[^;]*' | cut -d'=' -f2)
    local name=$(echo "$line" | grep -o 'Name=[^;]*' | cut -d'=' -f2)
    local biotype=$(echo "$line" | grep -o 'biotype=[^;]*' | cut -d'=' -f2)
    local description=$(echo "$line" | grep -o 'description=[^;]*' | cut -d'=' -f2)
    local gene_id=$(echo "$line" | grep -o 'gene_id=[^;]*' | cut -d'=' -f2)
    local logic_name=$(echo "$line" | grep -o 'logic_name=[^;]*' | cut -d'=' -f2)
    local version=$(echo "$line" | grep -o 'version=[^;]*' | cut -d'=' -f2)

    # Print the parsed data in a formatted way
    echo -e "Scaffold: $scaffold\nStart: $start\nEnd: $end\nStrand: $strand\nID: $id\nName: $name\nBiotype: $biotype\nDescription: $description\nGene ID: $gene_id\nLogic Name: $logic_name\nVersion: $version\n"
}

# Read the input file line by line and parse each line
while IFS= read -r line; do
    if [[ $line == *"ID=gene:"* ]]; then
        parse_line "$line" >> "$output_file"
    fi
done < "$input_file"

echo "Data organized and saved to $output_file"
