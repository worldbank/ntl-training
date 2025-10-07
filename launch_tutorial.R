# Launch Interactive BlackMarble Tutorial
# 
# This script launches the interactive Shiny tutorial for learning
# how to work with BlackMarble nighttime lights data in R.
#
# Prerequisites:
# 1. Install required packages (see install_packages.R)
# 2. Set up NASA Earthdata credentials
#
# Usage:
# source("launch_tutorial.R")
# or run: rmarkdown::run("trainings/interactive-blackmarble-tutorial.Rmd")

# Check if required packages are installed
required_packages <- c(
  "learnr", "shiny", "rmarkdown", "blackmarbler", 
  "sf", "terra", "tidyverse", "leaflet", "geodata"
)

missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]

if(length(missing_packages) > 0) {
  cat("Missing required packages:", paste(missing_packages, collapse = ", "), "\n")
  cat("Please install them first using:\n")
  cat("install.packages(c(", paste0("'", missing_packages, "'", collapse = ", "), "))\n")
  stop("Please install missing packages before running the tutorial.")
}

# Set up Pandoc path (using Quarto's Pandoc if available)
if (file.exists("./bin/tools/aarch64/pandoc")) {
  Sys.setenv(RSTUDIO_PANDOC = file.path(getwd(), "bin/tools/aarch64"))
  cat("✅ Using Quarto's Pandoc (aarch64)\n")
} else if (file.exists("./bin/tools/x86_64/pandoc")) {
  Sys.setenv(RSTUDIO_PANDOC = file.path(getwd(), "bin/tools/x86_64"))
  cat("✅ Using Quarto's Pandoc (x86_64)\n")
} else {
  cat("⚠️  Using system Pandoc (if available)\n")
}

# Verify Pandoc is available
if (!rmarkdown::pandoc_available()) {
  stop("❌ Pandoc not found. Please install Pandoc or use a system with Quarto installed.")
}

# Launch the tutorial
cat("🚀 Launching Interactive BlackMarble Tutorial...\n")
cat("📱 The tutorial will open in your default web browser.\n")
cat("🛑 Close the browser tab and stop the R session (Ctrl+C) to exit.\n\n")

rmarkdown::run("trainings/interactive-blackmarble-tutorial.Rmd")