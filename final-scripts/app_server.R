library(shiny)
source("bar_tab.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")
source("styles.css") 

server <- function(input, output) {
  # outputs the bar chart given selected year and size range
  output$bar_graph <- renderPlotly({
    bar_graph(city_data, (input$range[1] - 2009):(input$range[2] - 2009),
              input$size_rank)
  })
  output$map = renderLeaflet({
    # create map with details
    city_map <- leaflet(data = city_location) %>%
      addTiles() %>%
      setView(lng = -96, lat = 40, zoom = 4) %>%
      addCircles(
        lat = ~lat,
        lng = ~lng,
        radius = ~0.025 * city_location[[input$date]],
        stroke = FALSE,
        label = lapply(point_labels, htmltools::HTML)
      )
  })
  output$conclusion1 <- renderPlotly({
    source("aggregate_Table.R")
    change_in_price <- city_data %>%
      select(X2010.01, X2017.09) %>%
      drop_na() %>%
      summarise(
        Jan.2010 = mean(X2010.01),
        Sep.2017 = mean(X2017.09)
      ) %>%
      gather(key = "Year", value = "List.Price")
    ##
    price_change_plot <- ggplot(change_in_price) +
      geom_bar(mapping = aes( x = Year, y = List.Price, 
                              text = paste0("Price = $",
                                            round(List.Price, 2))),
               stat = "identity", fill = "Blue")
    return(ggplotly(price_change_plot, tooltip = "text"))
  })
}
