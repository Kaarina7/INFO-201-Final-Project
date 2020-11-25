library("dplyr")
library("leaflet")
library("ggmap")

# read in dataset
city_data <- read.csv("/home/kaarina/Documents/INFO201/INFO-201-Final-Project/project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
                      stringsAsFactors = FALSE)

city_data <- mutate(city_data, "City, State" =  paste(RegionName, State))

location_data <- read.csv("/home/kaarina/Documents/INFO201/INFO-201-Final-Project/project-data/uscities.csv",
                          stringsAsFactors = FALSE)

location_data <- mutate(location_data, "City, State" = paste(city, state_id))

city_location <- dplyr::left_join(city_data, location_data, by = "City, State")

point_labels <- lapply(seq(nrow(city_location)), function(i) {
  paste0("<p>", city_location[i, "name"], "<p></p>",
         city_location[i, "city"], "</p><p>")
})

leaflet(data = city_location) %>%
  addTiles() %>%
  setView(lng = -100, lat = 40, zoom = 3) %>%
  addCircles(
    lat = ~lat,
    lng = ~lng,
    radius = 10000,
    stroke = FALSE,
    label = lapply(point_labels, htmltools::HTML)
  )
