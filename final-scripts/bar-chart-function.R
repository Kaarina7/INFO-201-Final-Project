# loads needed packages
library(dplyr)
library(ggplot2)
library(plotly)
# loads the data set
city_data <- read.csv(
  "../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
  stringsAsFactors = FALSE)

#function that creates the bar graph
bar_graph <- function(dataset, year_range, size_range) {
  # selects year columns and summarizes average median prices each year
  # also filters according to the size range specified
  city_summary <- dataset %>%
    filter(SizeRank > size_range[1]) %>%
    filter(SizeRank < size_range[2]) %>%
    select(X2010.01, X2011.01, X2012.01, X2013.01, X2014.01, X2015.01, X2016.01,
           X2017.01) %>%
    filter_at(vars(X2010.01, X2011.01, X2012.01, X2013.01, X2014.01, X2015.01,
                   X2016.01, X2017.01), all_vars(!is.na(.))) %>%
    summarize_all(mean) %>%
    mutate(across(where(is.numeric), round, 0))
  # makes summary data easier for ggplot to read and filters by 
  # selected years
  city_year_averages <- t(city_summary)
  city_year_averages <- cbind(year = rownames(city_year_averages),
                              city_year_averages)
  rownames(city_year_averages) <- NULL
  summary_data <- data.frame(city_year_averages)
  summary_data[["V2"]] <- as.numeric(summary_data$V2)
  year_range_data <- data.frame(summary_data$V2[year_range])
  names(year_range_data)[1] <- "price"

  labels <- paste(year_range + 2009)
  options(scipen = 10000)
  
  # creates the bar graph using filtered data, and adjusts labels based
  # on selected inputs from the ui
  fig <- plot_ly(year_range_data,
                 x = ~labels, y = ~price, type = 'bar', text = "",
                 marker = list(color = 'rgb(158,202,225)',
                               line = list(color = 'rgb(8,48,107)',
                                           width = 1.5)))
  fig <- fig %>% layout(title = paste0("House Price Data from ",
                                       (year_range[1] + 2009),
                                       " to ",
                                       (tail(year_range, n = 1) + 2009)),
                        xaxis = list(title = "Year"),
                        yaxis = list(title =
                                       "Average Median Listed House Price"))
  
  return(fig)
}
