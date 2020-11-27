library("dplyr")
library("leaflet")

# read in dataset
setwd("~/INFO201/INFO-201-Final-Project/scripts")
city_data <- read.csv("../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
                      stringsAsFactors = FALSE)

city_data <- mutate(city_data, "City, State" =  paste(RegionName, State))

location_data <- read.csv("../project-data/uscities.csv",
                          stringsAsFactors = FALSE)

location_data <- mutate(location_data, "City, State" = paste(city, state_id))

city_location <- dplyr::left_join(city_data, location_data, by = "City, State")

city_location <- mutate(city_location, radius = 0.025 * X2017.09)

point_labels <- lapply(seq(nrow(city_location)), function(i) {
  paste0("<p>", city_location[i, "name"], "<p></p>",
         city_location[i, "city"], "</p><p>")
})

city_map <- leaflet(data = city_location) %>%
  addTiles() %>%
  setView(lng = -96, lat = 40, zoom = 4) %>%
  addCircles(
    lat = ~lat,
    lng = ~lng,
    radius = ~radius,
    stroke = FALSE,
    label = lapply(point_labels, htmltools::HTML)
  )
