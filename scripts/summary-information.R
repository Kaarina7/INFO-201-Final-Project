library(dplyr)

get_summary_info <- function(dataset) {
  summary_list <- list()
  summary_list$col_num <- length(unique(colnames(dataset)))
  summary_list$ <- 
  return(summary_list)
}
data <- read.csv("C:/Users/rchap/Info201/INFO-201-Final-Project/project-data/median-listing-price/State_MedianListingPrice_AllHomes.csv")
get_summary_info(data)
