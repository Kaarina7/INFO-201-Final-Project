library(dplyr)
library(lintr)
library(reshape2)
library(tidyr)
library(tidyverse)
library(stringr)
library(lintr)
# The particular group calculation was done because each of the data sets
# we are using is organized by a different type of region, city, state, county,
# neighborhood, and Zip code. The data can be applied to show the average list
# price by region over the course of 7 years. It displays the highest 10 prices.

aggregate_table <- function(data) {

  data %>%
    #Getting all the year columns and the Region Name column
    select(matches("201|RegionName")) %>%
    #Using Gather to Make Month Column have old column values as rows
    gather(key = "month", value = "list_price", -RegionName) %>%
    group_by(RegionName) %>%
    filter(
      !is.na(list_price)
    ) %>%
    mutate(
      list_price = as.numeric(list_price)
    ) %>%
    summarise(
      list_price = mean(list_price, na.rm = TRUE)
    ) %>%
    arrange(desc(list_price)) %>%
    top_n(15)
}


o <- aggregate_table(X)
X <- read.csv("C:/Users/rchap/Info201/INFO-201-Final-Project/project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv",
                 stringsAsFactors = FALSE)
columns_needed <- data_11[, grep("201|RegionName", names(data_11))]
lint("aggregate_Table.R")



