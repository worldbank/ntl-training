# Python BlackMarble Training

## blackmarblepy: Overview

### BlackMarble

__Black Marble Products__

The BlackMarblepy package facilitates retrieving and working with nighttime lights data from [NASA Black Marble](https://blackmarble.gsfc.nasa.gov/). Black Marble produces a number of nighttime light products, from daily, monthly, to annual composites.

<img src="https://worldbank.github.io/ntl-training/spatial-blackmarble-training/r-training/images/bm_products.png" width="75%">

__Why blackmarblepy?__

The above image notes that produces are available via the NASA LAADS Archive. Within the archive, raw nighttime lights data are separated by (1) time and (2) tile. The below image shows a screenshot from the archive-showing raw files for January 2024.

<img src="https://worldbank.github.io/ntl-training/spatial-blackmarble-training/r-training/images/nasa_laads.png" width="75%">

In some cases, our region of interest to examine nighttime lights crosses multiple tiles. For example, 4 tiles comprise Nigeria Consequently, to examine annual trends in nighttime lights for Kenya, for each year we'd need to download 4 tiles and mosaic them together. Doing this manually can be time consuming. The `blackmarblepy` package does this all for us.

### BlackMarble Python Package - blackmarblepy

The [documentation](https://worldbank.github.io/blackmarblepy/README.html) for BlackMarbleR contains more extended documentation. This section provides a brief overview of functions and key inputs.

__Functions__

The `blackmarblepy` package contains two main functions:

* `bm_raster` For retrieving rasters of nighttime lights for a given region of interest
* `bm_extract` For retrieving zonal statistics (sum, mean, etc) of nighttime lights for a given region of interest.

__Required arguments__

Below are the main, required arguments to the functions:

* `gdf`: geodataframe object defining region of interest
* `product_id`: Black Marble product ID
  - `"VNP46A1"`: Daily (raw)
  - `"VNP46A2"`: Daily (corrected)
  - `"VNP46A3"`: Monthly
  - `"VNP46A4"`: Annual
* `date`: Date to query (can be one or multiple dates).
* `token`: NASA bearer token. For instructions on how to create a token, see [here](https://worldbank.github.io/blackmarblepy/notebooks/blackmarblepy.html#set-up-nasa-earthdata-token).

__Additional arguments__

Below are select optional arguments; for all arguments, see documentation [here](https://github.com/worldbank/blackmarbler).

* `variable`: The variable to use for nighttime lights. For monthly and annual data (`VNP46A3` and `VNP46A4`) the default is `"NearNadir_Composite_Snow_Free"`.
* `drop_values_by_quality_flag`:  List of quality flag values for which to set pixels to NaN. For examples using the quality flag, see [here](https://worldbank.github.io/blackmarblepy/notebooks/quality-assessment.html). Default is [255].
* `output_directory`: If True (default), skips re-downloading files that already exist locally.
* `aggfunc`: For `bm_extract`, a vector of functions to aggregate data (default: `"sum"`).

### Usage and Exercises

The usage examples and exercises are available as notebooks:

* [usage.ipynb](usage.ipynb)
* [preliminary_exercises.ipynb](preliminary_exercises.ipynb)
* [exercise_1.ipynb](exercise_1.ipynb)
