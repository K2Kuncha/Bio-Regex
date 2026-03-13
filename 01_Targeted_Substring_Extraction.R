# =========================================================================
# MODULE 1: Targeted Substring Extraction via Regex
# AUTHOR: Kuncha Shashidhar
# 
# 🧬 ABOUT THE DATA:
# Format: Complex character vectors (e.g., "ZZZ-1234-67890-xxx")
# Description: Biological IDs, clinical sample barcodes, and FASTA headers 
#              often contain deeply nested information. Regular Expressions 
#              (Regex) are required to extract specific alphanumeric patterns 
#              (like a core 5-digit patient or sample ID) while ignoring 
#              inconsistent prefixes and suffixes.
# 
# 🔍 REAL WORLD APPLICATION:
# Parsing clinical Laboratory Information Management System (LIMS) data or 
# extracting clean SRA accession numbers from messy metadata tables.
# =========================================================================

library(stringr)

cat("\n--- Extracting 5-Digit Core IDs ---\n")

# Mock vector of messy identifiers (e.g., from a clinical or sequencing run)
messy_ids <- c("ZZZ-1234-67890-xxx", 
               "ZZZ-99-67678-alpha", 
               "ZZZ-45678-64870-beta", 
               "ZZZ-1-33333", 
               "ZZZ-000-44444-omega")

cat("\nOriginal Messy Identifiers:\n")
print(messy_ids)

# --- The Regex Logic ---
# Pattern explanation: 
# 1. "ZZZ-"   : Matches the literal prefix
# 2. "\\d+"   : Matches one or more digits (variable length section)
# 3. "-"      : Matches the literal hyphen
# 4. "(\\d{5})": The CAPTURE GROUP -> Matches exactly 5 digits (our target)
# 5. "-*"     : Matches zero or more trailing hyphens

extracted_5_digits <- str_match(messy_ids, "ZZZ-\\_d+-(\\_d{5})-*")[,2]

cat("\nClean Extracted IDs:\n")
print(extracted_5_digits)
