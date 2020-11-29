# load necessary packages
library(stringr)
library(dplyr)
library(ggplot2)

# load and clean data frames
days_listed_state <-
      read.csv("../project-data/days-on-zillow/daysonzillow_public_state.csv",
               stringsAsFactors = FALSE)
names(days_listed_state) <- as.matrix(days_listed_state[1, ])
days_listed_state <- days_listed_state[-2:-1, ]
days_listed_state[["CBSA Title"]] <- NULL
days_listed_state <- subset(days_listed_state,
                            select = -c(StateName, RegionType, SizeRank))
days_listed_state$RegionName <- tolower(days_listed_state$RegionName)

days_listed_county <-
      read.csv("../project-data/days-on-zillow/daysonzillow_public_county.csv",
               stringsAsFactors = FALSE)
united_states <- days_listed_county[1, ]
days_listed_county <- days_listed_county[-1, ]
days_listed_county <- subset(days_listed_county,
                             select = -c(RegionType, CBSA.Title, SizeRank))
days_listed_county$RegionName <- tolower(days_listed_county$RegionName)

# function to produce a line graph of days listed on zillow over time
# takes the take of region (county or state) and then a region name as inputs
line_graph <- function(region_type, region_name, state_code = NULL) {
  # deal with user input and use it to select the proper dataset
  region_type <- tolower(region_type)
  region_name <- tolower(region_name)
  if (region_type == "state") {
    state_code <- NULL
    df <- days_listed_state
    relevant_data <- df[df$RegionName == region_name, ]
  } else { # region_type is equal to county
    df <- days_listed_county
    state_code <- toupper(state_code)
    df <- filter(df, StateName == state_code)
    relevant_data <- df[df$RegionName == region_name, ]
  }
  # clean the data to make it graph ready
  relevant_data <- as.data.frame(t(as.matrix(relevant_data)))
  names(relevant_data) <- as.matrix(relevant_data[1, ])
  relevant_data <- tibble::rownames_to_column(relevant_data, "Dates")
  relevant_data <- relevant_data[-1, ]
  if (region_type == "county") {
    relevant_data <- relevant_data[-1, ]
  }
  relevant_data[[region_name]] <- as.numeric(relevant_data[[region_name]])

  # format labels for use in graph
  season_labels <- paste(rep(c("Winter\n", "Spring\n", "Summer\n", "Fall\n"),
                   each = 3), rep(2010:2017, each = 12))
  for (n in 1:96) {
    if (n %% 3 != 1) {
      season_labels[n] <- ""
    }
  }

  # make the graph
  ggplot(relevant_data, aes(x = Dates, y = .data[[region_name]], group = 1)) +
      geom_line() +
      labs(title = paste0("Average Days a Home is Listed on Zillow in ",
        str_to_title(region_name), ifelse(is.null(state_code), " State",
        paste(" County,", toupper(state_code)))), y = "Number of Days") +
      scale_x_discrete(labels = season_labels) + geom_point() +
      theme(axis.text.x = element_text(angle = 90)) + geom_line(color = "blue")
}
