#!/bin/bash
# This script prepends ###### to each line in a Markdown file

input_file="Final_organized_gff_data.md"  # Your actual file name
output_file="updated_Final_organized_gff_data.md"  # Output file name

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo "Error: Input file '$input_file' not found."
  exit 1
fi

# Clear the output file if it exists
> "$output_file"

# Read each line from the input file and prepend ######
while IFS= read -r line; do
  echo "###### $line" >> "$output_file"
done < "$input_file"

echo "Processing complete. Updated file saved as '$output_file'."

