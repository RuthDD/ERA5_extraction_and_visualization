
# Use this function to generate rds files ---------------------------------

rdsBy <- function(connection, file, data, replace = F) {
  # Verify if the path exists
  if(dir.exists(connection)) {
    if(!file.exists(paste0(connection, file))) {
      saveRDS(data, paste0(connection, file))
      cat(paste0(file, " created", "\n"))
    } else if(replace) {
      file.remove(paste0(connection, file))
      saveRDS(data, paste0(connection, file))
      cat(paste0("The file '", file, "' has been replaced", "\n"))
    } else {
      cat(paste0("The file '", file, "' already exists", "\n"))
    }
  } else {
    cat(paste0("The connection '", connection, "' doesn't exist", "\n"))
  }
}


# Function to extract variables from a raster -----------------------------

brick_extract <- function(ncfile, vars, long, lat) {
  coord = as.data.frame(cbind(long, lat))
  print(coord)
  cat('processing', ncfile, '\n')
  nc_allvars = list()
  count = 0
  for(var in vars){
    count = count + 1
    # Create multi-layer raster objects from .nc files
    nc_brick <- brick(ncfile, varname = var)
    nc_extr <- raster::extract(nc_brick, 
                               coord, 
                               method = 'bilinear')
    nc_extrdf = data.frame(coord, nc_extr) # wide format
    long_df <- nc_extrdf %>%  
      pivot_longer(names(nc_extrdf)[-c(1:2)]) # long format
    # name as date-time format
    long_df$name <- unlist(nc_brick@z)
    long_df$name <- lubridate::as_datetime(long_df$name)
    # specify the name of the value according to the variable
    varname = paste0('value_', var)
    names(long_df)[length(names(long_df))] = varname
    nc_allvars[[count]] = long_df
    cat(var, 'extracted')
    cat('\n')
  }
  df <- plyr::join_all(nc_allvars, by = c("long", "lat", "name"))
  return(df)
}


# Function to generate new columns from date column -----------------------

dateinfo_cols <- function(file) {
  metdata <- file %>% 
    map_dfr(readRDS) %>%
    mutate(mon = lubridate::month(name),
           MonthLabel = factor(
             lubridate::month(name), 
             levels = as.character(1:12),
             labels = c("Jan","Feb","Mar","Apr","May","Jun",
                          "Jul","Aug","Sep","Oct","Nov","Dec")
             ),
           DoY = as.numeric(format(name, format = "%j"))
           )
  return(metdata)
}
