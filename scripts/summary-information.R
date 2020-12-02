library(dplyr)

city_price_data <- read.csv(
  "../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv")

# gets summary information about a given dataset
get_summary_info <- function(dataset) {
  # gets the city with the highest median house price in 2017
  highest_median_price_2017 <- city_price_data %>%
    select(RegionName, X2017.01) %>%
    filter(X2017.01 == max(X2017.01, na.rm = TRUE)) %>%
    pull(RegionName)

  # gets the city with the lowest median house price in 2017
  lowest_median_price_2017 <- city_price_data %>%
    select(RegionName, X2017.01) %>%
    filter(X2017.01 == min(X2017.01, na.rm = TRUE)) %>%
    pull(RegionName)

  # gets the average median house price in 2017
  average_median_price_2017 <- city_price_data %>%
    select(RegionName, X2017.01) %>%
    filter(X2017.01 != is.na(X2017.01)) %>%
    summarize(mean = mean(X2017.01)) %>%
    pull(mean)

  # gets the median price of the largest city, New York in 2017
  new_york_2017_price <- city_price_data %>%
    filter(RegionName == "New York") %>%
    pull(X2017.01)

  # gets the median price of Winterset, which is tied for smallest city listed
  winterset_2017_price <- city_price_data %>%
    filter(RegionName == "Winterset") %>%
    pull(X2017.01)

  #returns a list of 2017 summary info
  return(c(c("Highest Price:" = highest_median_price_2017),
              c("Lowest Price:" = lowest_median_price_2017),
              c("Average Price:" = average_median_price_2017),
              c("New_York_Price:" = new_york_2017_price),
              c("Winterset_Price:" = winterset_2017_price)))
}
