# Differential Expression Analysis of Count Matrix

## Introduction
This document outlines the process of performing a differential expression analysis on a count matrix, including generating a PCA plot and a heatmap for significant genes.

## Step 1: Load Required Libraries

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.decomposition import PCA
from statsmodels.stats.multitest import multipletests
import statsmodels.api as sm

# Load the count matrix
count_matrix = pd.read_csv('count_matrix.csv', index_col=0)
print(count_matrix.head())

# Define conditions
conditions = ['Control', 'Control', 'Treatment', 'Treatment']  # Example conditions

# Create a design matrix
design = pd.DataFrame({'Intercept': 1, 'Condition': conditions})

# Fit the model
model = sm.OLS(count_matrix.T, design).fit()

# Get the results
results = model.summary()
print(results)

# Extract p-values and adjust for multiple testing
p_values = model.pvalues[1:]  # Exclude intercept
adjusted_p_values = multipletests(p_values, method='fdr_bh')[1]

# Create a DataFrame for results
de_results = pd.DataFrame({
    'p_value': p_values,
    'adjusted_p_value': adjusted_p_values
}, index=count_matrix.index)

# Filter for significant genes
significant_genes = de_results[de_results['adjusted_p_value'] < 0.05]
print(f"Number of significant genes: {len(significant_genes)}")

# Perform PCA
pca = PCA(n_components=2)
pca_result = pca.fit_transform(count_matrix.T)

# Create a DataFrame for PCA results
pca_df = pd.DataFrame(data=pca_result, columns=['PC1', 'PC2'])
pca_df['Condition'] = conditions

# Plot PCA
plt.figure(figsize=(8, 6))
sns.scatterplot(data=pca_df, x='PC1', y='PC2', hue='Condition', style='Condition', s=100)
plt.title('PCA Plot of Samples')
plt.xlabel('Principal Component 1')
plt.ylabel('Principal Component 2')
plt.legend()
plt.show()

# Heatmap of significant genes
significant_counts = count_matrix.loc[significant_genes.index]

plt.figure(figsize=(10, 8))
sns.heatmap(significant_counts, cmap='viridis', annot=True, fmt='.1f')
plt.title('Heatmap of Significant Genes')
plt.xlabel('Samples')
plt.ylabel('Genes')
plt.show()

