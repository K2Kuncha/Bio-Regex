# =========================================================================
# MODULE 3: Data Visualization for Sequence QC
# AUTHOR: Kuncha Shashidhar
# 
# 🧬 ABOUT THE DATA:
# Format: Computed data frames containing sequence lengths and GC content.
# Description: Once text mining and string profiling are complete, the next 
#              step is visual Quality Control. Visualizing distributions 
#              allows a researcher to instantly spot batch effects, adapter 
#              contamination, or abnormal GC bias.
# 
# 🔍 REAL WORLD APPLICATION:
# Generating publication-ready figures for supplementary materials to prove 
# the integrity of the raw sequence data before DESeq2 or Seurat clustering.
# =========================================================================

# Load required libraries
library(ggplot2)
library(dplyr)
library(stringr)

cat("\n--- Generating Visual QC Reports ---\n")

# 1. Generate a mock dataset representing 500 parsed sequences
# (In a real pipeline, this dataframe comes from Module 2)
set.seed(42)
qc_data <- data.frame(
  Read_ID = paste0("SEQ_", 1:500),
  # Simulate normal sequence lengths around 150bp (e.g., Illumina) with some noise
  Length = round(rnorm(500, mean = 150, sd = 15)), 
  # Simulate GC content around 50%
  GC_Content = rnorm(500, mean = 50, sd = 5)
)

# Introduce a few "bad" reads (adapter dimers / truncated reads) for realism
qc_data$Length[1:20] <- sample(20:40, 20, replace = TRUE)


# -------------------------------------------------------------------------
# PLOT 1: Sequence Length Distribution (Histogram)
# -------------------------------------------------------------------------
cat("Rendering Length Distribution Plot...\n")

length_plot <- ggplot(qc_data, aes(x = Length)) +
  geom_histogram(binwidth = 5, fill = "#4A90E2", color = "black", alpha = 0.8) +
  geom_vline(aes(xintercept = 50), color = "red", linetype = "dashed", size = 1) +
  annotate(\"text\", x = 60, y = 80, label = \"QC Cutoff (50bp)\", color = "red") +
  theme_minimal(base_size = 14) +
  labs(
    title = "Sequence Length Distribution",
    subtitle = "Highlighting truncated reads below 50bp threshold",
    x = "Sequence Length (bp)",
    y = "Read Count"
  )

print(length_plot)


# -------------------------------------------------------------------------
# PLOT 2: GC Content vs. Sequence Length (Scatter Plot)
# -------------------------------------------------------------------------
cat("Rendering GC Content vs. Length Plot...\n")

gc_plot <- ggplot(qc_data, aes(x = Length, y = GC_Content)) +
  geom_point(alpha = 0.5, color = "#50E3C2") +
  geom_density_2d(color = "#F5A623", alpha = 0.7) + # Adds contour lines for density
  theme_minimal(base_size = 14) +
  labs(
    title = "GC Content vs. Sequence Length",
    subtitle = "Identifying potential sequencing bias or contamination",
    x = "Sequence Length (bp)",
    y = "GC Content (%)"
  )

print(gc_plot)

cat("\nVisual QC Pipeline Complete! Plots rendered.\n")
