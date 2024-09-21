#!/bin/bash
# This script displays the contents of a Markdown file with three alternating line colors

# Define color codes
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

input_file="Final_organized_gff_data.md"  # Your actual file name

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo -e "${CYAN}Error: Input file '$input_file' not found.${NC}"
  exit 1
fi

# Display the contents of the file with alternating colors
line_number=0
while IFS= read -r line; do
  if (( line_number % 3 == 0 )); then
    echo -e "${CYAN}$line${NC}"
  elif (( line_number % 3 == 1 )); then
    echo -e "${YELLOW}$line${NC}"
  else
    echo -e "${GREEN}$line${NC}"
  fi
  ((line_number++))
done < "$input_file"
