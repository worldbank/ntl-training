# Exercise 1

# Setup ------------------------------------------------------------------------
library(learnr)
library(tidyverse)
library(sf)
library(terra)
library(geodata)
library(osmdata)
library(leaflet)
library(blackmarbler)
library(tidyterra)
library(exactextractr)
library(h3jsr)
library(fixest)
library(here)

data_path <- file.path(path.expand('~'), "ntl-training-1", "data")

nga_adm0 <- read_sf(here(data_path, "gadm", "nga_adm0.geojson"))
plot(nga_adm0)

nga_gas_flares <- read_csv(here(data_path, "gas_flaring", "finaldata", "gas_flaring_nga.csv"))
head(nga_gas_flares)

# convert it from simple feature to spatial type
gf_sf <- nga_gas_flares %>%
  st_as_sf(coords = c("longitude", "latitude"),
           crs = 4326)

# Basic plot
plot(st_geometry(nga_adm0), col = "lightgray", border = "black")
plot(st_geometry(gf_sf), col = "red", pch = 16, add = TRUE)

gf_5km_sf <- st_buffer(gf_sf, dist = 5000)

plot(st_geometry(nga_adm0), col = "lightgray", border = "black")
plot(st_geometry(gf_5km_sf), col = "green", pch = 1, add = TRUE)

??bm_raster

ntl_raster <- bm_raster(nga_adm0,
                        product_id = "VNP46A4",
                        data=2012:2013,
                        bearer = "eyJ0eXAiOiJKV1QiLCJvcmlnaW4iOiJFYXJ0aGRhdGEgTG9naW4iLCJzaWciOiJlZGxqd3RwdWJrZXlfb3BzIiwiYWxnIjoiUlMyNTYifQ.eyJ0eXBlIjoiVXNlciIsInVpZCI6InNhaGl0aXNhcnZhIiwiZXhwIjoxNzY0Mzc0Mzk5LCJpYXQiOjE3NTkxNTk5MzMsImlzcyI6Imh0dHBzOi8vdXJzLmVhcnRoZGF0YS5uYXNhLmdvdiIsImlkZW50aXR5X3Byb3ZpZGVyIjoiZWRsX29wcyIsImFjciI6ImVkbCIsImFzc3VyYW5jZV9sZXZlbCI6M30.Bu0jLS3UMhWV2W96dS5ezhri8Ypr0byRpehoYRluKYT97_nRMAU8D9AjXiRgf-K0X5LE7GIn0dqEMq6ohgPzvOcH_UUnxMtQqNpVUt6b3Kg1mE2p9lX_wCsFJ7smnWz6F-OWzGXZmM8dVa1sj5Cf4aBxA3XQsfhW7rFb9s0aFplNc9dk7amcmKUazmECyT4AYEOdBh3_an_pzaj22ebDXoK-kmreXgZfTE28ISP3fOADbJ6zLWtCu0LaEd2hwBRY0Qd8QzLMz3Bu6N7kv9xPiJZcjIlB7-Ps12SmRG2Exbkjc8fT9ntPF0flIVq_QNcv8seSHP_z152wLR58vKmhjw",
                        variable = NULL,
                        file_dir = 
                        )

