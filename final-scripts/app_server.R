library(shiny)
source("bar_tab.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")
source("styles.css") 

server <- function(input, output) {
  # outputs the bar chart given selected year and size range
  output$bar_graph <- renderPlotly({
    bar_graph(city_data, (input$range[1] - 2009):(input$range[2] - 2009),
              input$size_rank)
  })
  
  output$conclusion1 <- renderPlotly({
    source("aggregate_Table.R")
    change_in_price <- city_data %>%
      select(X2010.01, X2017.09) %>%
      drop_na() %>%
      summarise(
        Jan.2010 = mean(X2010.01),
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
  
  output$line_graph <- renderPlot({
    line_graph <- function(region_type, region_name, state_code = NULL) {
      # deal with user input and use it to select the proper dataset
      region_type <- tolower(region_type)
      region_name <- tolower(region_name)
      if (region_type == "state") {
        state_code <- NULL
        df <- days_listed_state
        relevant_data <- df[df$RegionName == region_name, ]
      } else { # region_type is equal to county
        df <- days_listed_county
        state_code <- toupper(state_code)
        df <- filter(df, df[["StateName"]] == state_code)
        relevant_data <- df[df$RegionName == region_name, ]
      }
      # clean the data to make it graph ready
      relevant_data <- as.data.frame(t(as.matrix(relevant_data)))
      names(relevant_data) <- as.matrix(relevant_data[1, ])
      relevant_data <- tibble::rownames_to_column(relevant_data, "Dates")
      relevant_data <- relevant_data[-1, ]
      if (region_type == "county") {
        relevant_data <- relevant_data[-1, ]
      }
      relevant_data[[region_name]] <- 
        as.numeric(relevant_data[[region_name]])
      
      # format labels for use in graph
      season_labels <- paste(rep(c("Winter\n", "Spring\n", "Summer\n",
                                   "Fall\n"), each = 3), rep(2010:2017, each = 12))
      for (n in 1:96) {
        if (n %% 3 != 1) {
          season_labels[n] <- ""
        }
      }
      
      # make the graph
      ggplot(relevant_data, aes(x = Dates, y = .data[[region_name]],
                                group = 1)) + geom_line() +
        labs(title = paste0("Average Days a Home is Listed on Zillow in ",
                            str_to_title(region_name),
                            ifelse(is.null(state_code), " State",
                                   paste(" County,", toupper(state_code)))),
             y = "Number of Days") +
        scale_x_discrete(labels = season_labels) + geom_point() +
        theme(axis.text.x = element_text(angle = 90)) +
        geom_line(color = "blue")
    }
    
    return(
      line_graph(input$location_type, input$location_name, input$if_state)
    )
  })
}
