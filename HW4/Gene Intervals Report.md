Gene Intervals Report

!Gene Image (https://github.com/Layona1981/Bioinfo_BMMB_852/blob/main/Gene_image.png) ## Input Data 

Below is the input data from the `genes_only.gff3` file:

```
GeneScaffold_1	ensembl	gene	403	2242	.	-	.	ID=gene:ENSCHOG00000007933;biotype=protein_coding;gene_id=ENSCHOG00000007933;logic_name=ensembl_projection;version=1
GeneScaffold_10	ensembl	gene	90	140795	.	+	.	ID=gene:ENSCHOG00000006326;Name=CFTR;biotype=protein_coding;description=CF transmembrane conductance regulator [Source:HGNC Symbol%3BAcc:HGNC:1884];gene_id=ENSCHOG00000006326;logic_name=ensembl_projection;version=1
GeneScaffold_100	ensembl	gene	3790	41762	.	+	.	ID=gene:ENSCHOG00000007557;Name=CDKL5;biotype=protein_coding;description=cyclin dependent kinase like 5 [Source:HGNC Symbol%3BAcc:HGNC:11411];gene_id=ENSCHOG00000007557;logic_name=ensembl_projection;version=1
GeneScaffold_1000	ensembl	gene	210	23732	.	-	.	ID=gene:ENSCHOG00000003694;biotype=protein_coding;gene_id=ENSCHOG00000003694;logic_name=ensembl_projection;version=1
GeneScaffold_1000	ensembl	gene	29996	43356	.	+	.	ID=gene:ENSCHOG00000003701;biotype=protein_coding;description=distal membrane arm assembly complex 2 like [Source:HGNC Symbol%3BAcc:HGNC:18799];gene_id=ENSCHOG00000003701;logic_name=ensembl_projection;version=1
GeneScaffold_1001	ensembl	gene	624	46343	.	-	.	ID=gene:ENSCHOG00000013325;Name=TXNDC16;biotype=protein_coding;description=thioredoxin domain containing 16 [Source:HGNC Symbol%3BAcc:HGNC:19965];gene_id=ENSCHOG00000013325;logic_name=ensembl_projection;version=1
GeneScaffold_1002	ensembl	gene	7940	19663	.	+	.	ID=gene:ENSCHOG00000002154;Name=RTRAF;biotype=protein_coding;description=RNA transcription%2C translation and transport factor [Source:HGNC Symbol%3BAcc:HGNC:23169];gene_id=ENSCHOG00000002154;logic_name=ensembl_projection;version=1
GeneScaffold_1002	ensembl	gene	20658	75893	.	-	.	ID=gene:ENSCHOG00000002159;Name=NID2;biotype=protein_coding;description=nidogen 2 [Source:HGNC Symbol%3BAcc:HGNC:13389];gene_id=ENSCHOG00000002159;logic_name=ensembl_projection;version=1
GeneScaffold_1003	ensembl	gene	4	14249	.	+	.	ID=gene:ENSCHOG00000001476;Name=SF3B2;biotype=protein_coding;description=splicing factor 3b subunit 2 [Source:HGNC Symbol%3BAcc:HGNC:10769];gene_id=ENSCHOG00000001476;logic_name=ensembl_projection;version=1
GeneScaffold_1004	ensembl	gene	3704	26505	.	+	.	ID=gene:ENSCHOG00000000841;biotype=protein_coding;gene_id=ENSCHOG00000000841;logic_name=ensembl_projection;version=1
```

## Output

The output of the analysis based on the input data is as follows:

- **Total Genes Identified**: 10

### Gene Details

```
GeneScaffold_1: ID=gene:ENSCHOG00000007933; biotype=protein_coding
GeneScaffold_10: ID=gene:ENSCHOG00000006326; Name=CFTR; biotype=protein_coding
GeneScaffold_100: ID=gene:ENSCHOG00000007557; Name=CDKL5; biotype=protein_coding
GeneScaffold_1000: ID=gene:ENSCHOG00000003694; biotype=protein_coding
GeneScaffold_1000: ID=gene:ENSCHOG00000003701; biotype=protein_coding
GeneScaffold_1001: ID=gene:ENSCHOG00000013325; Name=TXNDC16; biotype=protein_coding
GeneScaffold_1002: ID=gene:ENSCHOG00000002154; Name=RTRAF; biotype=protein_coding
GeneScaffold_1002: ID=gene:ENSCHOG00000002159; Name=NID2; biotype=protein_coding
GeneScaffold_1003: ID=gene:ENSCHOG00000001476; Name=SF3B2; biotype=protein_coding
GeneScaffold_1004: ID=gene:ENSCHOG00000000841; biotype=protein_coding
```

## Discussion

The provided gene intervals represent various genes found within the dataset. Each entry includes details such as ID, biotype, and additional annotations.

## Conclusion

This report provides the foundation for further analysis of the gene intervals and their biological significance.

````
mkdir Choloepus_hoffmanni
```` 

````
cd Choloepus_hoffmanni
````

````
curl-l https://useast.ensembl.org/Choloepus_hoffmanni/Transcript/Summary?db=core;g=ENSCHOG00000015578;r=scaffold_95728:2238-2320;t=ENSCHOT00000014379
```` 

````
gunzip ENSCHOT00000014379.1_genomic.fna.gz
````

````
gunzip ENSCHOT00000014379.1_genomic.gff
````
## Command used for getting gene.gff and cds.gff

````
cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "gene"' > Choloepus_hoffmanni_genes.gff cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "CDS"' > Choloepus_hoffmanni_CDS.gff
````

````
head Choloepus_hoffmanni_genes.gff
````
````
head Choloepus_hoffmanni_CDC.gff
````

## Interegenic_region 


ENSCHOG00000007557     .       intergenic_region       2760    2845    .       .       .       ID=intergenic_2;Name=intergenic_region_2

ENSCHOG00000003694     .       intergenic_region       4797    4812    .       .       .       ID=intergenic_3;Name=intergenic_region_3

ENSCHOG00000003701     .       intergenic_region       8547    8551    .       .       .       ID=intergenic_4;Name=intergenic_region_4

ENSCHOG00000006326     .       intergenic_region       9920    9923    .       .       .       ID=intergenic_5;Name=intergenic_region_5

ENSCHOG00000013325    .       intergenic_region       12039   12068   .       .       .       ID=intergenic_6;Name=intergenic_region_6````


## Genes only 

````
awk '$3 == "gene" Choloepus_hoffmanni_genes.gff3 | head -n 20
```` 

ENSCHOG00000006326     RefSeq  gene    686     1828    .       +       .       ID=gene-MG_RS00005;Dbxref=GeneID:88282116;Name=dnaN;gbkey=Gene;gene=dnaN;gene_biotype=protein_coding;locus_tag=MG_RS00005;old_locus_tag=MG_001

ENSCHOG00000007557     RefSeq  gene    1828    2760    .       +       .       ID=gene-MG_RS00010;Dbxref=GeneID:88282117;Name=MG_RS00010;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00010;old_locus_tag=MG_002

ENSCHOG00000003694      RefSeq  gene    2845    4797    .       +       .       ID=gene-MG_RS00015;Dbxref=GeneID:88282118;Name=gyrB;gbkey=Gene;gene=gyrB;gene_biotype=protein_coding;locus_tag=MG_RS00015;old_locus_tag=MG_003

ENSCHOG00000003701     RefSeq  gene    4812    7322    .       +       .       ID=gene-MG_RS00020;Dbxref=GeneID:88282119;Name=gyrA;gbkey=Gene;gene=gyrA;gene_biotype=protein_coding;locus_tag=MG_RS00020;old_locus_tag=MG_004

ENSCHOG00000006326     RefSeq  gene    7294    8547    .       +       .       ID=gene-MG_RS00025;Dbxref=GeneID:88282120;Name=serS;gbkey=Gene;gene=serS;gene_biotype=protein_coding;locus_tag=MG_RS00025;old_locus_tag=MG_005

ENSCHOG00000002154     RefSeq  gene    8551    9183    .       +       .       ID=gene-MG_RS00030;Dbxref=GeneID:88282121;Name=tmk;gbkey=Gene;gene=tmk;gene_biotype=protein_coding;locus_tag=MG_RS00030;old_locus_tag=MG_006

ENSCHOG00000002159    RefSeq  gene    9156    9920    .       +       .       ID=gene-MG_RS00035;Dbxref=GeneID:88282122;Name=MG_RS00035;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00035;old_locus_tag=MG_007

ENSCHOG00000001476    RefSeq  gene    9923    11251   .       +       .       ID=gene-MG_RS00040;Dbxref=GeneID:88282123;Name=mnmE;gbkey=Gene;gene=mnmE;gene_biotype=protein_coding;locus_tag=MG_RS00040;old_locus_tag=MG_008

ENSCHOG00000001476    RefSeq  gene    11251   12039   .       +       .       ID=gene-MG_RS00045;Dbxref=GeneID:88282124;Name=MG_RS00045;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00045;old_locus_tag=MG_009

ENSCHOG00000000841    RefSeq  gene    12068   12724   .       +       .       ID=gene-MG_RS00050;Dbxref=GeneID:88282125;Name=MG_RS00050;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00050;old_locus_tag=MG_010

