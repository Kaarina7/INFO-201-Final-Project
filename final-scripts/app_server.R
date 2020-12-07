library(shiny)
# source("./final-scripts/bar_tab.R")
# source("./final-scripts/line_tab.R")
# source("./final-scripts/map_tab.R")
# source("./final-scripts/intro_and_summary.R")
# source("./styles.css") 

server <- function(input, output) {
  # outputs the bar chart given selected year and size range
  output$bar_graph <- renderPlotly({
    bar_graph(city_data, (input$range[1] - 2009):(input$range[2] - 2009),
              input$size_rank)
  })
}
