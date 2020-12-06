# load necessary libraries
library(shiny)
library(ggplot2)
library(dplyr)


# define ui
line_ui <- tabPanel(
  sidebarLayout(
    sidebarPanel(
      # take inputs here
      selectInput(input = "location_type", label = "Select a region type",
                  choices = c("County", "State"), selected = "State"),
      textInput(inputId = "location_name", label = "Enter the region name",
                value = "King"),
      textInput(inputId = "if_state", "If you've entered a county name, enter
                its state code here:", value = "WA")
    ),
    mainPanel(
      # show graph here
    )
  )
)



# define server
line_server <- function(input, output) {
  
}