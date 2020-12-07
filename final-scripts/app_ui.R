library(shiny)

source("bar_tab.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")
source("styles.css") 


bar <- tabPanel(
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

map <- tabPanel(
  title = "Visual 2",
  h1("This is a map")
)

line <- tabPanel(
  title = "Visual 3",
  h1("This is a chart")
)



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
  ),
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
    )
  ),
  tags$body(
    id = "Body",
    tags$div(
      id = "OverviewSection1",
      tags$h3(
        id = "OverviewSubHeader",
        "Choice of Domain: "
      ),
      p(
        "We are business, economics, and computational finance majors. We decided 
      to center our projects around something that relates to something in 
      this area. We felt that the field of housing markets intersected all of 
      our major-related interests, so we chose to focus on it for our project."
      ),
      tags$h3(
        id = "OverviewSubHeader",
        "Our Data sets: "
      ),
      p("The data sets we decided to use come from Zillow. Zillow regularly
        gathers information about all of the homes listed for sale 
        on their website and makes it publicly  available, and we decided to
        make use of several pieces of it. The first lists the median housing
        prices across the nation according to different regional categories. 
        It can be used to answer questions about how house prices vary by 
        geographic region, as well as how they've changed over the past ten
        years. The second lists the average number of days a listing stays on
        Zillow by region. This can be used to examine changes in the speed 
        with which houses sell in different areas."
      ),
      tags$h3(
        id = "OverviewSubHeader",
        "Links to Data Sets: "
      ),
      tags$a(
        id = "links",
        href = "https://data.world/zillow-data/median-list-price", "Median Price"
      ),
      tags$a(
        id = "links",
        href = "https://data.world/zillow-data/days-on-zillow", "Days on Zillow"
      ),
      tags$h3(
        id = "OverviewSubHeader",
        "Purpose: "
      ),
      p(
        "Analysis from the median listing prices can be compared to other 
      economic factors to see how the housing markets have changed related to 
      them. Further research can be done to see what events or policies
      contributed to these changes. The analysis will also explore where and 
      when hosuing prices are the greatest/least and where/when major changes 
      have happened. Additionally, insights on where and how long houses stay 
      on the market for the longest or the least can be discovered."
      )
    ),
    tags$div(
      id = "OverviewSection2",
      tags$h3(
        id = "OverviewSubHeader",
        "Visualizations: "
      ),
      tags$h3(
        id = "VisualSubHeader",
        "Bar Chart"
      ),
      p(
        "The first visualization is a bar chart that shows how the average 
        median listing price changed from 2010 - 2017."
      ),
      tags$h3(
        id = "VisualSubHeader",
        "Map"
      ),
      p(
        "The second visualization is an interactive map that shows the different
        locations of the houses."
      ),
      tags$h3(
        id = "VisualSubHeader",
        "Days on Market"
      ),
      p(
        "The third visualization is a line graph about how long the different 
        houses on Zillow have been on the market for. "
      )
    )
  )
)


conclusions <- tabPanel(
  title = "Conclusions",
  h2(
  "Conclusions From Our Data "
  ),
  p(
    "Economic Insights"
  ),
  p(
    "Hosuing Market Insights"
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

ui <- fluidPage(
  includeCSS("style.css"),
  tags$h1(
    id = "Page_Header",
    "Zillow Housing Information (2010 - 2017)"
  ),
  navbarPage(
    title = "Navigation Bar",
    overviewInformation,
    bar,
#   map,
#   line,
#   visual1,
#   visual2,
#   visual3,
    conclusions,
    theme = "style.css",
    tags$style(
      id = "NavBarHeader",
      position = "static-top"
    )
  )
)
