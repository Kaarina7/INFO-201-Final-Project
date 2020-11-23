library(dplyr)
library(lintr)

aggregate_table <- function(dataset, column){
  dataset %>%
    group_by(column)
}
data <- read.csv("C:/Users/rchap/Info201/INFO-201-Final-Project/project-data/days-on-zillow/daysonzillow_public_metro.csv")

x <- data %>%
  select(6:7) %>%
  rowwise() %>%
  mutate(
    c = mean(c(column_f, column_g), na.rm = TRUE)
  )
