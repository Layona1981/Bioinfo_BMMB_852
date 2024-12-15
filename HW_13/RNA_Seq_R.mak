install.packages("BiocManager")
BiocManager::install(c("ShortRead", "GenomicRanges", "DESeq2", "biomaRt", "rtracklayer"))

library(ShortRead)
library(DESeq2)
library(rtracklayer)
library(Biostrings)

BiocManager::install("SRAdb")
library(SRAdb)

# Set up the SRA database connection
sra_con <- dbConnect(RSQLite::SQLite(), "sra.sqlite")

project_id <- "SRP123456" # Replace with your project ID
sra_data <- getSRAfile(project_id, sra_con)

# Select at least three SRR datasets
srr_ids <- sra_data$run[sra_data$run %in% c("SRR123456", "SRR123457", "SRR123458")] # Replace with actual SRR IDs

# Specify the paths to the downloaded FASTQ files
fastq_files <- c("SRR123456_1.fastq", "SRR123456_2.fastq", 
                 "SRR123457_1.fastq", "SRR123457_2.fastq",
                 "SRR123458_1.fastq", "SRR123458_2.fastq")

# Create a function to count reads
count_reads <- function(fastq_file) {
  reads <- readFastq(fastq_file)
  return(table(as.character(quality(reads))))
}

# Initialize an empty list to store counts
counts_list <- lapply(fastq_files, count_reads)

# Combine counts into a count matrix
count_matrix <- do.call(cbind, counts_list)
colnames(count_matrix) <- srr_ids

# Convert to a DESeq2 object for further analysis
dds <- DESeqDataSetFromMatrix(countData = count_matrix, 
                              colData = data.frame(condition = rep("condition", length(srr_ids))), 
                              design = ~ condition)

# Perform differential expression analysis (if needed)
dds <- DESeq(dds)

write.csv(as.data.frame(count_matrix), file = "count_matrix.csv")
