library("shiny") 
source("bar-chart-function.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")
source("styles.css") 


source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
