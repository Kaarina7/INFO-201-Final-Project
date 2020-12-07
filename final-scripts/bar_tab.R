library(shiny)
source("bar-chart-function.R")
bar_ui <- tabPanel(
  title = "Change in House Prices",
  h1("Change in House Prices"),
  p("This bar graph attempts to answer questions about how house prices have
    changed over the years, and how city size is related to changes in house
    price. The length encoding (bar graph) was selected because differences
    between values can be easily seen with length. So it is very effective
    to see these trends when working with a small range of 
    noncontinuous x values (years 2010 to 2017)"),
  sidebarLayout(
    sidebarPanel(
      # slider for the range of years
      sliderInput("range", "Year Range",
                  min = 2010, max = 2017,
                  value = c(2010, 2017)),
      # slider for the size ranks
      sliderInput("size_rank", "Size Rank (1 is largest population)",
                  min = 1, max = 7080,
                  value = c(1, 7080)
      )
    ),
    mainPanel(
      # outputs the bar graph
      plotlyOutput(outputId = "bar_graph"),
      p("")
    )
  )
)

ui_test <- fluidPage(
  h1(strong("Insert Title")),
  navbarPage(
    title = "Insert Title",
    bar_ui,
    position = "static-top",
    inverse = TRUE
  )
)

server <- function(input, output) {
  # outputs the bar chart given selected year and size range
  output$bar_graph <- renderPlotly({
    bar_graph(city_data, (input$range[1] - 2009):(input$range[2] - 2009),
              input$size_rank)
  })
}
shinyApp(ui = ui, server = server)
