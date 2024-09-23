
# Accipiter Script



1. **Make the Script Executable**:
   ```bash
   chmod +x accipiter_script.sh
   ```

2. **Run the Script**:
   ```bash
   ./accipiter_script.sh
   ```

3. **Output**:
   - The script will download the GFF3 file, extract genes, CDS, mRNA, and exons into separate files, and display counts for each.

## Requirements

- `curl`: For downloading files.
- `gunzip`: For decompressing `.gz` files.
- `awk`: For extracting specific features from the GFF3 file.

## Example Output

The script will generate the following files:
- `accipiter_nisus_genes.gff`
- `accipiter_nisus_CDS.gff`
- `accipiter_nisus_mRNA.gff`
- `accipiter_nisus_exons.gff`


