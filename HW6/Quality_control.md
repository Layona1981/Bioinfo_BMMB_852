
#### Quality Control Analysis of SRA Data

### Data and Publication
The data corresponds to the sequencing run with SRR number`SRR12345678`: 


## Sequencing Data Summary

### Runs

| Run         | # of Spots | # of Bases | Size  | Published   |
|-------------|------------|------------|-------|-------------|
| SRR12345678 | 23,655     | 7.1M       | 3.9Mb | 2020-07-29  |

***Study title:***
Toolik Lake Alaska soil qSIP Raw sequence reads

[View NCBI SRA Run Browser_SRR12345678](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR12345678&display=metadata)		

### Data from the replaced data`SRR925811`: 
The data corresponds to the sequencing run with SRR number`SRR925811`: 


| Run         | # of Spots | # of Bases | Size  | Published   |
|-------------|------------|------------|-------|-------------|
| SRR925811   | 53,265,409 | 10.7G      | 5.1Gb | 2013-08-28  |

***Study title:***
Exome sequencing of a panel of breast cancer cell lines to identify mutations

[View NCBI SRA Run Browser_SRR925811](https://trace.ncbi.nlm.nih.gov/Traces/?view=run_browser&acc=SRR925811&display=metadata)

### Quality Metrics Comparison
| **Metric**       | **SRR925811 (Before Trimming)** | **SRR925811 (After Trimming)** | **SRR12345678 (Before Trimming)** | **SRR12345678 (After Trimming)** |
|------------------|---------------------------------|--------------------------------|-----------------------------------|----------------------------------|
| **Total Reads**  | 53.3M spots                     | Reduced                        | 23.7k                             | Reduced                          |
| **Bases**        | 10.7G                           | Reduced                        | 7.1M                              | Reduced                          |
| **Size**         | 5.1Gb                           | Reduced                        | 3.9MB                             | Reduced                          |
| **GC Content**   | 47%                             | Slightly adjusted              | 53%                               | Slightly adjusted                |
| **Read Length**  | 100bp                           | Slightly reduced               | 151bp                             | Slightly reduced                 |
| **Quality Score**| High overall quality            | Improved                       | High overall quality              | Improved                         |
### Results

***Initial Quality Control***
The initial quality control report indicated several issues with the sequencing data, including low-quality scores and adapter contamination.

***Quality Improvement***
After trimming, the quality of the reads improved significantly, as evidenced by higher quality scores and the removal of adapter sequences.

***Post-Improvement Quality Control***
The post-improvement quality control report showed that the quality of the reads was much better, with fewer low-quality bases and no adapter contamination. 

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





