# load necessary libraries
library(dplyr)
library(stringr)

# load and clean data frames
days_listed_state <-
  read.csv("project-data/days-on-zillow/daysonzillow_public_state.csv",
           stringsAsFactors = FALSE)
names(days_listed_state) <- as.matrix(days_listed_state[1, ])
days_listed_state <- days_listed_state[-2:-1, ]
days_listed_state[["CBSA Title"]] <- NULL
days_listed_state <- subset(days_listed_state,
                            select = -c(StateName, RegionType, SizeRank))
days_listed_state[["RegionName"]] <- tolower(days_listed_state[["RegionName"]])

days_listed_county <-
  read.csv("project-data/days-on-zillow/daysonzillow_public_county.csv",
           stringsAsFactors = FALSE)
united_states <- days_listed_county[1, ]
days_listed_county <- days_listed_county[-1, ]
days_listed_county <- subset(days_listed_county,
                             select = -c(RegionType, CBSA.Title, SizeRank))
days_listed_county[["RegionName"]] <-
  tolower(days_listed_county[["RegionName"]])
