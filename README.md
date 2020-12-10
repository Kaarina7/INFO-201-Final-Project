Link to Project:
https://benagilman.shinyapps.io/final-deliverable/






# Project Brainstorm
## Domain of Interest

**Why are we interested in this?**

We are interested in the field of finance/economics because we are business, economics, and computational finance majors. We feel like the field of finance/economics intersects all of our major-related interests.

**Examples of data driven projects related to finance/economics**
- [Example 1:](https://www.kaggle.com/skirmer/fun-with-real-estate-data) This project looks at different factors which influence the market price of a house.
- [Example 2:](https://www.kaggle.com/rohan8594/finance-data-project) This project analyses data related to stock prices starting from the 2008 financial crisis up to 2016.
- [Example 3:](https://github.com/quinamatics/Financial-Data-Analytics/blob/master/Better%20Buy.ipynb) This project takes in data about the financial situations of two different companies and performs analysis to determine which one is better off.

**Questions**
 - How do housing prices change over time and how do they vary by region? We can answer this question by looking at different house prices compared to time, as well as compared to geographic location.
 - How has the wealth inequality between US states changed over time? We can answer this question by looking at the wealth of different US states over a period of time, noticing trends, and comparing them.
 - Which counties/states have the highest proportion of citizens with insurance vs. without? We can answer this by looking at data about insurates rates in different US states/counties, and then finding trends and comparing them.

## Finding Data
**Data Source 1**
- https://data.world/zillow-data/median-list-price
- There are 6 tables in this set, all contained inside /data/zillow-data-median-list-price/
- This data was collected by Zillow, and it consists of averages of all the prices of homes listed on their website. The 6 tables are made up of these averages divided by geographic regions: ZIP code, State, Neighborhood, Metro area, County, and City. Each column represents a month, ranging from January 2010 to September 2017 in every table.
- The number of observations varies by geographic type. ZIP code: 10310 rows, 99 columns; State: 51 rows, 95 columns; Neighborhood: 1790 rows, 99 columns; Metro area: 878 rows, 95 columns; County: 2290 rows, 99 columns; City: 7120 rows, 98 columns.
- This dataset can be used to answer questions about how house prices vary by geographic region, as well as how they've changed over the past ten years. In conjunction with other data about income and rent prices that Zillow makes publicly available, this data could also be used to answer questions about cost of living.

**Data Source 2**
- https://data.world/vikjam/usa-state-inequality
- The data was collected by a professor of Economics and International Business at Sam Houston State University, Mark W. Frank Ph.D. He was able to find the income inequalities from individual tax filings that were released by the Internal Revenue Service. The data represents how each state compares in inequality from 1918-2015.     
- The data set has 7 columns and 5,064 rows
- The data set can answer questions about how each states’ wealth inequality has changed over the years. Also how different states compare to each other.
- The data gathered from these two questions can be compared to other factors about the specific states like the political affiliation of the state during elections.

**Data Source 3**
- https://data.world/dconc/insurance/workspace/file?filename=Insurance+Coverage+-+All+Demographics+By+County.xlsx
- The data in this set represents a combination of "survey data from American Community Survey, administrative records, and Census 2010 data". The Small - Area Health Insurance Estimate program then used statistical models to produce estimates by sex, race, and income group. The part of the dataset we have here shows the raw number of insured and uninsured persons by county.
- The data set has 7 columns and 76,648 rows.
- The data set can answer the question pertaining to the US counties/states with highest proportions of insured citizens. We can group counties together by states to determine this, or look at the data on a county-specific basis. We could also analyze the data in terms of insurance percentages vs time.
