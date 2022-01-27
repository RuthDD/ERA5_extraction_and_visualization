# Libraries ---------------------------------------------------------------
library(tidyverse)
library(raster) # raster() function to read .nc files
library(ncdf4)
library(plyr) # join_all()


# Read .nc files by year --------------------------------------------------
nc_Files <- list.files("data/ncfiles", pattern = '*.nc', full.names = T)

# Coordinates by site -----------------------------------------------------
Site <- c("Camarasa", "Badalona")
Longitude <- as.numeric(c(0.8813, 2.2223))
Latitude <- as.numeric(c(41.9177, 41.4785))

Data <- as.data.frame(cbind(Site, Longitude, Latitude))
Data
str(Data)

