---
title: "Monitoring Economies from Space Using Nighttime Lights"
---

This material was jointly developed by the [DECDI ieConnect](https://www.worldbank.org/en/about/unit/unit-dec/impactevaluation/partnerships/ieconnect) team and the Development Data Group's [Development Data Partnership](https://datapartnership.org) team as an introduction to using nighttime lights for economic analysis.

# Course Motivation

Nighttime lights have become a widely used data sources, including in the social sciencies literature. [Henderson, Storeygard, and Weil's](https://www.aeaweb.org/articles?id=10.1257/aer.102.2.994) seminal 2012 paper illustrated the use of leveraging nighttime lights to measure economic growth. They compared the nighttime lights between North Korea and South Korea and showed that lights can be proxy for economic growth. 

Their paper helped launch the use of nighttime lights in a variety of applications; a Google scholar search of ["nighttime lights economics"](https://scholar.google.com/scholar?hl=en&as_sdt=0%2C9&q=nighttime+lights+economics&btnG=) brings over 40,000 responses. In addition to leverage nighttime lights as a proxy for economic activity, nighttime lights has been used for various applications such as tracking [urbanization](https://www.sciencedirect.com/science/article/abs/pii/S0034425797000461) and examining impacts of [natural disasters](https://www.sciencedirect.com/science/article/abs/pii/S0143622819308525), [conflict](https://www.mdpi.com/2072-4292/10/6/858), and [infrastructure improvements](https://documents.worldbank.org/en/publication/documents-reports/documentdetail/099332404062230683/idu073a7158605532046490b712098aed9008539).

Within the World Bank and other multilateral development banks, staff have used nighttime lights data in [estimating subnational GDP in countries like Kenya and Rwanda](https://blogs.worldbank.org/en/developmenttalk/night-lights-and-pursuit-subnational-gdp-application-kenya-rwanda), in [mapping electric grid infrastructure](https://blogs.worldbank.org/en/energy/using-night-lights-map-electrical-grid-infrastructure), [measuring quarterly economic growth](https://openknowledge.worldbank.org/server/api/core/bitstreams/ba5cb33b-9000-50c6-aa8c-498fbb7428c9/content) and [poverty mapping](https://openknowledge.worldbank.org/entities/publication/f6b0c7dc-d775-5dce-b887-7e9eb064de0e).  

In the recent years, DECDI and the DECDG Development Data Partnership (formerly known as the Data Lab) have supported teams working on international development challenges with nighttime lights analytics, especially in post disaster contexts. This work includes [Turkiye Earthquake Monitoring](https://datapartnership.org/turkiye-earthquake-impact/notebooks/nighttime-lights/README.html), [Gaza Conflict Impact Analysis](https://worldbank.github.io/gaza-israel-conflict-impact-analysis/notebooks/nighttime-lights/README.html) and [Sudan Conflict Impact Analysis](https://worldbank.github.io/sudan-nighttime-lights/nighttime_lights.html). This course is meant to empower staff to be able to query nightlight data themselves. 

# Course Description

This course provides an overview of using nighttime lights data, with a focus for economic applications. It covers the different sources of nighttime lights, how to query and aggregate data, and addressing data quality with nighttime lights (e.g., cloud cover). The course focuses on [NASA Black Marble](https://blackmarble.gsfc.nasa.gov/) data, using the [BlackMarbleR](https://worldbank.github.io/blackmarbler/) (for R) and [BlackMarblePy](https://github.com/worldbank/blackmarblepy) (for Python) packages for querying data.

## Day 1: Applications and Limitations of Nighttime Lights for International Development (

In this session, participants will learn about:

• History of Nighttime Lights (NTL): Evolution and significance of satellite-based light data.
• Key Nightlight Data Products (DMSP and VIIRS) : Differences in temporal and spatial coverage, data sources, as well as data processing methods.
• Use Cases in Economics & Social Sciences: Applications inside and outside the World Bank, along with common limitations of NTL.
• Practical Access: How to retrieve and work with Nighttime Lights data using existing World Bank packages.
The target audience for Day 1 includes TTLs, economists and senior specialists in economic monitoring teams, disaster needs assessment teams and urban planning teams.

## Day 2: Hands-On Tutorial on Analyzing Nightlights with BlackMarbleR.
**Hands On Session Link**: [Training Recording](https://worldbankgroup-my.sharepoint.com/:v:/g/personal/ltsegaye_worldbank_org/ETvpjaz3HhJFingCe7T2SQoBz6JmALghWIY4pdKBG-kD-Q?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJTdHJlYW1XZWJBcHAiLCJyZWZlcnJhbFZpZXciOiJTaGFyZURpYWxvZy1MaW5rIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXcifX0%3D&e=HSxhmk)

This session will provide hands-on training on querying and analyzing nighttime lights data using VIIRS NTL data from BlackMarble. Participants will learn to use BlackMarbleR to extract, process and analyse NTL data. In this session participants will learn to:

• Understand the BlackMarbleR Package
• Extract Nightlight Raster Data
• Create Maps of Raster Data
• Conduct Zonal Statistics on the Raster Data
• Exclude/Include Gas Flaring Locations
• Analyze Nightlight Data post disaster

## Prerequisites

The course assumes familiarity with R or Python. For an introduction to these programming languages, see the DIME Analytics [R training](https://github.com/worldbank/dime-r-training) and the DIME Analytics and DECID [Python training](https://github.com/worldbank/dec-python-course).

# Training Content

## Interactive Tutorial

📚 **NEW: Interactive Shiny Tutorial** - Learn BlackMarble data analysis through hands-on exercises!

To run the interactive tutorial:

1. **Install required packages**:
   ```r
   source("install_packages.R")
   ```

2. **Launch the tutorial**:
   ```r
   source("launch_tutorial.R")
   ```

The interactive tutorial includes:
- Progressive learning modules
- Interactive code exercises
- Quizzes to test understanding
- Real-time feedback
- Hands-on BlackMarble data analysis

## Static Training Materials

1. __Introduction to Spatial Analysis__ [[R](https://html-preview.github.io/?url=https://raw.githubusercontent.com/ramarty/ntl-training/refs/heads/main/trainings/01_spatial_analysis_review.html) | _Python coming later!_]: Overview of working with vector and raster spatial data in R.
2. __Nighttime Lights for Economic Analysis__ [[PPT](https://worldbankgroup.sharepoint.com.mcas.ms/:p:/r/teams/DevelopmentDataPartnershipCommunity-WBGroup/_layouts/15/Doc.aspx?sourcedoc=%7BA106862B-3498-44F1-A197-6275A2EC53AC%7D&file=NightTime%20Lights%20Course%20-%20Day%201.pptx&action=edit&mobileredirect=true)]: Overview of nighttime light datasets and use of nighttime lights for economic and social science analysis.
3. __Nighttime Lights Analysis in R__ [[R](https://html-preview.github.io/?url=https://raw.githubusercontent.com/ramarty/ntl-training/refs/heads/main/trainings/03_intro_blackmarbler.html) | _Python coming later!_]: Provides of overview of querying and analyzing nighttime lights data in R.

## NTL Country Diagnostic

In addition to providing training content, this repository contains code to quickly (1) produce nighttime lights data for any country (at the ADM0 - ADM3 level, and at the city level) and (2) produces analysis of nighttime lights (e.g., trends and maps). This code file is intended as a start to nighttime lights analysis for a country; the code can then be adapt for further analysis.

For more information, see [here](https://github.com/ramarty/ntl-training/tree/main/ntl-diagnostic-code).

## Additional Resources

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


