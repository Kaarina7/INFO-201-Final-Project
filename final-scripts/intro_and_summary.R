library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(plotly)
source("line_tab.R")
source("map_tab.R")
source("style.css")
source("aggregate_Table.R")

overviewInformation <- tabPanel(
  title = "Overview",
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
        "Line"
      ),
      p(
        "The third visualization is a line graph about how long the different 
        houses on Zillow have been on the market for."
      )
      
    )
  )
)

change <- 299414 - 238738
per_change <- round((((change) / 299414) * 100), 2)
link <- tags$a(
  href = "https://fred.stlouisfed.org/series/MEHOINUSA672N",
  "10%"
)


conclusions <- tabPanel(
  title = "Conclusions",
  tags$h2(
    "Conclusions From Our Data "
  ),
  tags$div(
    tags$h4(
      id = "ColncldusionSubHeader",
      "Conclusions from Visualization3"
    ),
    h2(
      "Economic Conclusions"
    )
  ),
  p(paste0("The price in 2017 was $299414 and at its lowest point in 2011 was 
  $238738. The price increases by $", change,
           " which is an increase of ", per_change, "%")),
  p("In the same time that the hosuing price has increased by ", per_change,
    "the % increase in household income has risen by,", link),
  p("Houses are usualy sold around 3% less than the listing price on average
  While the amount of listings on Zillow is not every house listed on the market
  , the general trend holds that prices of houses are increasing at a greater 
    rate than income"),
  plotlyOutput(outputId = "conclusion1", width = "75%"),
  h2("Hosuing Market Insights"),
  h6("Cities with Highest List Price"),
  p("The table shows that the cities with the highest median house prices. The 
    cities in the top 10 tend to be on the coasts or by the water in mostly 
    sunny areas. The top 10 house prices all come from states in the top 5 
    for population size. This reveals an economic idea about how the scarcity
    of houses (a fixed supply) with an increasing demand for these houses 
    increases the price of these homes"),
  tags$table(
    id = "Table",
    tableOutput("conclusion2")
  ),
  h6("Days on Zillow for the USA as a whole"),
  plotOutput("conclusion3"),
  p("The above graph shows the average days on zillow for every month from
    January 2010 to August 2017."),
  p("The trend line shows that the # of days a house
    is on Zillow has significantly decreased, 150 to around 80. This is a result
    of either increased popularity of Zillow to sell a house or increase in
    houses bought."),
  p("The line also shows a dip in each year around the summer months showing
    that new houses are bought quicker in the summer.")
)


uiui <- fluidPage(
  includeCSS("style.css"),
  tags$h1(
    id = "Page_Header",
    "Zillow Housing Information (2010 - 2017)"
  ),
  navbarPage(
    title = "Navigation Bar",
    overviewInformation,
    conclusions,
    theme = "style.css",
    tags$style(
      id = "NavBarHeader",
      position = "static-top"
    )
  )
)
server <- function(input, output) {
  output$conclusion1 <- renderPlotly({
    source("aggregate_Table.R")
    change_in_price <- city_data %>%
      select(X2011.01, X2017.09) %>%
      drop_na() %>%
      summarise(
        Jan.2011 = mean(X2011.01),
        Sep.2017 = mean(X2017.09)
      ) %>%
      gather(key = "Year", value = "List.Price")
    ##
    price_change_plot <- ggplot(change_in_price) +
      geom_bar(mapping = aes( x = Year, y = List.Price, 
                              text = paste0("Price = $",
                                            round(List.Price, 2))),
               stat = "identity", fill = "Blue") +
      ylab("Median Household List Price ($)") + xlab("Date")
    return(ggplotly(price_change_plot, tooltip = "text")) 
  })
  output$conclusion2 <- renderTable({
    top_10_cities <- aggregate_table(city_data)
    return(top_10_cities)
  })
  output$conclusion3 <- renderPlot({
    days_listed_trend <- days_listed_state %>%
      select(matches("201|RegionName")) %>%
      #Using Gather to Make Month Column have old column values as rows
      gather(key = "month", value = "Days", -RegionName) %>%
      group_by(month) %>%
      filter(!is.na(Days)) %>%
      mutate(
        Days = as.numeric(Days)
      ) %>%
      summarise(
        Days = mean(Days, na.rm = TRUE)
      )
    return(ggplot(days_listed_trend, aes(x = month, y = Days,
                                  group = 1)) + geom_line() +
      labs(title = "Average Days a Home is Listed on Zillow in the US") +
      geom_point() +
      theme(axis.text.x = element_text(angle = 90)) +
      geom_line(color = "blue"))
  })
  
}


