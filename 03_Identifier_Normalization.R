# =========================================================================
# MODULE 3: Identifier Normalization
# AUTHOR: Kuncha Shashidhar
# 
# 🧬 ABOUT THE DATA:
# Format: Inconsistent character vectors (e.g., "  Gene_A  ", "GENE_b").
# Description: When merging datasets from different databases (e.g., joining 
#              NCBI Entrez IDs with Ensembl annotations), slight differences 
#              in capitalization or hidden whitespace will cause the join to 
#              fail. Normalizing text is mandatory before data integration.
# 
# 🔍 REAL WORLD APPLICATION:
# Standardizing gene symbols (e.g., converting "tinman" and "Tin" to "TIN") 
# before mapping them to Gene Ontology (GO) databases or DESeq2 results.
# =========================================================================

library(stringr)
library(dplyr)

cat("\n--- Normalizing Biological Identifiers ---\n")

# Vector of dirty names with inconsistent case and hidden whitespace
dirty_names <- c("  Gene_A  ", "GENE_b", " gene_C_variant ")

cat("\nOriginal Dirty Names:\n")
print(dirty_names)

# Tidyverse pipeline to clean and standardize the text
clean_names <- dirty_names %>%
  str_trim() %>%        # Remove leading and trailing whitespace
  str_to_upper()        # Standardize everything to UPPERCASE

cat("\nCleaned & Normalized Names for Database Joins:\n")
print(clean_names)
