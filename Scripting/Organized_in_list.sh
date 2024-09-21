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
    echo -e "Scaffold: $scaffold\nStart: $start\nEnd: $end\nStrand: $strand\nID: $id\nName: $name\nBiotype: $biotype\nDescription: $description\nGene ID: $gene_id\nLogic Name: $logic_name\nVersion: $version\n" >> "$output_file"
}

# Initialize the output file
echo -e "Organized Gene Intervals Report\n" > "$output_file"

# Read the input file line by line and parse each line
while IFS= read -r line; do
    if [[ $line == *"ID=gene:"* ]]; then
        parse_line "$line"
    fi
done < "$input_file"

echo "Data organized and saved to $output_file"

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

#!/bin/bash
# This script displays the contents of a Markdown file with alternating line colors

# Define color codes
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
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
  if (( line_number % 2 == 0 )); then
    echo -e "${CYAN}$line${NC}"
  else
    echo -e "${YELLOW}$line${NC}"
  fi
  ((line_number++))
done < "$input_file"

