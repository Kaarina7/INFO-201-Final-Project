intro_ui <- fluidPage(
  overviewInformation <- tabPanel(
    title = "Overview",
    tags$h3(
      id = "SubHeader",
      "Choice of Domain"
      ),
    p(
      "We are business, economics, and computational finance majors, and we felt 
    that the field of housing markets intersected all of our major-related 
    interests, so we chose to focus on it for our project. "),
    tags$h3(
      id = "SubHeader",
      "Our Data sets"
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
      "Link to Data Set"
    ),
    tags$a(
      href = "https://data.world/zillow-data/median-list-price", "Median Price"
    ),
    tags$a(
      href = "https://data.world/zillow-data/days-on-zillow", "Days on Zillow"
    )
  )
) 

intro_server <-
  
  
  


summary_ui <-
  
  
summary_server <- 