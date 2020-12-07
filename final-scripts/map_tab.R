# load necessary libraries
library("shiny")
library("leaflet")
library("dplyr")

# read in dataset
city_data <- read.csv(
  "../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
  stringsAsFactors = FALSE)

# add City, State column to dataset
city_data <- mutate(city_data, "City, State" =  paste(RegionName, State))

# read in dataset with latitude and longitude information
location_data <- read.csv("../project-data/uscities.csv",
                          stringsAsFactors = FALSE)

# add City, State column to dataset
location_data <- mutate(location_data, "City, State" = paste(city, state_id))

# join datasets together and add radius column
city_location <- city_data %>%
  dplyr::left_join(location_data, by = "City, State") %>%
  mutate(radius = 0.025 * X2017.09)

# create main panel for map tab
map_main_panel <- mainPanel(
  h1("Interactive Map"),
  p("This map helps answer the question of how median house prices have changed
  geographically over time."),
  leafletOutput("map")
)

# create side panel for map tab
map_side_panel <- sidebarPanel(
  # choose the year to view
  selectInput(
    "date",
    label = "Choose the date",
    choices = colnames(city_location)[6:98]
  )
)

# create tab for map
map_ui <- navbarPage(
  title = "Temp",
  tabPanel(
    title = "Map",
    sidebarLayout(
      map_main_panel,
      map_side_panel  
    )
  )
)

# create labels for map
point_labels <- lapply(seq(nrow(city_location)), function(i) {
  paste0("<p>", city_location[i, "name"], "<p></p>",
         city_location[i, "city"], "</p><p>")
})

map_server <- function(input, output) {
  # render map
  output$map = renderLeaflet(
    # create map with details
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
  )
}

shinyApp(ui = map_ui, server = map_server)
