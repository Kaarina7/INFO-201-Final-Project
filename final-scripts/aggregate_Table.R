library(dplyr)
library(lintr)
library(tidyr)
library(tidyverse)
library(stringr)
library(lintr)
# The particular group calculation was done because each of the data sets
# we are using is organized by a different type of region, city, state, county,
# neighborhood, and Zip code. The data can be applied to show the average list
# price by region over the course of 7 years. It displays the highest 10 prices.
city_data <- read.csv(
  "project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
  stringsAsFactors = FALSE)

aggregate_table <- function(data) {
  data %>%
    #Getting all the year columns and the Region Name column
    select(matches("201|RegionName|State")) %>%
    #Using Gather to Make Month Column have old column values as rows
    gather(key = "month", value = "list_price", -RegionName, -State) %>%
    group_by(RegionName) %>%
    filter(
      !is.na(list_price)
    ) %>%
    mutate(
      list_price = as.numeric(list_price),
      RegionName = paste0(RegionName, " , ", State)
    ) %>%
    rename(
      Region.Name = RegionName,
      List.Price = list_price,
      state = State
    ) %>%
    summarise(
      List.Price = mean(List.Price, na.rm = TRUE),
    ) %>%
    mutate(
      List.Price = format(round(List.Price, 2), big.mark = ",",
                          scientific = FALSE)
    ) %>%
    arrange(desc(List.Price)) %>%
    mutate(
      List.Price = paste0("$", List.Price)
    ) %>%
    head(10)
}
