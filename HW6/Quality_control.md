
#### Quality Control Analysis of SRA Data



### Introduction
This report documents the quality control analysis of sequencing data downloaded from the SRA database. The target organism for this analysis is the genome selected for the read simulation assignment.

### Data and Publication
The data corresponds to the sequencing run with SRR number `SRR12345678`: 
Send to:

```
SRX8845474: Toolik Lake Alaska soil qSIP
1 ILLUMINA (Illumina MiSeq) run: 23,655 spots, 7.1M bases, 3.9Mb downloads
Design: two-step amplification with primers 515F (Parada) and 806R (Apprill), dual indexed (8bp)
Submitted by: Northern Arizona University
Study: Toolik Lake Alaska soil qSIP Raw sequence reads
Sample: AK-d5-5C-204f11
Organism: soil metagenome
Name: 204f11
Instrument: Illumina MiSeq
Strategy: AMPLICON
Source: METAGENOMIC
Selection: PCR
Layout: PAIREDThe publication associated with this dataset is "Toolik Lake Alaska soil qSIP Raw sequence reads".
``` 

## Sequencing Data Summary

### Runs

| Run         | # of Spots | # of Bases | Size  | Published   |
|-------------|------------|------------|-------|-------------|
| SRR12345678 | 23,655     | 7.1M       | 3.9Mb | 2020-07-29  |

[View NCBI SRA Run Browser_SRR12345678](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR12345678&display=metadata)		

#### Data and Publication from the replaced data SRR925811

```bash
SRX317818: GSM1173000: T47D Exome-Seq; Homo sapiens; OTHER
1 ILLUMINA (Illumina Genome Analyzer IIx) run: 53.3M spots, 10.7G bases, 5.1Gb downloads
Submitted by: Gene Expression Omnibus (GEO)
Study: Exome sequencing of a panel of breast cancer cell lines to identify mutations
Sample: T47D Exome-Seq
Organism: Homo sapiens
```

| Run         | # of Spots | # of Bases | Size  | Published   |
|-------------|------------|------------|-------|-------------|
| SRR925811   | 53,265,409 | 10.7G      | 5.1Gb | 2013-08-28  |

[View NCBI SRA Run Browser_SRR925811](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR925811&display=metadata)


### Results

***Initial Quality Control***
The initial quality control report indicated several issues with the sequencing data, including low-quality scores and adapter contamination.

***Quality Improvement***
After trimming, the quality of the reads improved significantly, as evidenced by higher quality scores and the removal of adapter sequences.

***Post-Improvement Quality Control***
The post-improvement quality control report showed that the quality of the reads was much better, with fewer low-quality bases and no adapter contamination. The quality control analysis demonstrated that the initial sequencing data had several quality issues, effectively addressed by trimming the reads. The final dataset is of high quality and suitable for downstream analysis.

### Downloading Data
The data was downloaded using the SRA Toolkit with the following command:
```bash
fastq-dump --outdir ./sra_data --gzip --skip-technical --readids --dumpbase --split-files --clip SRR12345678
```  
### Initial quality control 
```bash
fastqc -o ./sra_data ./sra_data/SRR12345678_1.fastq.gz ./sra_data/SSRR12345678_2.fastq.gz
```


### Reads were trimmed using Trimmomatic:
```bash
trimmomatic PE -phred33 \
  ./sra_data/SRR12345678_1.fastq.gz ./sra_data/SRR12345678_2.fastq.gz \
  ./sra_data/SRR12345678_1_paired.fastq.gz ./sra_data/SRR12345678_1_unpaired.fastq.gz \
  ./sra_data/SRR12345678_2_paired.fastq.gz ./sra_data/SRR12345678_2_unpaired.fastq.gz \  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
```

### Post-improvement quality control was performed using FastQC:
```bash
fastqc -o ./sra_data ./sra_data/SRR12345678_1_paired.fastq.gz ./sra_data/SRR12345678_2_paired.fastq.gz
```



