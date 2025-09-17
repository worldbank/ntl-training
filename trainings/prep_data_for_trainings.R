# Prep Data for Trainings

library(here)
library(tidyverse)
library(sf)
library(terra)
library(readxl)
library(janitor)

gf_df <- read_xlsx(here("data", "gas_flaring", "rawdata", 
                        "2012-2024-Flare-Volume-Estimates-by-individual-Flare-Location.xlsx"))

gf_df <- gf_df %>%
  clean_names()

saveRDS(gf_df, here("data", "gas_flaring", "finaldata", "gas_flaring.Rds"))
write_csv(gf_df %>%
            dplyr::filter(country == "Nigeria"), 
          here("data", "gas_flaring", "finaldata", "gas_flaring_nga.csv"))
