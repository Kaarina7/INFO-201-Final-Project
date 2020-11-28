# loads needed packages
library(dplyr)
library(ggplot2)

# loads the data set
city_data <- read.csv(
  "../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
                      stringsAsFactors = FALSE)

#function that creates the bar graph
bar_graph <- function(dataset) {
  # selects year columns and summarizes average median prices each year
  city_summary <- dataset %>%
    select(X2010.01, X2011.01, X2012.01, X2013.01, X2014.01, X2015.01, X2016.01,
           X2017.01) %>%
    filter_at(vars(X2010.01, X2011.01, X2012.01, X2013.01, X2014.01, X2015.01,
                   X2016.01, X2017.01), all_vars(!is.na(.))) %>%
    summarize_all(mean) %>%
    mutate(across(where(is.numeric), round, 0))
  # makes summary data easier for ggplot to read
  city_year_averages <- t(city_summary)
  city_year_averages <- cbind(year = rownames(city_year_averages),
                            city_year_averages)
  rownames(city_year_averages) <- NULL
  summary_data <- data.frame(city_year_averages)
  summary_data[["V2"]] <- as.numeric(summary_data$V2)

  # creates the bar graph using summary data
  labels <- c("2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017")
  options(scipen = 10000)
  price_bar_graph <- ggplot(data = summary_data, aes(x = labels, y = V2)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    theme_minimal() +
    xlab("Year") +
    ylab("Average Median House Price (USD)") +
    coord_cartesian(ylim = c(0, 300000)) +
    ggtitle("Change in House Prices From 2010 to 2017") +
    theme(plot.title = element_text(hjust = 0.5))

  return(price_bar_graph)
}
