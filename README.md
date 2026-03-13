# 🧬 Bio-Regex: String Manipulation & Text Mining in R

### 📌 About This Repository
Biological databases often output data with complex, deeply nested text strings (e.g., dense FASTA headers or concatenated clinical IDs). A critical skill in bioinformatics is using Regular Expressions (Regex) to efficiently extract the exact substrings needed for downstream mapping.

This repository demonstrates the use of Base R and the `stringr` package to clean, parse, and mine complex biological identifiers.

### 🎯 Objective
To showcase advanced string manipulation techniques for extracting sequence accessions, calculating string lengths, and isolating specific functional IDs using pattern matching.

### 🛠️ Tools & Libraries
* **String Manipulation:** `stringr` (Tidyverse)
* **Core R:** Base R text parsing functions

### 📂 Modules Included
1. **Targeted Substring Extraction (Regex):** Using capture groups to isolate specific digits from complex, standardized identifiers (e.g., extracting 5-digit core IDs from a `ZZZ-XXXX-YYYYY-XXX` format).
2. **String Length Profiling:** Calculating sequence or string lengths across massive vectors to assess data uniformity.
3. **Identifier Normalization:** Cleaning and standardizing messy biological text data for database joins.

### 🚀 How to Use
Clone this repository and run the scripts to see the regex logic in action. The template can be easily adapted to parse UniProt, Ensembl, or custom clinical sample IDs.
