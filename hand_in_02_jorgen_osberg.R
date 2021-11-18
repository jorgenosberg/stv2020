### ### ### ### ### ### ### ### ### ### ### ###
###     STV2020 - Gallup World Poll data    ###
###      Second hand-in - Web scraping      ###
### ### ### ### ### ### ### ### ### ### ### ###

# Note:

# This is the second hand-in for the STV2020 course, but is only
# one of many scripts I have used and am using for my semester
# assignment. My intention is to show some web scraping and 
# data cleaning using rvest, stringr, the tidyverse and base R. 

# Preparations ------------------------------------------------------------

rm(list = ls())

setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")

# Loading packages --------------------------------------------------------

# Loading my preferred package manager
library(pacman) # install.packages("pacman")

# The Tidyverse
p_load(tidyverse, haven, readxl) # specify install = TRUE, update = TRUE if needed

# A few packages for using APIs
p_load(httr, jsonlite, rtweet, eurostat)

# A few packages for static web scraping
p_load(rvest, jsonlite, stringr, lubridate)

# A few packages for web scraping
p_load(rvest, stringr, RSelenium, Rcrawler, binman)

# A few packages for tables
p_load(knitr, kableExtra, formattable, reactable, tables)

# A few packages for data visualization
p_load(ggplot2, ggthemes, ggforce, Esquisse, gganimate,
       ggpubr, patchwork, ggmap, GGally)

# A few packages for GIS manipulation
p_load(sf, raster, tmap, mapview, rmapshaper)


# Scraping a static website -----------------------------------------------

# When talking about happiness and being satisfied with your own
# situation, social activities and networking seem to be important
# factors that contribute towards increased happiness. I want to 
# examine whether or not the average price of beer (beer) can affect
# this variable. The general assumption is that personal finances
# define how much we go out to eat and drink with friends, i.e. there
# might be a correlation between the price of beer and the level of happiness.

# Finder.com offers a pretty extensive list of average beer prices in GBP.
# The data is from 177 countries and territories. 

# I load the Finder.com-URL as an R object
url <- "https://www.finder.com/uk/international-beer-price-map"
page <- read_html(url, encoding = "UTF-8")

# I find the necessary CSS selector path to extract the correct information
# from the second table on the page. The CSS selector gadget doesn't find
# the correct path, so I copy it from the Chrome inspector tool. I add
# html_children() to access the children node within the selected section.
beer_prices <- page %>% 
  html_nodes(css = "#content > div.wordpressEditorContent > 
             div.content.has-padding-top-small > div:nth-child(6) > table > tbody") %>% 
  html_children() %>% 
  html_text(trim = TRUE)

beer_prices <- page %>%
  rvest::html_element(css = "table") %>%
  rvest::html_table()

# I control that the data has been scraped correctly
beer_prices

# The data has been scraped as 1 single vector (character string), 
# and needs some cleaning. First I create a data frame.
beer_prices <- as.data.frame(beer_prices)

# Then I use the stringr() package to separate the string into 4 columns.
# str_split_fixed(beer_prices$beer_prices, "\n                            ", 4)

# I use head() to control the results
# head(beer_prices)

# I still need to create clear columns - I choose to opt for the tidyr()
# solution instead, using separate() to split the string.

# I use the tidyr() package to create 4 distinct columns right away
beer_prices <- beer_prices %>% 
  separate(beer_prices, c("country", "city", "price_2020", "price_2021"), "\n                            ")

head(beer_prices)

# To facilitate analyses I want to use the "country" column
# as the rownames. I use the tidyverse() package and the 
# function column_to_rownames()
beer_prices1 <- beer_prices %>% 
  remove_rownames() %>% 
  column_to_rownames(var = "country")

# Apparently there are duplicates in the data.frame. This is because
# 1 name, the Virgin Islands, is represented with two cities.
# I control the number of unique values on the country variable.
length(unique(beer_prices$country)) # 177 observations, 176 unique values

# I check which rows are duplicated
beer_prices[duplicated(beer_prices$country), ]
beer_prices[duplicated(beer_prices$country, fromLast = TRUE), ]

# I can tell that rows 54 and 136 contain the two capitals of the 
# British AND American Virgin Islands. These are two separate 
# jurisdictions, and should not be omitted.
beer_prices[54, 1] <- "Virgin Islands (GB)"
beer_prices[136, 1] <- "Virgin Islands (US)"

# I check to see if it worked
beer_prices[54, 1]
beer_prices[136, 1]

# Now I can run the column_to_rownames() code.
beer_prices <- beer_prices %>% 
  remove_rownames() %>% 
  column_to_rownames(var = "country")

# Adding two variables for $ USD instead of £ GBP
# The exchange rate is currently 1£ = $US 1,3903274
# I use the dplyr() package and its handy mutate() function
beer_prices <- beer_prices %>% 
  mutate(usd_2020 = price_2020 * 1.3903274)

# I realized that the price variables include the £ symbol
# and are classified as characters. This needs to be fixed before
# I can compute the new variables.

# I create a copy of the data frame to manipulate the values
copy <- beer_prices

copy <- copy %>% 
  rename(gbp_2020 = price_2020,
         gbp_2021 = price_2021)

# I control the results
head(copy)
View(copy)

# I use str_sub() to remove the first character from each variable
copy$gbp_2020 <- str_sub(copy$gbp_2020, 2)

head(copy$gbp_2020)

copy$gbp_2021 <- str_sub(copy$gbp_2021, 2)

head(copy$gbp_2021)

# I turn the variables into numeric
copy$gbp_2020 <- as.numeric(copy$gbp_2020)
copy$gbp_2021 <- as.numeric(copy$gbp_2021)

# I run the mutate() code now that I have clean numerics
copy <- copy %>% 
  mutate(usd_2020 = gbp_2020 * 1.3903274) %>% 
  mutate(usd_2021 = gbp_2021 * 1.3903274)

head(copy)

# I round the USD values to 2 decimal places
copy$usd_2020 <- format(round(copy$usd_2020, 2), nsmall = 2)

copy$usd_2021 <- format(round(copy$usd_2021, 2), nsmall = 2)

head(copy)

# I overwrite the original DF with the changes
beer_prices <- copy

View(beer_prices)


# Visualizing the results -------------------------------------------------

# I show the some of the results in a simple Kable() table
head(beer_prices) %>% 
  kable(col.names = c("Country", "City", "£ 2020", "£ 2021", "$US 2020", "$US 2021")) %>% 
  column_spec(1, bold = TRUE) %>% 
  kable_styling(font_size = 20) %>% 
  kable_material("hover", "striped")

# I didn't like that the countries are the rownames, so I simply redid
# that part of my previous code.

# Here's a full working run-through of all the code without comments
# and without the "copy" I used for testing.
url <- "https://www.finder.com/uk/international-beer-price-map"
page <- read_html(url, encoding = "UTF-8")

beer_prices <- page %>% 
  html_nodes(css = "#content > div.wordpressEditorContent > 
             div.content.has-padding-top-small > div:nth-child(6) > table > tbody") %>% 
  html_children() %>% 
  html_text(trim = TRUE)

beer_prices <- as.data.frame(beer_prices)

beer_prices <- beer_prices %>% 
  separate(beer_prices, c("country", "city", "price_2020", "price_2021"), 
           "\n                            ")

beer_prices[54, 1] <- "Virgin Islands (GB)"
beer_prices[136, 1] <- "Virgin Islands (US)"

beer_prices <- beer_prices %>% 
  rename(gbp_2020 = price_2020,
         gbp_2021 = price_2021)

beer_prices$gbp_2020 <- str_sub(beer_prices$gbp_2020, 2)
beer_prices$gbp_2021 <- str_sub(beer_prices$gbp_2021, 2)

beer_prices$gbp_2020 <- as.numeric(beer_prices$gbp_2020)
beer_prices$gbp_2021 <- as.numeric(beer_prices$gbp_2021)

beer_prices <- beer_prices %>% 
  mutate(usd_2020 = gbp_2020 * 1.3903274) %>% 
  mutate(usd_2021 = gbp_2021 * 1.3903274)

beer_prices$usd_2020 <- format(round(beer_prices$usd_2020, 2), nsmall = 2)
beer_prices$usd_2021 <- format(round(beer_prices$usd_2021, 2), nsmall = 2)

head(beer_prices) %>% 
  kable(col.names = c("Country", "City", "£ 2020", "£ 2021", "$US 2020", "$US 2021")) %>% 
  column_spec(1, bold = TRUE) %>% 
  kable_styling(font_size = 20) %>% 
  kable_material("hover", "striped")



convert_currency <- function(from, to, dt=Sys.Date()) {
  require(quantmod)
  obj.names <- getFX(paste0(from, "/", to), from=dt, to=dt)
  result <- numeric(length(obj.names))
  names(result) <- obj.names
  for (obj.name in obj.names) {
    result[obj.name] <- as.numeric(get(obj.name))[1]
    # Clean up    
    rm(obj.name)
  }
  return(result)
}

convert_currency(from = "GBP", to = "USD")

convert_currency <- function(from, to, dt=Sys.Date()) {
  require(quantmod)
  exchange_rates <- getFX(paste0(from, "/", to), from=dt, to=dt)
  return(result)
}

convert_currency(from = "GBP", to = "USD")



# Ny funksjon  ------------------------------------------------------------



getFX(
  "GBP/USD",
  from = Sys.Date()-1,
  to = Sys.Date()
)



exchange_rates <- function(from, to, dt=Sys.Date()) {
  require(quantmod)
  getFX(paste0(from, "/", to), from=dt, to=dt)
  result <- as.numeric(coredata(get(paste0(from, to))))
  {
    rm(get(paste0(from, to)))
  }
  return(result)
}

exchange_rates(from = "GBP", to = "USD")

from <- "GBP"
to <- "USD"

result <- as.numeric(get(paste0(from, to)))
