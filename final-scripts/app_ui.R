library(shiny)
source("./final-scripts/bar_tab.R")
source("./final-scripts/line_tab.R")
source("./final-scripts/map_tab.R")
source("./final-scripts/intro_and_summary.R")
source("./styles.css") 
overviewInformation <- tabPanel(
  title = "Overview",
  p(
    "We are business, economics, and computational finance majors, and we felt 
    that the field of housing markets intersected all of our major-related 
    interests, so we chose to focus on it for our project. The data sets we 
    decided to use come from Zillow. Zillow regularly gathers information about 
    all of the homes listed for sale on their website and makes it publicly 
    available, and we decided to make use of several pieces of it. 
    The first lists the median housing prices across the nation according to 
    different regional categories. It can be used to answer questions about how 
    house prices vary by geographic region, as well as how they've changed over 
    the past ten years. The second lists the average number of days a listing 
    stays on Zillow by region. This can be used to examine changes in the speed 
    with which houses sell in different areas."
    

  )
)
bar <- tabPanel(
  title = "Visual 1",
  h1("This is a chart")
)

map <- tabPanel(
  title = "Visual 2",
  h1("This is a map")
)

line <- tabPanel(
  title = "Visual 3",
  h1("This is a chart")
)




ui <- fluidPage(
  h1(strong("Zillow Housing Information (2010 - 2017)")),
  navbarPage(
    title = "Navigation Bar",
    overviewInformation,
    bar,
    map,
    line,
    position = "static-top",
    inverse = TRUE
  )
)

