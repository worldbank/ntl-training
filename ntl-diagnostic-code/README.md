# Nighttime Light Diagnostics

This directory contains code to (1) produce nighttime lights data for any country (at the ADM 0-3 level, and at the city level) and (2) produces analysis of nighttime lights (e.g., trends and maps). The code leverages the BlackMarbleR package and many of the techniques described in the training. 

The next sections describe:

1. __Code:__ A code file that can be quickly adapted to any country that produces data and an analysis file.
2. __Data:__ Nighttime light datasets produced.
3. __Analysis:__ An analysis file produced by the code.

## Code

The [ntl-diagnostics.qmd](https://github.com/ramarty/ntl-training/blob/main/ntl-diagnostic-code/) file produces datasets of nighttime lights and an analysis file that shows trends and maps of nighttime lights. The code is designed to be quickly adjusted for any country. The beginning of the code contains the following required and optional parameters to adapt the code to different contexts:

__Required parameters__

* `proj_dir`: Project directory; the directory where the code will output data. If the directory doesn't exist, the code will create the directory. (e.g., `"~/Desktop/NTL Analysis"`)
* `iso3_code`: [ISO3](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3) code for country.
* `nasa_bearer`: NASA Bearer token for querying nighttime lights data; see [here](https://github.com/worldbank/blackmarbler?tab=readme-ov-file#bearer-token-) for instructions to create the token.

__Optional parameters__

_Months to query_
* `month_start`: The first month to query for querying monthly nighttime lights, in `yyy-mm-01` format (default: `"2012-01-01"`).
* `month_end`: The last month to query for querying monthly nighttime lights, in `yyy-mm-01` format (the code defaults to the current month).

_Years to query_
* `year_start`: The first year to query for querying annual nighttime lights.
* `year_end`: The last year to query for querying annual nighttime lights.

_Base year for % change maps_
* `pc_base_year`: The code produces maps that show the percent change in nighttime lights relative to a base year; this parameter defines the base year (default: `2019`).

## Data

The code produces rasters of nighttime lights and panel datasets of aggregated nighttime lights. Aggregated datasets are produced at the country up to the ADM 3 level (or the most granular level up until) and at the city level using a dataset of cities from the [GHS Urban Centre Database](https://data.jrc.ec.europa.eu/dataset/53473144-b88c-44bc-b4a3-4583ed1f547e).

_Datasets_

The nighttime lights datasets are outputted in: `/data/Nighttime Lights BlackMarble/`. Within this folder:

* `rasters` stores .tif files of rasters
* `aggregated` stores panel datasets of nighttime lights in .csv, .Rds, and .dta file formats. For example:

  - __ntl_adm0_annual.csv:__ contains annual data at the ADM0 (country) level.
  - __ntl_adm0_monthly.csv:__ contains monthly data at the ADM0 (country) level.
  - __ntl_cities_annual.csv:__ contains annual data at the city level.
  - __ntl_cities_monthly.csv:__ contains monthly data at the city level.
  
_Variables_
  
The datasets contain the following nighttime light variables:

  - __ntl_sum:__ Sum of nighttime lights within the unit.
  - __ntl_gf_5km_sum:__ Sum of nighttime lights within 5km of gas flaring locations.
  - __ntl_nogf_5km_sum:__ Sum of nighttime lights excluding areas within 5km of gas flaring locations.
  - __ntl_gf_10km_sum:__ Sum of nighttime lights within 10km of gas flaring locations.
  - __ntl_nogf_10km_sum:__ Sum of nighttime lights excluding areas within 10km of gas flaring locations.

## Analysis

The code renders `ntl-diagnostics.html`, which shows trends and maps of nighttime lights. For example output, see [here](https://html-preview.github.io/?url=https://raw.githubusercontent.com/ramarty/ntl-training/refs/heads/main/ntl-diagnostic-code/ntl-diagnostics.html).

