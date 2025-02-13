# Nighttime Lights for Economic Analysis

## Background

This material was jointly developed by the [ieConnect](https://www.worldbank.org/en/about/unit/unit-dec/impactevaluation/partnerships/ieconnect) team and [OTHER] as an introduction to using nighttime lights for economic analysis.

## Course description

Nighttime lights have become a widely used data sources, including in the social sciencies literature. [Henderson, Storeygard, and Weil's](https://www.aeaweb.org/articles?id=10.1257/aer.102.2.994) seminal 2012 paper illustrated the use of leveraging nighttime lights to measure economic growth. Their paper helped launch the use of nighttime lights in a variety of applications; a Google scholar search of ["nighttime lights economics"](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C9&q=nighttime+lights+economics&btnG=) brings over 40,000 responses. In addition to leverage nighttime lights as a proxy for economic activity, nighttime lights has been used for various applications such as tracking [urbanization](https://www.sciencedirect.com/science/article/abs/pii/S0034425797000461) and examining impacts of [natural disasters](https://www.sciencedirect.com/science/article/abs/pii/S0143622819308525), [conflict](https://www.mdpi.com/2072-4292/10/6/858), and [infrastructure improvements](https://documents.worldbank.org/en/publication/documents-reports/documentdetail/099332404062230683/idu073a7158605532046490b712098aed9008539).

This course provides an overview of using nighttime lights data, with a focus for economic applications. It covers the different sources of nighttime lights, how to query and aggregate data, and addressing data quality with nighttime lights (eg, cloud cover). The course focuses on [NASA Black Marble](https://blackmarble.gsfc.nasa.gov/) data, using the [BlackMarbleR](https://worldbank.github.io/blackmarbler/) (for R) and [BlackMarblePy](https://github.com/worldbank/blackmarblepy) (for Python) packages for querying data.

## Prerequisites

The course assumes familiarity with R or Python. For an introduction to these programming languages, see the DIME Analytics [R training](https://github.com/worldbank/dime-r-training) and the DIME Analytics and DECID [Python training](https://github.com/worldbank/dec-python-course).

## Training content

1. __Introduction to Spatial Analysis__ [[R](https://html-preview.github.io/?url=https://raw.githubusercontent.com/ramarty/ntl-training/refs/heads/main/trainings/01_spatial_analysis_review.html) | _Python coming later!_]: Overview of working with vector and raster spatial data in R.
2. __Nighttime Lights for Economic Analysis__ [[PDF](https://github.com/ramarty/ntl-training/blob/main/trainings/02_into_nighttime_lights.pdf)]: Overview of nighttime light datasets and use of nighttime lights for economic and social science analysis.
3. __Nighttime Lights Analysis in R__ [[R](https://html-preview.github.io/?url=https://raw.githubusercontent.com/ramarty/ntl-training/refs/heads/main/trainings/03_intro_blackmarbler.html) | _Python coming later!_]: Provides of overview of querying and analyzing nighttime lights data in R.

## NTL country diagnostic

In addition to providing training content, this repository contains code to quickly (1) produce nighttime lights data for any country (at the ADM0 - ADM3 level, and at the city level) and (2) produces analysis of nighttime lights (e.g., trends and maps). This code file is intended as a start to nighttime lights analysis for a country; the code can then be adapt for further analysis.

For more information, see [here](https://github.com/ramarty/ntl-training/tree/main/ntl-diagnostic-code).

## Additional resources

_Spatial analysis in R_
* [Spatial Data Science with R and "terra"](https://rspatial.org/)
* [Spatial Statistics for Data Science: Theory and Practice with R](https://www.paulamoraga.com/book-spatial/index.html)

_Nighttime lights_
* [World Bank Open Nighttime Lights tutorial](https://worldbank.github.io/OpenNightLights/welcome.html)
* [Spatial Edge: Downloading and processing Black Marble nightlights data in R](https://www.spatialedge.co/p/tutorial-downloading-and-processing)
* [Blog about BlackMarbleR/Py](https://blogs.worldbank.org/en/opendata/illuminating-insights-harnessing-nasas-black-marble-r-and-python-packages?auHash=U6q7khcBvDa_eUrNze0tnZkLg5TuvggWL18OTWQYmCA)

_World Bank Data Partnership examples using nighttime lights_
* [Syria Economic Monitor](https://datapartnership.org/syria-economic-monitor/notebooks/ntl-analysis/README.html)
* [Lebanon Economic Monitor](https://datapartnership.org/lebanon-economic-monitor/notebooks/ntl-analysis/README.html)


