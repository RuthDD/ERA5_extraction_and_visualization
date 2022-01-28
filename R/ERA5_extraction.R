# Libraries ---------------------------------------------------------------
library(tidyverse)
library(raster) # raster() function to read .nc files
library(ncdf4)
source("R/functions.R") # load functions from functions.R file

# Read .nc files by year --------------------------------------------------
nc_Files <- list.files("data", pattern = '*.nc', full.names = T)

# Coordinates by site -----------------------------------------------------
Sites <- c("Camarasa", "Badalona")
Longitude <- c(0.8813, 2.2223)
Latitude <- c(41.9177, 41.4785)

Data <- as.data.frame(cbind(Sites, Longitude, Latitude))
Data$Sites <- as.vector(Data$Sites)
Data$Longitude <- as.numeric(Data$Longitude)
Data$Latitude <- as.numeric(Data$Latitude)


# Create rds files joining climate data by site ---------------------------

for(site in Sites) {
  print(site)
  long = Data$Longitude[Data$Sites == site]
  lat = Data$Latitude[Data$Sites == site]
  # Variables to extract from the rasters
  vars = c('t2m', 'tp') # t2m: temperature at 2 m; tp: total precipitation
  vars_year = lapply(nc_Files, brick_extract, vars = vars,
                     long = long, lat = lat) # function brick_extract in source/functions.R
  dfsite = do.call(rbind, vars_year)
  # Save soil moisture data
  connection = "data/ClimateData/"
  name_file = paste0(site, "_tmpprec.rds")
  rdsBy(connection, name_file, dfsite, replace = T)
}
