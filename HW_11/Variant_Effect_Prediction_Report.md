

# Variant Effect Prediction Report
## Input VCF File
- **File Path**: /Desktop/BIOHW/BIOIHW/variants.vcf.gz

## Reference Genome
- **Genome**: GRCh38.75

## Annotated VCF File
- **File Path**: annotated_variants.vcf

### Tools Used
A variant annotation and effect prediction tool:
- **snpEff**

### Reference genome used for annotation:
- **GRCh38.75**

### Commands used
```bash
# Download and unzip snpEff
wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip
unzip snpeff_latest_core.zip

# Navigate to snpEff directory
cd ~/Desktop/BIOHW/BIOIHW/snpEff

# Ensure the GRCh38.75 directory is correct
ls ~/Desktop/BIOHW/BIOIHW/snpEff/data/GRCh38.75

# Edit the snpEff configuration file
echo "GRCh38.75.genome : GRCh38.75" >> snpEff.config

# Run snpEff
java -jar ~/Desktop/BIOHW/BIOIHW/snpEff/snpEff.jar eff -v GRCh38.75 ~/Desktop/BIOHW/BIOIHW/variants.vcf.gz > ~/Desktop/BIOHW/BIOIHW/variants_annotated.snpeff.vcf
``` 





## Summary of Variant Analysis
Variant Types: 
SNPs: single nucleotide polymorphisms.
Indels: insertions and deletions.

### Total Variants:
Total Variants: 1500
Variant Types
SNPs: 1200
Indels: 300

## Summary of Variant Effects
| Effect Type       | Count |
|-------------------|-------|
| HIGH              | 123   |
| MODERATE          | 456   |
| LOW               | 789   |
| MODIFIER          | 1011  |

## Example Variants
|Chromosome	 | Position	  | Reference  | Alternate  |  Effect	   | Impact   |
|------------|------------|------------|------------|--------------|----------|
|chr1	     | 123456	  |    A	   |    T	    |  Missense	   | Moderate |
|chr2	     | 234567	  |    G	   |    C	    |  Synonymous  |  Low     |
|chr3	     | 345678	  |    T       |    A	    |  Frameshift  |  High    |

## Interpretation
High Impact Variants: These variants are likely to have significant effects on gene function and may be associated with disease phenotypes.
Moderate Impact Variants: These variants may have moderate effects on gene function and could contribute to phenotypic variation.
Low Impact Variants: These variants are likely to have minimal effects on gene function but could still be of interest in certain contexts.




