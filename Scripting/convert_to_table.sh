#!/bin/bash

# Input and output file names
input_file="input.md"
output_file="output.md"

# Print the table header
echo -e "| Attribute     | Value |\n|---------------|-------|" > "$output_file"

# Read the input file line by line
while IFS= read -r line; do
  # Extract the attribute and value by splitting at the first colon
  attribute=$(echo "$line" | cut -d':' -f1 | xargs)
  value=$(echo "$line" | cut -d':' -f2- | xargs)

  # Append the line to the output file in table format
  echo "| $attribute | $value |" >> "$output_file"
done < "$input_file"

echo "Conversion complete. Check the output in $output_file."
