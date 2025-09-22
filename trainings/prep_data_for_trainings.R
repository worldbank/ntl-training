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
  file_dir = file.path(here("data", "ntl_blackmarble", "nigeria", "adm1")),
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
pak_sf <- gadm("PAK", level=0, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(COUNTRY)

pak_3_sf <- gadm("PAK", level=3, path = tempdir(), version="latest") %>%
  st_as_sf() %>%
  dplyr::select(NAME_1, NAME_2, NAME_3, GID_3)

write_sf(pak_sf, here("data", "gadm", "pak_adm0.geojson"), delete_dsn = T)
write_sf(pak_3_sf, here("data", "gadm", "pak_adm3.geojson"), delete_dsn = T)

# Create dataframe with coordinates
cities_df <- data.frame(
  city = c("Islamabad", "Lahore"),
  latitude = c(33.6844, 31.5204),
  longitude = c(73.0479, 74.3587)
) 

write_csv(cities_df, here("data", "cities", "pak_cities.csv"))


cities_buff_sf <- cities_df %>%
  st_as_sf(coords = c("longitude", "latitude"),
           crs =4326) %>%
  st_buffer(dist = 40000)

#### Roads
pak_roads_list <- opq(bbox = st_bbox(cities_buff_sf)) %>%
  add_osm_feature(key = "highway",
                  value = c("motorway", "trunk")) %>%
  osmdata_sf()

pak_roads_sf <- pak_roads_list$osm_lines

pak_roads_sf <- pak_roads_sf %>%
  dplyr::filter(ref %in% c("N-5",
                           "M-2"),
                !(osm_id %in% c("273911484",
                                "273911482",
                                "246583093",
                                "23016976",
                                "344034979",
                                "291014703",
                                "177946601",
                                "852469505",
                                "785020694",
                                "235315178",
                                "177946600",
                                "291852251",
                                "23229008",
                                "177946598",
                                "23228675",
                                "23016957",
                                "976222651",
                                "1255775263",
                                "666194551",
                                "23017267",
                                "23228702",
                                "23017024",
                                "23228611",
                                "178151252",
                                "1082100662",
                                "23017541",
                                "664737136",
                                "237283234",
                                "976222649",
                                "913781383",
                                "319062321",
                                "317001987",
                                "177946590",
                                "235315177",
                                "235315176",
                                "803430752",
                                "23017447",
                                "23016981",
                                "9897259",
                                "235293141",
                                "976222652",
                                "177946592",
                                "681459745",
                                "664737137",
                                "23016979",
                                "23017174",
                                "178151232",
                                "1194002504",
                                "1082100661",
                                "1426168025",
                                "344034976",
                                "177946589",
                                "681459744",
                                "23017222",
                                "23017029",
                                "976222650",
                                "1194002505",
                                "23017223",
                                "23017025",
                                "666194550",
                                "8118951")))


leaflet() %>%
  addTiles() %>%
  addPolylines(data = pak_roads_sf, color = "red")  

pak_roads_sf <- pak_roads_sf %>%
  dplyr::select(osm_id, name, ref) %>%
  group_by(ref) %>%
  dplyr::summarise(geometry = geometry %>% st_union() %>% st_make_valid()) %>%
  ungroup()

write_sf(pak_roads_sf, here("data", "osm", "roads_pak_treat_n5_m2.geojson"), delete_dsn = T)


pak_roads_buff_sf <- pak_roads_sf %>% st_buffer(dist = 20000)
leaflet() %>%
  addTiles() %>%
  addPolylines(data = pak_roads_buff_sf,
               popup = ~ref) 


r <- bm_raster(
  roi_sf = pak_roads_buff_sf %>% st_union() %>% st_as_sf(),
  product_id = "VNP46A4",
  date = 2012:2024,
  bearer = bearer,
  output_location_type = "file",
  file_dir = file.path(here("data", "ntl_blackmarble", "pakistan"))
)

plot(r)

leaflet() %>%
  addTiles() %>%
  addPolygons(data = pak_roads_buff_sf)

# h3 -----------
library(h3jsr)

# 3. Get H3 indexes covering the bounding box
h3_sf <- polygon_to_cells(bbox_sf, res = 5) %>%
  cell_to_polygon(simple = FALSE)

# 4. Convert H3 indexes to sf polygons
h3_sf <- cell_to_polygon(h3_indexes, simple = FALSE) %>%
  st_as_sf() %>%
  rename(h3_index = hex_id)

# 5. Optional: clip to the actual polygon
h3_sf <- st_intersection(h3_sf, pak_roads_buff_sf)

# 6. View the first rows
head(h3_sf)