#!/bin/bash
# This script displays the contents of a Markdown file in a specific color

# Define the color code
CYAN='\033[0;36m'
NC='\033[0m' # No Color

input_file="Final_organized_gff_data.md"  # Your actual file name

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo -e "${CYAN}Error: Input file '$input_file' not found.${NC}"
  exit 1
fi

# Display the contents of the file in the specified color
while IFS= read -r line; do
  echo -e "${CYAN}$line${NC}"
done < "$input_file"
