````mkdir Choloepus_hoffmanni```` 

````cd Choloepus_hoffmanni````

````curl-l https://useast.ensembl.org/Choloepus_hoffmanni/Transcript/Summary?db=core;g=ENSCHOG00000015578;r=scaffold_95728:2238-2320;t=ENSCHOT00000014379````

````gunzip ENSCHOT00000014379.1_genomic.fna.gz```

````gunzip ENSCHOT00000014379.1_genomic.gff```
# Command used for getting gene.gff and cds.gff

````cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "gene"' > Choloepus_hoffmanni_genes.gff cat ENSCHOT00000014379.1_genomic.gff | awk '$3 == "CDS"' > Choloepus_hoffmanni_CDS.gff````

````head Choloepus_hoffmanni_genes.gff``` 
````head Choloepus_hoffmanni_CDC.gff````

# interegenic_region 


ENSCHOG00000007557     .       intergenic_region       2760    2845    .       .       .       ID=intergenic_2;Name=intergenic_region_2

ENSCHOG00000003694     .       intergenic_region       4797    4812    .       .       .       ID=intergenic_3;Name=intergenic_region_3

ENSCHOG00000003701     .       intergenic_region       8547    8551    .       .       .       ID=intergenic_4;Name=intergenic_region_4

ENSCHOG00000006326     .       intergenic_region       9920    9923    .       .       .       ID=intergenic_5;Name=intergenic_region_5

ENSCHOG00000013325    .       intergenic_region       12039   12068   .       .       .       ID=intergenic_6;Name=intergenic_region_6````


# genes only 

````awk '$3 == "gene" Choloepus_hoffmanni_genes.gff3 | head -n 20```` 

ENSCHOG00000006326     RefSeq  gene    686     1828    .       +       .       ID=gene-MG_RS00005;Dbxref=GeneID:88282116;Name=dnaN;gbkey=Gene;gene=dnaN;gene_biotype=protein_coding;locus_tag=MG_RS00005;old_locus_tag=MG_001

ENSCHOG00000007557     RefSeq  gene    1828    2760    .       +       .       ID=gene-MG_RS00010;Dbxref=GeneID:88282117;Name=MG_RS00010;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00010;old_locus_tag=MG_002

ENSCHOG00000003694      RefSeq  gene    2845    4797    .       +       .       ID=gene-MG_RS00015;Dbxref=GeneID:88282118;Name=gyrB;gbkey=Gene;gene=gyrB;gene_biotype=protein_coding;locus_tag=MG_RS00015;old_locus_tag=MG_003

ENSCHOG00000003701     RefSeq  gene    4812    7322    .       +       .       ID=gene-MG_RS00020;Dbxref=GeneID:88282119;Name=gyrA;gbkey=Gene;gene=gyrA;gene_biotype=protein_coding;locus_tag=MG_RS00020;old_locus_tag=MG_004

ENSCHOG00000006326     RefSeq  gene    7294    8547    .       +       .       ID=gene-MG_RS00025;Dbxref=GeneID:88282120;Name=serS;gbkey=Gene;gene=serS;gene_biotype=protein_coding;locus_tag=MG_RS00025;old_locus_tag=MG_005

ENSCHOG00000002154     RefSeq  gene    8551    9183    .       +       .       ID=gene-MG_RS00030;Dbxref=GeneID:88282121;Name=tmk;gbkey=Gene;gene=tmk;gene_biotype=protein_coding;locus_tag=MG_RS00030;old_locus_tag=MG_006

ENSCHOG00000002159    RefSeq  gene    9156    9920    .       +       .       ID=gene-MG_RS00035;Dbxref=GeneID:88282122;Name=MG_RS00035;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00035;old_locus_tag=MG_007

ENSCHOG00000001476    RefSeq  gene    9923    11251   .       +       .       ID=gene-MG_RS00040;Dbxref=GeneID:88282123;Name=mnmE;gbkey=Gene;gene=mnmE;gene_biotype=protein_coding;locus_tag=MG_RS00040;old_locus_tag=MG_008

ENSCHOG00000001476    RefSeq  gene    11251   12039   .       +       .       ID=gene-MG_RS00045;Dbxref=GeneID:88282124;Name=MG_RS00045;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00045;old_locus_tag=MG_009

ENSCHOG00000000841    RefSeq  gene    12068   12724   .       +       .       ID=gene-MG_RS00050;Dbxref=GeneID:88282125;Name=MG_RS00050;gbkey=Gene;gene_biotype=protein_coding;locus_tag=MG_RS00050;old_locus_tag=MG_010````

`` 
