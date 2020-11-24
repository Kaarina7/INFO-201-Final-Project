library(dplyr)
library(lintr)
library(reshape2)
library(tidyr)
library(tidyverse)
library(stringr)

# The particular group calculation was done because each of the data sets we are 
# using is organized by a different type of region, city, state, county,
# neighborhood, and Zip code. The data can be applied to show the average list
# price by region over the course of 7 years. It displays the highest 10 prices. 

aggregate_table <- function(data){
  columns_needed <- data[, grep("201|RegionName", names(data))]
  data %>%
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


o <- aggregate_table(data)
data <- read.csv("C:/Users/rchap/Info201/INFO-201-Final-Project/project-data/median-listing-price/State_MedianListingPrice_AllHomes.csv")




a <- data[, grep("201|RegionName", names(data))]
x <- data %>%
  gather(key = "month", value = "list_price", -RegionName) %>%
  group_by(RegionName) %>%
  filter(
    !is.na(list_price)
  ) %>%
  mutate(
    list_price = as.numeric(list_price)
  ) %>%
  summarise(
    list_price = max(list_price, na.rm = TRUE)
  ) %>%
  arrange(desc(list_price))
 
# else if(location_type == "City") {
#   columns_needed <- data[, grep("201|Metro", names(data))]
#   x <- data %>%
#     gather(key = "month", value = "list_price", -Metro) %>%
#     group_by(Metro) %>%
#     filter(
#       !is.na(list_price)
#     ) %>%
#     filter(str_detect(month, "201")) %>%
#     mutate(
#       list_price = as.numeric(list_price)
#     ) %>%
#     summarise(
#       list_price = mean(list_price, na.rm = TRUE)
#     ) %>%
#     arrange(desc(list_price)) %>%
#     top_n(10)
# }
# else if(location_type == "County") {
#   columns_needed <- data[, grep("201|RegionName", names(data))]
#   x <- data %>%
#     gather(key = "month", value = "list_price", -RegionName) %>%
#     group_by(RegionName) %>%
#     filter(
#       !is.na(list_price)
#     ) %>%
#     filter(str_detect(month, "201")) %>%
#     mutate(
#       list_price = as.numeric(list_price)
#     ) %>%
#     summarise(
#       list_price = mean(list_price, na.rm = TRUE)
#     ) %>%
#     arrange(desc(list_price)) %>%
#     top_n(10)
# } else if(location_type == "Neighborhood") {
#   columns_needed <- data[, grep("201|State", names(data))]
#   x <- data %>%
#     gather(key = "month", value = "list_price", -CountyName) %>%
#     group_by(CountyName) %>%
#     filter(
#       !is.na(list_price)
#     ) %>%
#     filter(str_detect(month, "201")) %>%
#     mutate(
#       list_price = as.numeric(list_price)
#     ) %>%
#     summarise(
#       list_price = mean(list_price, na.rm = TRUE)
#     ) %>%
#     arrange(desc(list_price)) %>%
#     top_n(10)
# }
# }
