# load necessary libraries
library("shiny")
library("leaflet")
library("dplyr")

# read in dataset
city_data <- read.csv(
  "project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
  stringsAsFactors = FALSE)

# add City, State column to dataset
city_data <- mutate(city_data, "City, State" =  paste(RegionName, State))

# read in dataset with latitude and longitude information
location_data <- read.csv("project-data/uscities.csv",
                          stringsAsFactors = FALSE)

# add City, State column to dataset
location_data <- mutate(location_data, "City, State" = paste(city, state_id))

# join datasets together
city_location <- city_data %>%
  dplyr::left_join(location_data, by = "City, State")


# create labels for map
point_labels <- lapply(seq(nrow(city_location)), function(i) {
  paste0("<p>", city_location[i, "name"], "<p></p>",
         city_location[i, "city"], "</p><p>")
})
