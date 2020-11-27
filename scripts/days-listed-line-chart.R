# load necessary packages
library(stringr)
library(ggplot2)

# load and clean data frames
days_listed_state <- 
      read.csv("../project-data/days-on-zillow/daysonzillow_public_state.csv",
               stringsAsFactors = FALSE)
names(days_listed_state) <- as.matrix(days_listed_state[1, ])
days_listed_state <- days_listed_state[-2:-1, ]
days_listed_state[["CBSA Title"]] = NULL
days_listed_state <- subset(days_listed_state, select = -c(StateName, RegionType, SizeRank))
days_listed_state$RegionName <- tolower(days_listed_state$RegionName)

days_listed_county <- 
      read.csv("../project-data/days-on-zillow/daysonzillow_public_county.csv",
               stringsAsFactors = FALSE)
United_States <- days_listed_county[1, ]
days_listed_county <- days_listed_county[-1, ]
days_listed_county <- subset(days_listed_county, select = -c(RegionType, CBSA.Title, SizeRank))
days_listed_county$RegionName <- tolower(days_listed_county$RegionName)

# function to produce a line graph of days listed on zillow over time
# takes the take of region (county or state) and then a region name as inputs
makes_graph <- function(region_type, region_name, state_code = NULL) {
  region_type <- tolower(region_type)
  region_name <- tolower(region_name)
  if (region_type == "state") {
    df <- days_listed_state
    relevant_data <- df[df$RegionName == region_name, ]
  } else { # region_type == county
    df <- days_listed_county
    state_code <- toupper(state_code)
    relevant_data <- df[df$RegionName == region_name & df$StateName == state_code, ]
  }
  title <- relevant_data[["RegionName"]]
  relevant_data$RegionName <- NULL
  print(title)
  print(relevant_data)
  ggplot(relevant_data, aes(x = colnames(relevant_data), y = relevant_data[1, ])) +
      geom_path()
}

makes_graph("state", "Washington")
