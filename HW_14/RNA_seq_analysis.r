library(optparse)

option_list <- list(
  make_option(c("--input"), type="character", help="Input count matrix"),
  make_option(c("--output"), type="character", help="Output directory")
)

opt_parser <- OptionParser(option_list=option_list)
opts <- parse_args(opt_parser)

input_file <- opts$input
output_dir <- opts$output

# Load necessary library
library(dplyr)  # Optional, for data manipulation

# Specify the path to your count matrix file
input_file <- "path/to/your/count_matrix.csv"

# Load the count data
count_data <- read.csv(input_file, row.names = 1)

# View the first few rows of the data
head(count_data)

count_data <- read.table("path/to/your/count_matrix.txt", header = TRUE, row.names = 1)

# Install DESeq2 if not already installed
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("DESeq2")

# Load the DESeq2 package
library(DESeq2)

# Load count data
count_data <- read.csv("path/to/your/count_matrix.csv", row.names = 1)

# Create a sample information data frame
col_data <- data.frame(
    condition = factor(c("Control", "Control", "Treatment", "Treatment")) # Adjust based on your design
)

# Create DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = count_data, colData = col_data, design = ~ condition)

# Pre-filtering (optional)
dds <- dds[rowSums(counts(dds)) > 1, ]

# Run the DESeq function
dds <- DESeq(dds)

# Get results
results <- results(dds)

# View summary of results
summary(results)

# Add adjusted p-values
results$padj <- p.adjust(results$pvalue, method = "BH")

# Volcano plot
library(ggplot2)

ggplot(as.data.frame(results), aes(x = log2FoldChange, y = -log10(pvalue))) +
    geom_point() +
    theme_minimal() +
    labs(title = "Volcano Plot", x = "Log2 Fold Change", y = "-Log10 P-value")

# Create the volcano plot
volcano_plot <- ggplot(as.data.frame(results), aes(x = log2FoldChange, y = -log10(pvalue))) +
    geom_point() +
    theme_minimal() +
    labs(title = "Volcano Plot", x = "Log2 Fold Change", y = "-Log10 P-value")

# Save the volcano plot
ggsave("volcano_plot.png", plot = volcano_plot, width = 8, height = 6)

# Perform PCA
vsd <- varianceStabilizingTransformation(dds)
pca_data <- plotPCA(vsd, intgroup = "condition", returnData = TRUE)

# Create PCA plot
pca_plot <- ggplot(pca_data, aes(x = PC1, y = PC2, color = condition)) +
    geom_point(size = 3) +
    theme_minimal() +
    labs(title = "PCA Plot")

# Save the PCA plot
ggsave("pca_plot.png", plot = pca_plot, width = 8, height = 6)

# Load pheatmap
library(pheatmap)

# Create a heatmap
heatmap_data <- assay(vsd)[rowMeans(counts(dds)) > 1, ]  # Filter for visualization
pheatmap_plot <- pheatmap(heatmap_data, cluster_rows = TRUE, cluster_cols = TRUE)

# Save the heatmap
png("heatmap.png", width = 800, height = 600)
print(pheatmap_plot)
dev.off()
