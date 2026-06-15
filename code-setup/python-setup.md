# Steps to download Python

This guide will walk you through downloading and installing Python and a code editor on your computer.

**Important: You must install Python first, then a code editor. Code editors do not include Python - they are separate programs.**

## Installation on World Bank Machines

If you are using a World Bank managed computer, follow these simplified steps:

### Windows (World Bank Machines)
1. Open **Software Center** from your Start menu
2. Search for "Python" and install **Python**
3. Search for "Visual Studio Code" and install **Visual Studio Code**
4. Both applications should install automatically through the Software Center

### Mac (World Bank Machines)
1. Open **Self Service** from your Applications folder or dock
2. Search for "Python" and download/install **Python**
3. Search for "Visual Studio Code" and download/install **Visual Studio Code**
4. Both applications should install automatically through Self Service

### After Installation on World Bank Machines
- Python and VS Code should now be available in your Applications (Mac) or Start Menu (Windows)
- Proceed to [Step 3: Verify Installation](#step-3-verify-installation) below

---

## Installation on Personal Computers

If you are installing on your personal computer, follow these detailed steps:

## Step 1: Download and Install Python

**Python is the programming language itself - you need this first!**

Python is the programming language, and you need to install it first before any code editor.

1. Go to the official Python website: [https://www.python.org/](https://www.python.org/)
2. Click on "Downloads"
3. The website should automatically detect your operating system
4. Download Python 3.13
5. Select your operating system:
   - **Windows**: Click "Download Python 3.x" → Run the installer → **Important: Check "Add Python to PATH"**
   - **Mac**: Click "Download Python 3.x" → Download the .pkg file → Run installer
   - **Linux**: Most distributions include Python, but you may need to install pip separately

6. Run the downloaded installer and follow the installation prompts

## Step 2: Download and Install Visual Studio Code

**VS Code is the user-friendly interface for Python - install this after Python is installed.**

Visual Studio Code is a free code editor that makes working with Python much easier. **VS Code requires Python to be installed first for full functionality.**

1. Go to the VS Code website: [https://code.visualstudio.com/](https://code.visualstudio.com/)
2. Click "Download for [Your OS]"
3. The website should automatically detect your operating system
4. Download the installer for your system
5. Run the installer and follow the setup instructions
6. After installation, install the Python extension:
   - Open VS Code
   - Go to Extensions (Ctrl+Shift+X or Cmd+Shift+X)
   - Search for "Python" by Microsoft
   - Click Install

## Step 3: Verify Installation

1. Open VS Code
2. Open Terminal within VS Code (Terminal → New Terminal)
3. Type: `python --version` (or `python3 --version` on some systems)
4. Press Enter - you should see your Python version information
5. Try running a simple command: `python -c "print(2 + 2)"`

## Step 4: Install Required Packages

For the nighttime lights training, you'll need several Python packages. Copy and paste this code into the VS Code terminal:

```bash
# Install required packages for nighttime lights analysis
pip install numpy pandas matplotlib seaborn scipy geopandas rasterio shapely fiona pyproj folium earthengine-api requests h5py netcdf4 plotly bokeh ipywidgets tqdm jupyter
```

**Alternative: Install using conda (if you prefer Anaconda/Miniconda):**

```bash
# Create environment
conda create -n blackmarble python=3.9

# Activate environment
conda activate blackmarble

# Install packages
conda install -c conda-forge geopandas rasterio folium earthengine-api numpy pandas matplotlib seaborn jupyter plotly
```

## Troubleshooting

### Common Issues:

**Python is not found when running commands:**
- Make sure you installed Python first and checked "Add Python to PATH" on Windows
- Try using `python3` instead of `python`
- Restart your computer after installing Python

**Package installation errors:**
- Try installing packages one at a time if the bulk installation fails
- On Windows, you may need to install Microsoft Visual C++ Build Tools
- Use `pip install --user package_name` if you get permission errors

**Permission errors on Mac:**
- You may need to allow the installer in System Preferences → Security & Privacy
- Consider using `pip install --user` for user-level installations

**GDAL installation issues:**
- On Windows: Use conda instead of pip for geospatial packages
- On macOS: Install using homebrew first: `brew install gdal`
- On Linux: Install system packages: `sudo apt-get install gdal-bin libgdal-dev`

### Getting Help:

- Python.org documentation: [https://docs.python.org/3/](https://docs.python.org/3/)
- GeoPandas documentation: [https://geopandas.org/](https://geopandas.org/)
- Stack Overflow Python questions: [https://stackoverflow.com/questions/tagged/python](https://stackoverflow.com/questions/tagged/python)

## Next Steps

Once you have Python and VS Code installed, you're ready to begin the nighttime lights training materials!