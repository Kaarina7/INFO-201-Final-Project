library(dplyr)
library(lintr)
library(reshape2)
library(tidyr)
library(tidyverse)
library(stringr)
aggregate_table <- function(data, location_type){
  
  if(location_type == "State")
  columns_needed <- data[, grep("201|State", names(data))]
  x <- data %>%
    gather(key = "month", value = "list_price", -State) %>%
    group_by(State) %>%
    filter(
      !is.na(list_price)
    ) %>%
    filter(str_detect(month, "201")) %>%
    mutate(
      list_price = as.numeric(list_price)
    ) %>%
    summarise(
      list_price = mean(list_price, na.rm = TRUE)
    ) %>%
    arrange(desc(list_price)) %>%
    top_n(10)
}


o <- aggregate_table(data, "State")
data <- read.csv("C:/Users/rchap/Info201/INFO-201-Final-Project/project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv")





a <- data[, grep("201|State", names(data))]
x <- data %>%
  gather(key = "month", value = "list_price", -State) %>%
  group_by(State) %>%
  filter(
    !is.na(list_price)
  ) %>%
 filter(str_detect(month, "2011")) %>%
  mutate(
    list_price = as.numeric(list_price)
  ) %>%
  summarise(
    list_price = mean(list_price, na.rm = TRUE)
  ) %>%
  arrange(desc(list_price)) %>%
  top_n(10)

View(mtcars)
is.vector(data$month)
