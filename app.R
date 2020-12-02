library(shiny)


source("./final-scripts/bar_tab.R")
source("./final-scripts/line_tab.R")
source("./final-scripts/map_tab.R")
source("./final-scripts/intro_and_summary.R")
source("./styles.css") 
# unsure if we need styles.css files inside /final-scripts/ too. I think these
# styles will end up applied to everything, but we'll see



# build final web page layout here using variables loaded from above

final_ui <- 
  
  
final_server <- function(input, output) {
  
}

  

shinyApp(ui = final_ui, server = final_server)
