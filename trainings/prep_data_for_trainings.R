# Prep Data for Trainings

library(here)
library(tidyverse)
library(sf)
library(terra)
library(readxl)
library(janitor)
library(geodata)
library(osmdata)
library(leaflet)
library(blackmarbler)

bearer <- read_csv("~/Dropbox/bearer_bm.csv") %>%
  pull(token)

# Gas Flaring ------------------------------------------------------------------
gf_df <- read_xlsx(here("data", "gas_flaring", "rawdata", 
                        "2012-2024-Flare-Volume-Estimates-by-individual-Flare-Location.xlsx"))

gf_df <- gf_df %>%
  clean_names() %>%
  dplyr::filter(location == "ONSHORE",
                flare_level != "Small")

saveRDS(gf_df, here("data", "gas_flaring", "finaldata", "gas_flaring.Rds"))
write_csv(gf_df %>%
            dplyr::filter(country == "Nigeria"), 
          here("data", "gas_flaring", "finaldata", "gas_flaring_nga.csv"))

# ADM --------------------------------------------------------------------------
nga_0_sf <- gadm("NGA", level=0, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(COUNTRY)

nga_1_sf <- gadm("NGA", level=1, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(NAME_1)

nga_2_sf <- gadm("NGA", level=2, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(NAME_1, NAME_2)

write_sf(nga_0_sf, here("data", "gadm", "nga_adm0.geojson"), delete_dsn = T)
write_sf(nga_1_sf, here("data", "gadm", "nga_adm1.geojson"), delete_dsn = T)
write_sf(nga_2_sf, here("data", "gadm", "nga_adm2.geojson"), delete_dsn = T)

# Roads ------------------------------------------------------------------------
library(osmdata)

nigeria <- getbb("Nigeria")

nga_roads_list <- opq(bbox = nigeria) %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "trunk")) %>%
  osmdata_sf()

nga_roads_sf <- nga_roads_list$osm_lines

nga_roads_sf <- nga_roads_sf %>%
  dplyr::select(osm_id, name, highway)

write_sf(nga_roads_sf, here("data", "osm", "roads_nga_main.geojson"), delete_dsn = T)

# Nighttime Lights -------------------------------------------------------------


bm_raster(
  roi_sf = nga_1_sf,
  product_id = "VNP46A4",
  date = 2012:2024,
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria")),
  check_all_tiles_exist = FALSE,
  variable = "NearNadir_Composite_Snow_Free"
)

bm_extract(
  roi_sf = nga_1_sf,
  product_id = "VNP46A4",
  date = 2012:2024,
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria")),
  aggregation_fun = "sum"
)

bm_raster(
  roi_sf = nga_1_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2024-01-01"),
                  to = ymd("2024-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria")),
  check_all_tiles_exist = FALSE,
  variable = "NearNadir_Composite_Snow_Free"
)

bm_raster(
  roi_sf = nga_1_sf,
  product_id = "VNP46A3",
  date = "2024-01-01",
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria")),
  check_all_tiles_exist = FALSE,
  variable = "NearNadir_Composite_Snow_Free_Quality"
)

bm_raster(
  roi_sf = nga_1_sf,
  product_id = "VNP46A3",
  date = "2024-01-01",
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria")),
  check_all_tiles_exist = FALSE,
  variable = "NearNadir_Composite_Snow_Free",
  quality_flag_rm = 2 # Remove gap filled
)

r_annual <- file.path(here("data", "ntl_blackmarble", "nigeria")) %>%
  list.files(full.names = T,
             pattern = ".tif") %>%
  str_subset("VNP46A4") %>%
  rast()

writeRaster(r_annual, file.path(here("data", "ntl_blackmarble", "nigeria", "VNP46A4_all.tif")))

# Nighttime Lights: Puerto Rico ------------------------------------------------
#### GADM
pri_0_sf <- gadm("PRI", level=0, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(COUNTRY)

pri_1_sf <- gadm("PRI", level=1, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(NAME_1)

write_sf(pri_0_sf, here("data", "gadm", "pri_adm0.geojson"), delete_dsn = T)
write_sf(pri_1_sf, here("data", "gadm", "pri_adm1.geojson"), delete_dsn = T)

#### NTL
bm_extract(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "Gap_Filled_DNB_BRDF-Corrected_NTL",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm0"))
)

bm_extract(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "DNB_BRDF-Corrected_NTL",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm0"))
)

bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "Gap_Filled_DNB_BRDF-Corrected_NTL",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "DNB_BRDF-Corrected_NTL",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "Mandatory_Quality_Flag",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A2",
  date = seq.Date(from = ymd("2017-09-20") - 14,
                  to = ymd("2017-09-20") + 14,
                  by = "day"),
  bearer = bearer,
  output_location_type = "file",
  variable = "Latest_High_Quality_Retrieval",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

#### NTL
bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

#### NTL
bm_extract(
  roi_sf = pri_0_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  aggregation_fun = "mean",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm0"))
)

bm_extract(
  roi_sf = pri_0_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  aggregation_fun = "sum",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm0"))
)

#### NTL
bm_extract(
  roi_sf = pri_1_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  aggregation_fun = "mean",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm1"))
)

bm_extract(
  roi_sf = pri_1_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  aggregation_fun = "sum",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico", "adm1"))
)

#### NTL
bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A3",
  date = seq.Date(from = ymd("2017-01-01"),
                  to = ymd("2018-12-01"),
                  by = "month"),
  bearer = bearer,
  output_location_type = "file",
  variable = "NearNadir_Composite_Snow_Free_Quality",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

bm_raster(
  roi_sf = pri_0_sf,
  product_id = "VNP46A4",
  date = 2012:2024,
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "puerto_rico"))
)

# Pakistan ---------------------------------------------------------------------

