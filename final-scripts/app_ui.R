library(shiny)
library(DT)
source("bar-chart-function.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")

## This is the first visualization which is a bar chart
bar <- tabPanel(
  title = "Change in House Prices",
  h1(id = "OverviewSubHeader",
    "Change in House Prices"),
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

# Second visualization which is an interactive map
map <- tabPanel(
  title = "House Prices vs. Time",
  h1(
    id = "OverviewSubHeader",
    "Geographic Change in House Prices vs. Time"),
  sidebarLayout(
    mainPanel(
      p("This map helps answer the question of how median house prices have
      changed geographically over time. The map encoding was chosen because it
      is easiest for the user to visually track geographic movements by watching
      the points change."),
      leafletOutput("map")
    ),
    sidebarPanel(
      # choose the year to view
      selectInput(
        "date",
        label = "Choose the date",
        choices = colnames(city_location)[6:98]
      )
    )
  )
)

# Third visualization which is a line graph
line <- tabPanel(
  title = "Days Listed Online",
  h1(
    id = "OverviewSubHeader",
    "Days Listed Online"
  ),
  sidebarLayout(
    sidebarPanel(
      # take inputs here
      selectInput(input = "location_type", label = "Select a region type",
                  choices = c("County", "State"), selected = "County"),
      textInput(inputId = "location_name", label = "Enter the region name",
                value = "King"),
      textInput(inputId = "if_state", "If you've entered a county name, enter
                its state code here:", value = "WA")
    ),
    mainPanel(
      # show the graph and analysis here
      p("This line graph looks at the average number of days a house remains
      listed on Zillow by time, and it breaks the data down by region.
      It answers questions such as \"When did houses take the longest time to
      sell?\", and it uses the inputs to the left to decide which region to
      show. The default below is an example of King County, Washington.",
        style = "font-size:18px"
      ),
      plotlyOutput("line_graph"),
      p("The graphs clearly show that over the years, selling a house has
      become a quicker process. Even more pronounced in the difference in time
      it takes to sell a house by season. Depending on the location, houses
      listed on Zillow in Winter and Fall can take nearly twice as long to sell
      as those listed in Spring and Summer.",
        style = "font-size:18px"
      )
    )
  )
)

# This is the summary section of the page
overview_information <- tabPanel(
  title = "Overview",
  tags$body(
    id = "Body",
    tags$div(
      id = "OverviewSection1",
      # Explain the domain
      tags$h3(
        id = "OverviewSubHeader",
        "Choice of Domain: "
      ),
      p(
        "We are business, economics, and computational finance majors. We
        decided to center our projects around something that relates to
        something in this area. We felt that the field of housing markets
        intersected all of our major-related interests, so we chose to focus on
        it for our project."
      ),
      # Explain the data sets we used
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
      # Provide hyperlinks to the data sets
      tags$h3(
        id = "OverviewSubHeader",
        "Links to Data Sets: "
      ),
      tags$a(
        id = "links",
        href = "https://data.world/zillow-data/median-list-price",
        "Median Price"
      ),
      tags$a(
        id = "links",
        href = "https://data.world/zillow-data/days-on-zillow", "Days on Zillow"
      ),
      # Explain purpose of the project
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
    # Describe what visualizations are being used
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

# This code is for the economic impact explanation in the conclusion
change <- 299414 - 238738
per_change <- round((((change) / 299414) * 100), 2)
link <- tags$a(
  href = "https://fred.stlouisfed.org/series/MEHOINUSA672N",
  "10%"
)

# Conclusions Tab
conclusions <- tabPanel(
  title = "Conclusions",
  tags$h1(
    id = "OverviewSubHeader",
    "Conclusions From Our Data "
  ),
  # Start with economic conclusions comparing income to median house price
  h2(
    id = "VisualSubHeader",
    "Economic Conclusions"
    ),
  tags$ul(
    tags$li(p(paste0("The median housing price in 2017 was $299414 and at its 
    lowest year, 2011, was $238738. The price increases by $", change,
                   " which is an increase of ", per_change, "%"))),
    tags$li(p("In the same time that the hosuing price has increased by ",
            per_change, "the % increase in household income has risen by,",
            link, "*(Click for source)")),
    tags$li(p("Houses are usualy sold around 3% less than the listing price on 
    average. While the amount of listings on Zillow is not every house listed 
    on the market, the general trend holds that prices of houses are increasing 
    at a greater rate than income posing a problem for Americans to pay for 
              homes. ")),
  ),
  plotlyOutput(outputId = "conclusion1", width = "75%"),
  # Go into more general insights of the housing market 
  h2(
    id = "VisualSubHeader",
    "Hosuing Market Insights"
    ),
  div(
    id = "HighestCities",
    # Show cities with the highest listing price
  h4(
    id = "conclusionSubheader",
    "Cities with Highest List Price"),
  p("The table shows that the cities with the highest median house prices. The
    cities in the top 10 tend to be on the coasts or by the water in mostly
    sunny areas. The top 10 house prices all come from states in the top 5
    for population size."),
  # Add additional economic conclusion. 
  p("There is actually an economic idea to explain this. This is how scarcity
    of houses in a good location (a fixed supply) with an increasing demand for 
    these houses increases the price of these homes, as sellers can pick and 
    choose who to sell to based on the highest bid."),
  dataTableOutput("conclusion2", width = "75%"),
  ),
  # Show the days on Zillow for the USA as a whole
  h4( 
    id = "conclusionSubheader",
    "Days on Zillow for the USA as a whole"
    ),
  p("The above graph shows the average days on zillow for every month from
    January 2010 to August 2017."),
  tags$ul(
    tags$li(p("The trend line shows that the # of days a house
    is on Zillow has significantly decreased, 150 to around 80. This is a result
    of either increased popularity of Zillow to sell a house or increase in
    houses bought.")),
    tags$li(p("The line also shows a dip in each year around the summer months 
    showing that new houses are bought quicker in the summer.")),
  plotOutput("conclusion3")
  )
)

# This is the main ui which links to the CSS document
ui <- fluidPage(
  includeCSS("style.css"),
  tags$h1(
    id = "Page_Header",
    "Zillow Housing Information (2010 - 2017)"
  ),
  navbarPage(
    title = "Analysis and Graphs:",
    overview_information,
    bar,
    map,
    line,
    conclusions,
    position = "static-top",
    inverse = TRUE,
    theme = "style.css",
    tags$style(
      id = "NavBarHeader",
      position = "static-top"
    )
  )
)
