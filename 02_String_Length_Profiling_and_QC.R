# =========================================================================
# MODULE 2: Sequence Length Profiling & Quality Control (QC)
# AUTHOR: Kuncha Shashidhar
# 
# 🧬 ABOUT THE DATA:
# Format: Character vectors representing biological sequences (DNA/RNA).
# Description: Raw sequence data often contains artifacts such as truncated 
#              reads, adapter dimers, or unusually long concatemers. Profiling 
#              sequence length and basic nucleotide composition is the first 
#              line of defense in a QC pipeline.
# 
# 🔍 REAL WORLD APPLICATION:
# 1. Filtering out reads < 50bp before running DESeq2 or scRNA-seq mapping.
# 2. Calculating GC content to check for sequencing bias.
# 3. Generating length distribution plots for publication supplementary data.
# =========================================================================

# Load required libraries
library(stringr)
library(dplyr)
library(ggplot2)

cat("\n--- Phase 1: Profiling Sequence Lengths ---\n")

# Mock vector of raw DNA sequences of varying lengths and qualities
raw_sequences <- c(
  "ACGTACGTACGTACGT",                  # Normal read
  "GGTTAA",                            # Too short (artifact/dimer)
  "TTAACCGGTT",                        # Marginal
  "CCGGCCGGCCGGCCGGCCGGCCGGCCGG",      # Long read
  "ATGCATGCATGCAT",                    # Normal read
  "GCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGC"   # High GC read
)

# Put into a dataframe for Tidyverse manipulation
seq_df <- data.frame(Sequence = raw_sequences)

# Calculate lengths using stringr
seq_df <- seq_df %>%
  mutate(Length = str_length(Sequence))

cat("\nRaw Sequence Lengths:\n")
print(seq_df)


cat("\n--- Phase 2: Quality Filtering by Length Threshold ---\n")

# Set our QC thresholds (e.g., keeping reads only between 10 and 50 bp)
min_length <- 10
max_length <- 50

filtered_seq_df <- seq_df %>%
  filter(Length >= min_length & Length <= max_length)

cat(sprintf("\nFiltered out %d sequences that failed length QC.\n", 
            nrow(seq_df) - nrow(filtered_seq_df)))


cat("\n--- Phase 3: GC Content Calculation ---\n")

# GC content is crucial for spotting PCR bias or target enrichment
# Logic: Count all 'G' and 'C' characters, divide by total string length

qc_final_df <- filtered_seq_df %>%
  mutate(
    G_count = str_count(Sequence, "G"),
    C_count = str_count(Sequence, "C"),
    GC_Content_Pct = round(((G_count + C_count) / Length) * 100, 2)
  ) %>%
  select(Sequence, Length, GC_Content_Pct) # Clean up output columns

cat("\nFinal QC Table (Length & GC Content):\n")
print(qc_final_df)


cat("\n--- Phase 4: Visualization (Length Distribution) ---\n")

# In a real dataset with millions of reads, visual QC is mandatory.
# Generating a quick histogram of sequence lengths using ggplot2.

length_plot <- ggplot(qc_final_df, aes(x = Length)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "black", alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "Sequence Length Distribution Post-QC",
    x = "Sequence Length (bp)",
    y = "Frequency"
  )

# Display the plot
print(length_plot)

cat("\nSequence Profiling & QC Pipeline Complete!\n")
