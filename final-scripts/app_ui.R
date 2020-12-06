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
  tags$div(
    id = "OverviewSection1",
    tags$h3(
      id = "SubHeader",
      "Choice of Domain: "
    ),
    p(
      "We are business, economics, and computational finance majors, and we felt 
    that the field of housing markets intersected all of our major-related 
    interests, so we chose to focus on it for our project. "),
    tags$h3(
      id = "SubHeader",
      "Our Data sets: "
    ),
    p(
      "The data sets we decided to use come from Zillow. 
    Zillow regularly gathers information about all of the homes listed for sale 
    on their website and makes it publicly  available, and we decided to make 
    use of several pieces of it. The first lists the median housing prices 
    across the nation according to different regional categories. 
    It can be used to answer questions about how house prices vary by 
    geographic region, as well as how they've changed over the past ten years. 
    The second lists the average number of days a listing stays on Zillow 
    by region. This can be used to examine changes in the speed 
    with which houses sell in different areas."
    ),
    tags$h3(
      id = "SubHeader",
      "Links to Data Sets: "
    ),
    tags$a(
      href = "https://data.world/zillow-data/median-list-price", "Median Price"
    ),
    p(
      
    ),
    tags$a(
      href = "https://data.world/zillow-data/days-on-zillow", "Days on Zillow"
    )
  ),
  tags$div(
    id = "OverviewSection1",
    h1("Visualizations: "),
    tags$h3(
      id = "SubHeader",
      "Visualization 1"
    ),
    p(
      "The first visualization is about ....."
    ),
    tags$h3(
      id = "SubHeader",
      "Visualization 2"
    ),
    p(
      "The second visualization is about ....."
    ),
    
  )
)



visual1 <- tabPanel(
  title = "Visual 1",
  tags$h1(
    id = "Header",
    "This is a chart"
    )
)

visual2 <- tabPanel(
  title = "Visual 2",
  tags$h1(
    id = "Header",
    "This is a map"
    )
)

visual3 <- tabPanel(
  title = "Visual 3",
  tags$h1(
    id = "SubHeader",
    "This is a chart"
    )
)

conclusions <- tabPanel(
  title = "Conclusions"
)


ui <- fluidPage(
  includeCSS("style.css"),
  h1(strong("Zillow Housing Information (2010 - 2017)")),
  navbarPage(
    title = "Navigation Bar",
    overviewInformation,
    bar,
    map,
    line,
    position = "static-top",
    inverse = TRUE
    visual1,
    visual2,
    visual3,
    conclusions,
    position = "static-top"
  )
)

