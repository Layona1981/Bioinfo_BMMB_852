#!/bin/bash

# Define the input and output file paths
input_file="BIOHW/Gene Intervals Report.md"
output_file="BIOHW/Sorted_Gene_Intervals_Report.md"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Input file not found!"
    exit 1
fi

# Sort the data and save it to the output file
sort "$input_file" > "$output_file"

echo "Data sorted and saved to $output_file"

