#!/bin/bash
# This script displays the contents of a Markdown file, coloring specific keywords

# Define color codes
CYAN='\033[0;36m'  # For gene names
YELLOW='\033[0;33m'  # For IDs
GREEN='\033[0;32m'  # For biotypes
NC='\033[0m'  # No Color

input_file="Final_organized_gff_data.md"  # Your actual file name

# Check if the input file exists
if [[ ! -f "$input_file" ]]; then
  echo -e "${CYAN}Error: Input file '$input_file' not found.${NC}"
  exit 1
fi

# Function to colorize text
colorize() {
  local text="$1"
  text=$(echo "$text" | sed -E "s/(gene name)/${CYAN}\1${NC}/g")
  text=$(echo "$text" | sed -E "s/(ID)/${YELLOW}\1${NC}/g")
  text=$(echo "$text" | sed -E "s/(biotype)/${GREEN}\1${NC}/g")
  echo -e "$text"
}

# Display the contents of the file with colored keywords
while IFS= read -r line; do
  colorize "$line"
done < "$input_file"
