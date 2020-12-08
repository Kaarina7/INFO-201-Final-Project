library(shiny)
library(shinydashboard)
library(leaflet)
library(ggplot2)
library(plotly)
source("line_tab.R")
source("map_tab.R")
source("styles.css") 
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
  plotlyOutput(outputId = "conclusion1", width = "100%"),
  h2(
    "Hosuing Market Insights"
  )
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
    # visual1,
    # visual2,
    # visual3,
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
               stat = "identity", fill = "Blue")
    return(ggplotly(price_change_plot, tooltip = "text"))
  })
}


shinyApp(ui = uiui, server = server)
