# Extract and send BlackMarble Data to s3

# [GEO-DATASET] / [GEO-LEVEL] / [UNIT] / [NTL DATASET] / [NTL TIME LEVEL] / [FILE FORMAT]

library(tidyverse)
library(blackmarbler)
library(aws.s3)
library(sf)
library(here)
library(haven)

# Keys -------------------------------------------------------------------------
nasa_bearer <- read_csv("~/Dropbox/bearer_bm.csv") %>% pull(token)

#### Set AWS Keys for s# Bucket
api_keys <- read.csv("~/Dropbox/World Bank/Webscraping/Files for Server/api_keys.csv", stringsAsFactors=F)

Sys.setenv("AWS_ACCESS_KEY_ID" = api_keys$Key[(api_keys$Service %in% "AWS_ACCESS_KEY_ID") & (api_keys$Account %in% "robmarty3@gmail.com")],
           "AWS_SECRET_ACCESS_KEY" = api_keys$Key[(api_keys$Service %in% "AWS_SECRET_ACCESS_KEY") & (api_keys$Account %in% "robmarty3@gmail.com")],
           "AWS_DEFAULT_REGION" = "us-east-2")

# Extract data -----------------------------------------------------------------
for(geo_dataset_i in c("gadm_410")){
  for(geo_level_i in c("ADM_0")){
    
    if((geo_dataset_i == "gadm_410") & (geo_level_i == "ADM_0")){
      roi_sf <- read_sf(here("blackmarble-stata", "data-to-s3", "base_layers", "gadm_410-levels.gpkg"),
                        "ADM_0")
      
      unit_var <- "GID_0"
    } 
    
    for(unit_i in unique(roi_sf[[unit_var]])){
      
      roi_i_sf <- roi_sf[roi_sf$GID_0 %in% unit_i,]
      
      for(ntl_dataset_i in c("blackmarble")){
        for(ntl_time_level_i in c("annual")){
          
          #### Create dates to query
          if( (ntl_dataset_i == "blackmarble") & (ntl_time_level_i == "annual")){
            dates_vec <- 2021:2023
          } 
          
          #### Grab file names already queried
          files_in_s3_list <- get_bucket(bucket = "wb-blackmarble", 
                                         prefix = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/", ntl_time_level_i, "/"))
          files_in_s3 <- sapply(files_in_s3_list, function(x) x$Key) %>% 
            as.vector()
          
          for(date_i in dates_vec){
            
            s3_path_date_i <- paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/", ntl_time_level_i, "/", date_i, ".csv")
            
            if(!(s3_path_date_i %in% files_in_s3)){
              print(unit_i)
              
              # Make folders in s3 -----------------------------------------------
              put_object(file = raw(),
                         object = paste0(geo_dataset_i, "/"),
                         bucket = "wb-blackmarble")
              
              put_object(file = raw(),
                         object = paste0(geo_dataset_i, "/", geo_level_i, "/"),
                         bucket = "wb-blackmarble")
              
              put_object(file = raw(),
                         object = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/"),
                         bucket = "wb-blackmarble")
              
              put_object(file = raw(),
                         object = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/"),
                         bucket = "wb-blackmarble")
              
              put_object(file = raw(),
                         object = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/", ntl_time_level_i, "/"),
                         bucket = "wb-blackmarble")
              
              # Extract and add file to s3 ---------------------------------------
              
              #### Query data
              r_df <- bm_extract(roi_sf = roi_i_sf,
                                 product_id = "VNP46A4",
                                 date = date_i,
                                 bearer = nasa_bearer)
              r_df <- r_df %>%
                st_drop_geometry() %>%
                as.data.frame()
              
              
              s3write_using(r_df, 
                            FUN = write_csv,
                            bucket = "wb-blackmarble",
                            object = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/", ntl_time_level_i, "/", date_i, ".csv"))
              
              s3write_using(r_df, 
                            FUN = write_dta,
                            bucket = "wb-blackmarble",
                            object = paste0(geo_dataset_i, "/", geo_level_i, "/", unit_i, "/", ntl_dataset_i, "/", ntl_time_level_i, "/", date_i, ".dta"))
              
              
            }
          } # End: date_i
        } # End: ntl_time_level_i
      } # End: ntl_dataset_i
    } # End: unit_i
  } # End: geo_level_i
} # End: geo_dataset_i



