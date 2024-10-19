echo "# Makefile Commands" > README.md
echo "" >> README.md
echo "## Usage" >> README.md
echo "\`\`\`" >> README.md
echo "make usage" >> README.md
echo "\`\`\`" >> README.md
echo "Displays the available Makefile targets." >> README.md
echo "" >> README.md

echo "## Download Genome" >> README.md
echo "\`\`\`" >> README.md
echo "make genome" >> README.md
echo "\`\`\`" >> README.md
echo "Downloads and unzips the reference genome." >> README.md
echo "" >> README.md

echo "## Download Reads from SRA" >> README.md
echo "\`\`\`" >> README.md
echo "make download" >> README.md
echo "\`\`\`" >> README.md
echo "Downloads reads from SRA and runs FastQC." >> README.md
echo "" >> README.md

echo "## Trim Reads" >> README.md
echo "\`\`\`" >> README.md
echo "make trim" >> README.md
echo "\`\`\`" >> README.md
echo "Trims reads using Trimmomatic and runs FastQC." >> README.md
echo "" >> README.md

echo "## Index Reference Genome" >> README.md
echo "\`\`\`" >> README.md
echo "make index" >> README.md
echo "\`\`\`" >> README.md
echo "Indexes the reference genome using BWA." >> README.md
echo "" >> README.md

echo "## Align Reads" >> README.md
echo "\`\`\`" >> README.md
echo "make align" >> README.md
echo "\`\`\`" >> README.md
echo "Aligns reads to the reference genome, sorts, and indexes the BAM files." >> README.md
echo "" >> README.md

echo "## Visualize BAM Files" >> README.md
echo "\`\`\`" >> README.md
echo "make visualize" >> README.md
echo "\`\`\`" >> README.md
echo "Visualizes BAM files using Qualimap." >> README.md
echo "" >> README.md

echo "## Generate Alignment Statistics" >> README.md
echo "\`\`\`" >> README.md
echo "make stats" >> README.md
echo "\`\`\`" >> README.md
echo "Generates alignment statistics using SAMtools." >> README.md
echo "" >> README.md

echo "## Describe Differences Between Datasets" >> README.md
echo "\`\`\`" >> README.md
echo "make describe" >> README.md
echo "\`\`\`" >> README.md
echo "Provides a brief description of the differences between simulated and SRA reads." >> README.md
