library(shiny)
library(plotly)
library(ggplot2)
library(DT)
source("bar-chart-function.R")
source("line_tab.R")
source("map_tab.R")
source("intro_and_summary.R")

server <- function(input, output) {
  # outputs the bar chart given selected year and size range
  output$bar_graph <- renderPlotly({
    bar_graph(city_data, (input$range[1] - 2009):(input$range[2] - 2009),
              input$size_rank)
  })

  output$map <- renderLeaflet({
    # create map with details
    city_map <- leaflet(data = city_location) %>%
      addTiles() %>%
      setView(lng = -96, lat = 40, zoom = 4) %>%
      addCircles(
        lat = ~lat,
        lng = ~lng,
        radius = ~0.025 * city_location[[input$date]],
        stroke = FALSE,
        label = lapply(point_labels, htmltools::HTML)
      )
  })

  output$line_graph <- renderPlotly({
    line_graph <- function(region_type, region_name, state_code = NULL) {
      # deal with user input and use it to select the proper data set
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
      ggplot(relevant_data, aes(x = Dates, y = .data[[region_name]], group = 1,
             text = paste0(.data[[region_name]], " days"))) + geom_line() +
        labs(title = paste0("Average Days a Home is Listed on Zillow in ",
        str_to_title(region_name), ifelse(is.null(state_code), " State",
        paste(" County,", toupper(state_code)))), y = "Number of Days") +
        scale_x_discrete(labels = season_labels) + geom_point(size = 1) +
        theme(axis.text.x = element_text(angle = 90, size = 6)) +
        geom_line(color = "blue")
    }

    # make the plot interactive
    line_plot <- ggplotly(line_graph(input$location_type, input$location_name,
                            input$if_state), tooltip = "text")
    return(line_plot)
  })

# This is the bar graph of the house price change from 2011 to 2017
  output$conclusion1 <- renderPlotly({
    source("aggregate_Table.R")
    # New data frame that only has the 2011 and 2017 data
    change_in_price <- city_data %>%
      select(X2010.01, X2017.09) %>%
      drop_na() %>%
      summarise(
        Jan.2010 = mean(X2010.01),
        Sep.2017 = mean(X2017.09)
      ) %>%
      gather(key = "Year", value = "List.Price")
    # Plotting the graph
    price_change_plot <- ggplot(change_in_price) +
      geom_bar(mapping = aes(x = Year, y = List.Price,
                              text = paste0("Price = $",
                                            round(List.Price, 2))),
               stat = "identity", fill = "Blue")
    return(ggplotly(price_change_plot, tooltip = "text"))
  })

# Creating a data table of the cities with the highest median house prices
  output$conclusion2 <- renderDataTable({
    top_10_cities <- datatable(aggregate_table(city_data))
    return(top_10_cities)
  })

# Creating a line graph of average days on Zillow for entire USA
  output$conclusion3 <- renderPlotly({
    # Making the average data frame
    days_listed_trend <- days_listed_state %>%
      select(matches("201|RegionName")) %>%
      # Using Gather to Make Month Column have old column values as rows
      gather(key = "month", value = "Days", -RegionName) %>%
      group_by(month) %>%
      filter(!is.na(Days)) %>%
      mutate(
        Days = as.numeric(Days)
      ) %>%
      summarise(
        Days = mean(Days, na.rm = TRUE)
      )
    # Plotting the data frame
    ggplotdays <- ggplotly(ggplot(days_listed_trend, aes(x = month, y = Days,
                                         group = 1)) +
             geom_line() +
             labs(title = "Average Days a Home is Listed on Zillow in the US") +
             geom_point() +
             theme(axis.text.x = element_text(angle = 90)) +
             geom_line(color = "navyblue"))
  })

}
