# Install tools using Homebrew
brew install wget samtools sra-toolkit hisat2
# Install R packages for analysis
install.packages(c("BiocManager", "ggplot2", "pheatmap", "data.table"))
BiocManager::install(c("Rsubread", "DESeq2", "edgeR", "apeglm"))
# Download genome and annotation files
system("wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.fna.gz")
system("wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/005/845/GCF_000005845.2_ASM584v2/GCF_000005845.2_ASM584v2_genomic.gff.gz")

# Unzip genome files
system("gunzip GCF_000005845.2_ASM584v2_genomic.fna.gz")
system("gunzip GCF_000005845.2_ASM584v2_genomic.gff.gz")

# Download RNA-Seq data using SRA Toolkit
system("prefetch SRR390728 SRR390729 SRR390730")
system("fasterq-dump SRR390728 SRR390729 SRR390730")
# Build HISAT2 index
system("hisat2-build GCF_000005845.2_ASM584v2_genomic.fna ecoli_index")

# Align reads to reference genome
system("hisat2 -x ecoli_index -1 SRR390728_1.fastq -2 SRR390728_2.fastq -S SRR390728.sam")
system("hisat2 -x ecoli_index -1 SRR390729_1.fastq -2 SRR390729_2.fastq -S SRR390729.sam")
system("hisat2 -x ecoli_index -1 SRR390730_1.fastq -2 SRR390730_2.fastq -S SRR390730.sam")
# Convert SAM to BAM and sort
system("samtools view -bS SRR390728.sam > SRR390728.bam")
system("samtools sort SRR390728.bam -o SRR390728.sorted.bam")
system("samtools index SRR390728.sorted.bam")

system("samtools view -bS SRR390729.sam > SRR390729.bam")
system("samtools sort SRR390729.bam -o SRR390729.sorted.bam")
system("samtools index SRR390729.sorted.bam")

system("samtools view -bS SRR390730.sam > SRR390730.bam")
system("samtools sort SRR390730.bam -o SRR390730.sorted.bam")
system("samtools index SRR390730.sorted.bam")
library(Rsubread)

# Perform featureCounts to generate count matrix
featureCounts(
  files = c("SRR390728.sorted.bam", "SRR390729.sorted.bam", "SRR390730.sorted.bam"),
  annot.ext = "GCF_000005845.2_ASM584v2_genomic.gff",
  isGTFAnnotationFile = TRUE,
  GTF.attrType = "gene_id",
  isPairedEnd = TRUE,
  strandSpecific = 0,
  nthreads = 4,
  output.file = "count_matrix.txt"
)
library(DESeq2)
library(data.table)

# Load count matrix
count_data <- fread("count_matrix.txt", skip = 1)
count_data <- as.data.frame(count_data)
rownames(count_data) <- count_data$Geneid
count_data <- count_data[, -(1:6)]  # Keep only count columns

# Set sample information
colnames(count_data) <- c("SRR390728", "SRR390729", "SRR390730")
sample_info <- data.frame(
  row.names = colnames(count_data),
  condition = c("treated", "control", "control")
)

# DESeq2 analysis
dds <- DESeqDataSetFromMatrix(countData = count_data, colData = sample_info, design = ~condition)
dds <- DESeq(dds)
res <- results(dds)

# Filter significant genes
sig_genes <- res[which(res$padj < 0.05), ]
write.csv(sig_genes, "significant_genes.csv")
library(ggplot2)
library(pheatmap)

# PCA plot
rld <- rlog(dds, blind = FALSE)
pcaData <- plotPCA(rld, intgroup = "condition", returnData = TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))

ggplot(pcaData, aes(x = PC1, y = PC2, color = condition)) +
  geom_point(size = 3) +
  xlab(paste0("PC1: ", percentVar[1], "% variance")) +
  ylab(paste0("PC2: ", percentVar[2], "% variance")) +
  ggtitle("PCA Plot") +
  theme_minimal()

# Heatmap of significant genes
sig_genes_counts <- assay(rld)[rownames(sig_genes), ]
pheatmap(sig_genes_counts, scale = "row", show_rownames = FALSE, 
         cluster_cols = TRUE, main = "Heatmap of Significant Genes")
write.csv(count_data, "normalized_counts.csv")
ggsave("PCA_plot.png")
ggsave("Heatmap.png")
