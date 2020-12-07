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
      p(
        "The data sets we decided to use come from Zillow. Zillow regularly gathers information about all of the homes listed for sale 
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
        id = "OverviewSubHeader",
        "Links to Data Sets: "
      ),
      tags$a(
        id = "links",
        href = "https://data.world/zillow-data/median-list-price", "Median Price"
      ),
      p(
        
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
        "The first visualization is about ....."
      ),
      tags$h3(
        id = "VisualSubHeader",
        "Map"
      ),
      p(
        "The second visualization is about ....."
      ),
      tags$h3(
        id = "VisualSubHeader",
        "Line"
      ),
      p(
        "The third visualization is about ....."
      )
      
    )
  )
),
conclusions <- tabPanel(
  title = "Conclusions",
  tags$div(
    tags$h2(
      "The following conclusions can be found from the various visualizations
      that were provided"
    ),
    tags$h4(
      id = "ColnclusionSubHeader",
      "Conclusions from Visualization1"
    ),
    p(
      
    )
  ),
  tags$div(
    tags$h4(
      id = "ColnclusionSubHeader",
      "Conclusions from Visualization3"
    ),
    p(
      
    )
  ),
  tags$div(
    tags$h4(
      id = "ColnclusionSubHeader",
      "Conclusions from Visualization3"
    ),
    p(
      
    )
  )
),



visual1 <- tabPanel(
  title = "Visual 1",
  tags$h1(
    id = "Header",
    "This is a chart"
    )
),

visual2 <- tabPanel(
  title = "Visual 2",
  tags$h1(
    id = "Header",
    "This is a map"
    )
),

visual3 <- tabPanel(
  title = "Visual 3",
  tags$h1(
    id = "SubHeader",
    "This is a chart"
    )
),

conclusions <- tabPanel(
  title = "Conclusions"
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
    map,
    line,
    position = "static-top",
    inverse = TRUE,
    visual1,
    visual2,
    visual3,
    conclusions,
    theme = "style.css",
    tags$style(
      id = "NavBarHeader",
      position = "static-top"
    )
  )
)

