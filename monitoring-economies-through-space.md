---
title: "Monitoring Economies Through Space Using Nighttime Lights"
subtitle: "World Bank Training Course"
authors: 
  - "Robert Marty, Data Scientist, DECDI"
  - "Sahiti Sarva, Data Scientist, DECDG"
date: "October 1 2025"
organization: "World Bank"
---

# Monitoring Economies from Space Using Nightlights

## Outline

- **Data Sources**: Evolution and Access
- **Core Applications** in Economics and Social Science  
- **Economic Monitoring**
- **Crisis Response**
- **New Research** using Nightlights
- **Existing Resources** from WB

---

## Nighttime Lights Data Sources

Two sources of Nightlights are **DMSP-OLS** & **VIIRS**. Each has multiple versions of processed data.

### Defense Meteorological Satellite Program Operational Linescan System (DMSP-OLS)
- **Agency**: US Air Force
- **Coverage**: Daily data from 1992-2013 (2018)
- **Processed Data**: Colorado School of Mines, World Bank – Light Every Night

### Visible Infrared Imaging Radiometer Suite (VIIRS)
- **Agency**: NOAA in Partnership with NASA
- **Coverage**: Daily data from 2012-present
- **Processed Data**: Colorado School of Mines, World Bank – Light Every Night, NASA BlackMarble

> **Note**: Processed data facilitates analysis of human-generated light by removing effects of moonlight, applying atmospheric corrections, etc.

---

## Defense Meteorological Satellite Program (DMSP)

### Key Characteristics
- **Agency**: USA Air Force
- **Time Period**: Original series from 1992-2013; extended to 2018
- **Satellites**: Different satellites; requires calibrating across satellites
- **Resolution**: 30 arc second (~1km at equator)
- **Units**: Digital Number, integer from 0 – 63; censoring an issue for bright areas

### Processed Data Sources:
- Colorado School of Mines (Monthly & Annual)
- World Bank – Light Every Night (Daily)

### Limitation: Censoring
Bright areas are censored at value 63, losing information about variation in very bright locations.

---

## Visible Infrared Imaging Radiometer Suite (VIIRS)

### Key Characteristics
- **Agency**: NOAA in partnership with NASA
- **Coverage**: Daily Data: 2012-present
- **Resolution**: 500m
- **Units**: Radiance (nanoWatts/sr/cm²)
  - How much light energy is received [nanoWatts]
  - By a surface per unit area [cm²]
  - Per unit solid angle [sr, steradian] → direction light is emitted/detected

### Processed Data Sources:
- Colorado School of Mines (More commonly used)
- NASA BlackMarble (Released in 2021)

---

## Comparing DMSP-OLS and VIIRS

VIIRS has higher, improved radiometric resolution, and is not saturated, unlike DMSP.

| Feature | DMSP | VIIRS |
|---------|------|-------|
| **Availability** | 1992–2013 (2018) | 2012–present |
| **Spatial Resolution** | 30 arc seconds (~1 km) | 15 arc seconds (~500 m) |
| **Radiometric Resolution** | 6-bit | 12- or 14-bit |
| **Wavelength Range** | 0.4–1.1 µm | 0.5–0.89 µm |
| **Units of Pixel Values** | Relative (0–63 scale) | Radiance (nW cm⁻² sr⁻¹) |
| **Overpass Time** | ~19:30 | ~1:30 |
| **On-board Calibration** | No | Yes |
| **Pixel Saturated** | Yes | No |

*References: Tu et al. (2020), Li et al. (2020)*

---

## VIIRS: Colorado School of Mines vs BlackMarble

### Snowfall, Vegetation and Surface Reflectance Corrections in BlackMarble

#### Snowfall Correction
- **Issue**: Snowfall reflects light
- **BlackMarble Solution**: Estimates snow-free lights

#### Vegetation Correction
- **Issue**: Vegetation can hide light; less vegetation in winter can result in higher NTL values
- **BlackMarble Solution**: Corrects for vegetation effects

#### Surface Reflection Correction
- **Approach**: Different approach for accounting for surface reflection (e.g., moon, stars, atmospheric particles) using Bidirectional reflectance distribution function (BRDF)

#### Outlier Removal
- **Process**: In creating monthly/annual data, Black Marble drops daily outliers (also done in Colorado School of Mines V2)

*For more info, see The Spatial Edge (Yohan Iddawela)*

---

## VIIRS: Satellite Angle Variations

### Colorado School of Mines
- **Approach**: No differentiation; single dataset

### Black Marble
Provides multiple datasets for annual data:
- **Near-nadir [above]**: Typically brighter
- **Off-nadir [at angle]**: Captures at an angle, allows greater coverage of a single image
- **Combined / "All Angle"**

### Research Findings
Wang et al. (2018): Comparing Dubai and Rome, found that near-nadir was brighter but varied more, while off-nadir was less bright but varied less.

---

## BlackMarble: Monthly and Annual Variables

### Choice Options: (1) Angle; (2) Snowfall
- `AllAngle_Composite_Snow_Covered`
- `AllAngle_Composite_Snow_Free`
- `NearNadir_Composite_Snow_Covered`
- `NearNadir_Composite_Snow_Free`
- `OffNadir_Composite_Snow_Covered`
- `OffNadir_Composite_Snow_Free`

### Example: Snowstorm Filomena
- **Without snow control**: Large spike in January 2021
- **With snow control**: No spike in January 2021

---

## BlackMarble: Stray Light Limitation

**Stray Light**: When sunlight hits the satellite - the biggest limitation of BlackMarble

### Colorado School of Mines
- **Approach**: Adjusts for stray light contamination

### Black Marble
- **Approach**: Drops pixels contaminated by stray light
- **Impact**: Contains many missing values for northern countries from June - August

---

## BlackMarble: Data Quality Assessment

Nighttime lights can be impacted by a number of factors, particularly cloud cover.

### BlackMarble Quality Flags (`Mandatory_Quality_Flag`)
- **0**: High-quality, Persistent nighttime lights
  - Lights that remain stable over time, typically from human-made sources (e.g., city lights)
- **1**: High-quality, Ephemeral nighttime lights
  - Temporary or short-lived sources of lights (e.g., wildfires, fishing fleets)
- **2**: Poor-quality, Outlier, potential cloud contamination or other issues
- **No Data**: Removed due to cloud cover

### Gap-Filling for Daily Data
- Allows using data from a previous date to fill the value
- Uses temporally gap-filled NTL value: `Gap_Filled_DNB_BRDF-Corrected_NTL`

---

## BlackMarble: Daily Data Variables

### Day/Night Band (DNB) with BRDF Correction
**BRDF**: Bidirectional Reflectance Distribution Function – correction for surface reflectance

- **`DNB_BRDF-Corrected_NTL`**: NTL value for given day
- **`Gap_Filled_DNB_BRDF-Corrected_NTL`**: Will use latest high quality pixel within 30 days
- **`Latest_High_Quality_Retrieval`**: Number of days between day & pixel used

---

## BlackMarble: Monthly/Annual Data Quality

### Number of Observations
**`NearNadir_Composite_Snow_Free_Num`**: Number of daily observations used for monthly composite (daily observations with cloud cover or other issues removed)

### Quality Assessment
**`NearNadir_Composite_Snow_Free_Quality`**:
- **0**: Good-quality – The number of observations used for the composite is larger than 3
- **1**: Poor-quality – The number of observations used for the composite is 3 or less

---

## Trends from 1992 - Present: Combining DMSP-OLS and VIIRS

### The Challenge
**Issue**: Comparing values from DMSP-OLS & VIIRS is an apples-to-oranges comparison.
- **Units differ**: DMSP-OLS uses a "digital number" and VIIRS uses radiance
- **Data quality differs**: For example, differences in resolution

### Solutions
- **Downscale VIIRS**: Create "DMSP-like" data
- **Upscale DMSP-OLS**: Create "VIIRS-like" data (relies on using other imagery, such as daytime imagery, for upscaling)

### Example Datasets
- **{Downscale VIIRS}**: A harmonized global nighttime light dataset 1992–2018 (Li et al, 2020) [dataset] Updated beyond 2018
- **{Upscale DMSP}**: A global annual simulated VIIRS nighttime light dataset from 1992 to 2023 (Chen et al, 2024)

---

## Innovations in Nighttime Lights

### SDGSAT-1
**Developer**: Chinese Academy of Sciences
- **Launch**: 2021
- **Resolution**: Glimmer imager on SDGSAT 1 captures nighttime light data at 10-40 meter resolution

---

# Uses of Nightlights in Economics and Social Sciences

> **Key Insight**: Leveraging nighttime lights requires appreciating what does and does not generate lights

---

## Sources of Nightlights

### Brightness Ranking (from More Light to Less Light)
*This ranking is suggestive/speculative; will differ based on context.*

**More Light:**
- Gas Flaring
- Ports and Industrial Complexes (large bright clusters)
- Manufacturing Units / Industrial Facilities
- Airports (runway and terminal lighting)
- Large Sports and Event Venues (stadiums with floodlights)
- Major Highways and Traffic Corridors
- Electric Lighting in Human Settlements (outdoor lighting)
- Retail and Trade Activity Areas
- Lights on Shipping Vessels
- Mining sites and quarries (often bright industrial sites)
- Wildfires and Controlled Burns
- Fishing Boats
- Data Centers and Service Sector Buildings
- Rural Villages and Agricultural Areas
- Auroras and Atmospheric Phenomena

**Less Light**

### Economic Activity Correlation

#### Same Regardless of Economic Output
- Data Centers and Service Sector Buildings

#### Differs with Economic Output
- Gas Flaring

---

## Indicators Using Nighttime Lights

Aggregating night lights differently creates different indicators:

| **Aggregation Type** | **Meaning** |
|---------------------|-------------|
| **Sum of Lights** | Total brightness summed over a region, representing the overall amount of light emitted by all sources combined |
| **Average of Lights** | Mean brightness per pixel or unit area, showing the typical light intensity level independent of area size |
| **Centre of Gravity of Lights** | Spatial geographic center weighted by brightness values, highlighting where the "center" of activity is located |
| **Threshold of Light** | Area above a brightness cutoff, separating lit from unlit or less lit zones |

---

## Average and Sum of Light

### Sum vs Mean: Measuring Activity vs Density
- **'Sum'** is better for GDP estimates because it's a stock estimate
- **Total lights** is typically biased towards larger areas
- **Research about human development**, if it needs to be unbiased with area, could choose average light values
- **Average** has been used by Henderson et al., 2018 as a proxy for human development indicators

---

## Center of Gravity of Light

### Movement in the Economic Center of Russia
**Application**: The central point where light is concentrated in a country was used as a proxy for economic centers (Hande et al., 2025)

**Global Analysis**: A global analysis of the same was done with DMSP data to show the movement of global economic centers eastward from 1992 to 2009 (Cauwels, Pestalozzi, & Sornette, 2014)

---

## Nighttime Lights and Urbanization

### Threshold Detection of Urban Areas
**CIESIN Collaboration**: CIESIN in collaboration with the World Bank used a threshold value after aggregating nightlights to determine city limits.

**Electrification Studies**: Threshold values were also used in studies to identify electrification of areas.

---

## Use Cases of Nighttime Lights

### Primary Applications

| **Use Case** | **Description** |
|--------------|-----------------|
| **Proxy for Economic Activity** | Estimation and nowcasting of subnational GDP |
| **Rate of Urbanization** | Increase in urban area, density and spatial agglomeration |
| **Crisis Response** | Post crisis damage assessment, needs assessment |
| **Population Estimation** | Post crisis damage assessment, needs assessment and resilience |
| **Oil Production Monitoring** | Measurement of oil-based GDP estimates and offshore oil production |
| **Rate of Electrification** | Measurement of electricity access and use |

---

# Nighttime Lights and Economic Activity

## Key Research Findings

### GDP Correlation Studies
- **Henderson et al. (2012)**: Nighttime lights correlated with levels and changes (long difference) in GDP
- **Hu and Yao (2019)**: NTL correlates with GDP. Elasticity of lights to GDP systematically varies by a country's income level. Can be as high as 2.3 for low-income countries and close to 0 for high income countries
- **Gibson et al. (2021)**: VIIRS provides a more accurate proxy to GDP than DMSP-OLS
- **Martinez (2022)**: Finds that the elasticity of lights to GDP is larger in authoritarian regimes, suggested overstating annual GDP growth
- **Mellander et al. (2015)**: Using firm data in Sweden, shows NTL strongly associated with establishment density and population; weaker association with wages. For some indicators, lights overestimates in urban areas and underestimates in rural areas

---

## Case Study: Mexican Municipalities

**Analysis by Hugo Foster & Marie Lechler (2022)**

### Key Findings
- **Border Effects**: More luminosity than expected, given population, in key border crossing locations with large cargo infrastructure & manufacturing activities. Less luminosity than expected given population in poorer locations
- **Supply Chain Nodes**: Strong NTL in key supply chain & industry nodes, such as ports & oil/gas facilities
- **Juarez-El Paso**: More nighttime lights around border crossings, transportation terminals and manufacturing sites
- **State Level**: States with more NTL tend to have higher economic output

### Important Limitation
> "Luminosity data is less likely to be useful where local economies are based around service industries that emit less light compared to manufacturing"

---

## Subnational GDP and Oil GDP Estimation

### World Bank Applications
- **African Countries**: World Bank paper uses Nightlights following Henderson et al., to estimate subnational GDP in African countries
- **Iran Oil Analysis**: The log of nighttime lights from gas flaring locations shows an R-squared value of 0.83 when compared to GDP per capita

---

## Underestimation of Service Sector & Agriculture

### Timing Issues
**VIIRS Data Collection**: Collects data between 1:30PM UTC and 1:30 AM UTC and regionally this varies on the exact time it detects light.

**Missing Peak Hours**: Could miss peak lighting hours in some countries, especially if service sector is active at night (Bhattarai et al., 2023)

### COVID-19 Study in India
**Findings**: Study conducted to analyze impact of COVID on India's economy noted that the decrease in the productivity of the service sector wasn't proportional to the decrease in nightlights (Dasgupta, 2022)

### Agricultural Limitations
**Weak Agricultural Signal**: The weak signature of agricultural light makes NTL a weaker proxy for agricultural GDP in comparison to manufacturing

---

# Nighttime Lights and Crises

## Nighttime Lights and Disasters

### Earthquake in Turkey and Syria (2022)
- **Immediate Impact**: Nightlights dropped in some parts of the earthquake impact region 3 days after the earthquake
- **Recovery Pattern**: 2 weeks later, saw an increase in multiple admin regions
- **Hypothesis**: Relief activities caused high intensity lights in the region

### Hurricane Michael
- **Impact**: After making landfall as a Category 5 storm, Michael knocked out power for at least 2.5 million customers in the southeastern United States
- **Visualization**: Data visualization showed where lights went out in Panama City, Florida

---

## Nighttime Lights and War

### Conflict Impact Analysis
- **Gaza**: >80% decline in lights in Gaza as early as October 22nd, 2023 when the war started on October 7th, 2023
- **Sudan**: Significant reduction in nightlights before and after the conflict began in the region
- **Syria**: Similar patterns observed during conflict periods

---

# Evaluating Impact of Spatially-Explicit Infrastructure and Policies

## Evaluation of New/Upgraded Roads

### Methodological Advantages
- **Spatial Coverage**: Nighttime lights are available across time and space; useful for quasi-experimental approaches (not spatially constrained in where to select control group)
- **Quasi-Experimental Design**: Diff-in-diff: Compare treated with yet-to-be-treated units, using NTL as an outcome variable
- **Heterogeneity Analysis**: Explore heterogeneity in results by baseline NTL

### Research Examples
- **Chen et al. (2023)**: Rural road connectivity and local economic activity: Evidence from Sri Lanka's iRoad Program. Rural roads with improved connectivity showed higher nighttime luminosity compared to areas without improved connectivity
- **BenYishay et al. (2018)**: Evaluation of road upgrades in Palestine. Find positive effects, particularly in areas with higher baseline luminosity
- **Alder (2025)**: Chinese roads in India: The effect of transport infrastructure on economic development. India's network of highways led to gains in economic activity but had unequal effects across regions
- **Bolivar (2022)**: Roads illuminate development: Using nighttime luminosity to assess the impact of transport infrastructure. In Bolivia, Paraguay, and Ecuador, municipalities that benefited from paved major roads saw more economic activity compared to control locations

---

## Evaluation of Rural Electrification Programs

### Research Question
**To what extent can nighttime lights capture rural electrification programs?**

### Detection Studies
- **Min et al. (2013)**: Detection of rural electrification in DMSP-OLS night lights imagery. Using sample of villages in Senegal and Mali, finds that electrified villages are brighter than unelectrified villages. Appear brighter largely because of the presence of streetlights; correlation of light output with household electricity use was low
- **Dugoua et al. (2018)**: Satellite data for the social sciences: measuring rural electrification with night-time lights. Nighttime lights provides an accurate measure of rural electrification in India, but detects electrification less accurately when the supply of power is intermittent
- **Min and Gaba (2014)**: Tracking Electrification in Vietnam Using Nighttime Lights. Find a one-point increase in DMSP-OLS DN for every 60-70 additional streetlights and 240-270 electrified homes

### Program Evaluation Examples
- **Burlig and Preonas (2024)**: Out of the Darkness and into the Light? Development Effects of Rural Electrification. Evaluation of India's national electrification program, RGGVY
- **Berthelemy (2024)**: Using Night-Time Light to Estimate the Impact of Mini-Grid Electrification Projects on Electric Power Consumption: Analytical Background and Case Study in Madagascar. Uses lights to evaluate mini-grid project. Find a positive impact; also find that positive impact could be overestimated by one third if street lighting is not taken into account

---

# Combining Lights with Other Metrics

## Poverty Estimation

### Machine Learning Approaches
**Challenge**: Nighttime lights too coarse a measure to be a strong proxy for poverty/wealth estimation alone.

### Research Examples
- **{Satellite imagery}**: Jean et al. (2016) and Yeh et al. (2020) combine nighttime lights and daytime imagery to predict poverty measured from DHS in 5 African countries (Jean et al) and across Africa (Yeh et al)
- **{Satellite imagery and beyond}**: Pokhriyal and Jacques (2017) and Marty and Duhaut (2024) use nighttime lights, daytime imagery, and other sources such as CDR data, Facebook data, etc, for poverty estimation

---

## Downscaling Nighttime Lights

### Methodology
Use finer scale data sources that suggest the likelihood of where lights are/aren't coming from within a NTL pixel.

### Common Approach: NDVI
**Vegetation Index**: One common source is NDVI (vegetation). Lights less likely to come from pixels with high NDVI/vegetation values.

**References**: Wu et al. (2024), Liu et al. (2022), Guo et al. (2024)

---

## Combining Nightlights with NO2 and Exports

### World Bank Study in Addis Ababa (Ongoing)
**Methodology**: Combined NO2 and NTL data to estimate its relationship with industrial production in Ethiopia measured through industrial exports data

**Key Findings**:
- In a GMM model, every 1% change in exports caused a 2% change in average nightlights
- Nightlights were the second biggest factor influencing exports in XGBoost model

---

## Combining Nightlights with EVI

### Enhanced Vegetation Index Integration
**EVI and NDVI**: Normalized Difference Vegetation Index and Enhanced Vegetation Index are products from daytime satellite imagery and measure greenness of canopy cover

**Agricultural Applications**: Studies have suggested the use of EVI alongside NTL to improve agricultural proxies

**Status**: This is an ongoing research question being explored within the team

---

# Popular Global Public Goods Using Nightlights

## Population and Settlement Mapping

### Meta's High Resolution Population Density
- **Resolution**: 30m resolution population density maps

### WorldPop Population Density Estimates
- **Resolution**: 100m resolution population maps (annual)

### Global Human Settlement Layer
- **Coverage**: Global spatial data on human settlements (10m built up area, 100m population maps)

## Urban Mapping Projects

### Global Urban Footprint
- **Methodology**: Combines population counts, settlement points, and nighttime lights to delineate urban and rural areas globally

### Global Urban Rural Mapping Project (GRUMP)
- **Objective**: Mapping the physical extent of built-up land worldwide with fine spatial resolution using SAR data

---

# Existing and Upcoming Resources

## Current Tools

### R and Python Packages
- **BlackMarbleR**: R Package to get data from NASA BlackMarble
- **BlackMarblePy**: Python package to get data from NASA BlackMarble

### Data Platforms
- **Space2Stats**: Annual nighttime lights data among other metrics
- **Light Every Night/High Resolution Electricity Access**: Daily NTL dataset from DMSP and VIIRS from 1992-2020 used to create a dataset of global energy access

## Upcoming Resources
- **Space2Stats - Global Monthly NTL Data at ADM0 to ADM2**: Coming soon!

---

# Main Takeaways

## Sources of Nightlight Data

### Two Sources of Nightlights
- **DMSP-OLS** (1992-2013)
- **VIIRS** (2012-present) - Better in multiple ways including granularity

### Two Sources of Processed Data
- **Colorado School of Mines**
- **NASA Black Marble** – More recent, provides additional corrections and choice to pick variables
  - **Daily**: Gap filled vs not gap filled
  - **Monthly/Annually**: Angle & snow correction

---

## Key Questions for Economic Monitoring

### Understanding Light Sources
**Critical Questions**:
- What produces light and what doesn't?
- Which source has variability of light and which doesn't?
- Example: Gas Flaring location vs Service sector and agriculture

### Spatial Aggregation Control
**Analytical Choices**:
- Do we exclude gas flaring locations?
- Do we only include lights in city boundaries?
- With nighttime lights, we can control which pixels we use to spatially aggregate

---

## Thank You

*This presentation provides a comprehensive overview of using nighttime lights for economic monitoring and analysis. For more detailed information and hands-on training, please refer to the accompanying training materials and resources.*