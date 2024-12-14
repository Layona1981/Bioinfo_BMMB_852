# RNA-Seq Automation Script

# Step 1: Install Required Packages
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install(c("ShortRead", "GenomicRanges", "DESeq2", "biomaRt", "rtracklayer", "SRAdb"))

# Load Required Libraries
library(ShortRead)
library(DESeq2)
library(rtracklayer)
library(Biostrings)
library(SRAdb)

# Step 2: Set Up SRA Database Connection
sra_con <- dbConnect(RSQLite::SQLite(), "sra.sqlite")

# Step 3: Find and Download Datasets
srr_ids <- c("SRR31486905", "SRR31447817", "SRR31316866", 
             "SRR12345678", "SRR12345679", "SRR12345680", 
             "SRR12345681", "SRR12345682")

# Step 4: Download the Datasets
for (srr in srr_ids) {
    system(paste("fastq-dump --split-files", srr))
}

# Step 5: Perform RNA-Seq Analysis
# Specify the paths to the downloaded FASTQ files
fastq_files <- unlist(lapply(srr_ids, function(srr) {
    c(paste0(srr, "_1.fastq"), paste0(srr, "_2.fastq"))
}))

# Function to count reads
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

# Step 6: Save the Count Matrix
write.csv(as.data.frame(count_matrix), file = "count_matrix.csv")

# Print completion message
cat("RNA-Seq analysis completed. Count matrix saved as 'count_matrix.csv'.\n")
