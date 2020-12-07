library("shiny") 
source("./final-scripts/bar_tab.R")
source("./final-scripts/line_tab.R")
source("./final-scripts/map_tab.R")
source("./final-scripts/intro_and_summary.R")
source("./styles.css") 


source("app_ui.R")
source("app_server.R")

shinyApp(ui = ui, server = server)
