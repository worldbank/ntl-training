# Install Required Packages for BlackMarble Interactive Tutorial
#
# This script installs all packages needed to run the interactive
# BlackMarble nighttime lights tutorial.
#
# Usage: source("install_packages.R")

cat("Installing required packages for BlackMarble Interactive Tutorial...\n\n")

# List of required packages
required_packages <- c(
  # Core R packages
  "rmarkdown",
  "shiny",
  "learnr",
  
  # Data manipulation
  "tidyverse",
  "janitor",
  "here",
  
  # Spatial analysis
  "sf",
  "terra",
  "geodata",
  "exactextractr",
  "h3jsr",
  
  # Visualization
  "leaflet",
  "tidyterra",
  
  # BlackMarble and related
  "blackmarbler",
  "osmdata",
  
  # Statistics
  "fixest"
)

# Function to install packages if not already installed
install_if_missing <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat("Installing:", pkg, "\n")
      install.packages(pkg, dependencies = TRUE)
    } else {
      cat("Already installed:", pkg, "\n")
    }
  }
}

# Install CRAN packages
install_if_missing(required_packages)

# Install blackmarbler from GitHub if not available on CRAN
if (!requireNamespace("blackmarbler", quietly = TRUE)) {
  cat("Installing blackmarbler from GitHub...\n")
  if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools")
  }
  devtools::install_github("ramarty/blackmarbler")
}

cat("\n✅ Package installation complete!\n")
cat("\nNext steps:\n")
cat("1. Set up NASA Earthdata credentials (see README.md)\n")
cat("2. Run the tutorial with: source('launch_tutorial.R')\n")
cat("\nFor NASA Earthdata setup, visit:\n")
cat("https://github.com/ramarty/blackmarbler#nasa-black-marble-data\n")