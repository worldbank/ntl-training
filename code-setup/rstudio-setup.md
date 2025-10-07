# Steps to download R Studio

This guide will walk you through downloading and installing R and RStudio on your computer.

**Important: You must install R first, then RStudio. RStudio does not include R - they are separate programs.**

## Installation on World Bank Machines

If you are using a World Bank managed computer, follow these simplified steps:

### Windows (World Bank Machines)
1. Open **Software Center** from your Start menu
2. Search for "R" and install **R for Windows**
3. Search for "RStudio" and install **RStudio Desktop**
4. Both applications should install automatically through the Software Center

### Mac (World Bank Machines)
1. Open **Self Service** from your Applications folder or dock
2. Search for "R" and download/install **R for Mac**
3. Search for "RStudio" and download/install **RStudio Desktop**
4. Both applications should install automatically through Self Service

### After Installation on World Bank Machines
- R and RStudio should now be available in your Applications (Mac) or Start Menu (Windows)
- Proceed to [Step 3: Verify Installation](#step-3-verify-installation) below

---

## Installation on Personal Computers

If you are installing on your personal computer, follow these detailed steps:

## Step 1: Download and Install R

**R is the programming language itself - you need this first!**

R is the programming language, and you need to install it first before RStudio.

1. Go to the official R website: [https://www.r-project.org/](https://www.r-project.org/)
2. Click on "CRAN" (Comprehensive R Archive Network)
3. Choose a mirror location close to you
4. Select your operating system:
   - **Windows**: Click "Download R for Windows" → "base" → Download the latest version
   - **Mac**: Click "Download R for (Mac) OS X" → Download the latest .pkg file
   - **Linux**: Follow the instructions for your specific distribution

5. Run the downloaded installer and follow the installation prompts

## Step 2: Download and Install RStudio

**RStudio is the user-friendly interface for R - install this after R is installed.**

RStudio is the integrated development environment (IDE) that makes working with R much easier. **RStudio requires R to be installed first - it does not include R.**

1. Go to the RStudio website: [https://posit.co/downloads/](https://posit.co/downloads/)
2. Scroll down to "RStudio Desktop" 
3. Click "Download RStudio Desktop"
4. The website should automatically detect your operating system
5. Download the installer for your system
6. Run the installer and follow the setup instructions

## Step 3: Verify Installation

1. Open RStudio (not just R)
2. You should see a interface with multiple panes
3. In the Console pane (usually bottom-left), type: `R.version.string`
4. Press Enter - you should see your R version information
5. Try running a simple command: `2 + 2`

## Step 4: Install Required Packages

For the nighttime lights training, you'll need several R packages. Copy and paste this code into the RStudio console:

```r
# Install required packages for nighttime lights analysis
install.packages(c(
  "tidyverse",
  "sf", 
  "terra",
  "leaflet",
  "blackmarbler",
  "geodata",
  "osmdata",
  "exactextractr",
  "here"
))
```

## Troubleshooting

### Common Issues:

**R is not found when installing RStudio:**
- Make sure you installed R first before RStudio
- Restart your computer after installing R

**Package installation errors:**
- Try installing packages one at a time if the bulk installation fails
- On Windows, you may need to install Rtools: [https://cran.r-project.org/bin/windows/Rtools/](https://cran.r-project.org/bin/windows/Rtools/)

**Permission errors on Mac:**
- You may need to allow the installer in System Preferences → Security & Privacy

### Getting Help:

- RStudio Community: [https://community.rstudio.com/](https://community.rstudio.com/)
- R Help documentation: Type `?function_name` in the console for help on specific functions
- Stack Overflow R questions: [https://stackoverflow.com/questions/tagged/r](https://stackoverflow.com/questions/tagged/r)

## Next Steps

Once you have R and RStudio installed, you're ready to begin the nighttime lights training materials!