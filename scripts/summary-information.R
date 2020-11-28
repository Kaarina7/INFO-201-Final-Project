library(dplyr)

get_summary_info <- function(dataset) {
  
  summary_list <- list()
  return(summary_list)
}
data <- read.csv(
  "../project-data/median-listing-price/City_MedianListingPrice_AllHomes.csv")
get_summary_info(data)
