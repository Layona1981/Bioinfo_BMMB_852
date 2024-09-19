#!/bin/bash

# Define variables
# INPUT_FILE: Path to the input data file
# OUTPUT_FILE: Path to the output results file
INPUT_FILE="genes_only.gff3"
OUTPUT_FILE="output_results.txt"

# Function to process data
# Arguments:
#   $1 - Input file path
#   $2 - Output file path
process_data() {
    local input_file=$1
    local output_file=$2

    # Extract gene details from the input file
    echo "Processing data from $input_file..."
    awk -F'\t' '$3 == "gene" {print $1 ": ID=" $9}' $input_file > $output_file

    echo "Data processing complete. Results saved to $output_file."
}

# Function to print summary statistics
# Arguments:
#   $1 - Input file path
print_summary() {
    local input_file=$1

    echo "Summary statistics for $input_file:"
    # Count the total number of genes
    total_genes=$(awk -F'\t' '$3 == "gene" {count++} END {print count}' $input_file)
    echo "Total Genes Identified: $total_genes"
}

# Main script execution
process_data $INPUT_FILE $OUTPUT_FILE
print_summary $INPUT_FILE
