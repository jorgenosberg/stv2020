### ### ### ### ### ### ### ### ### ###
### STV2020 - Scraping pint prices  ###
### ### ### ### ### ### ### ### ### ###


# Preparations ------------------------------------------------------------

rm(list = ls())

setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")

# Loading my preferred package manager
# install.packages("pacman")
library(pacman)

# General packages
p_load(rebus, knitr, rvest, kableExtra, 
       readr, summarytools, haven, ggplot2, 
       lubridate, stringr, tidyverse)

  # Add install = TRUE, update = TRUE if
  # packages need to be installed/updated

# Packages for dynamic web scraping
p_load(tidyverse, httr, rvest, RSelenium, stringr)

# Dynamic scraping ----------------------------------------------------------------

url <- "https://www.finder.com.au/international-pint-price-map"
page <- read_html(url)

rD <- rsDriver(browser = "chrome", port = 4444L, chromever = "latest")
remDr <- rD[["client"]]

country <- page %>% 
  html_nodes(class= "luna-table__body")

dat %>% 
  separate(col = region, into = c("region_code", "region_name"), sep = "", extra = )




# Static scraping ---------------------------------------------------------

url <- "https://www.cnbc.com/2019/02/01/how-much-a-case-of-beer-costs-in-every-us-state.html"
page <- read_html(url)

states <- page %>% 
  html_nodes(css = ".ArticleBody-styles-makeit-subtitle--LnHeO") %>% 
  html_text()

head(states)

prices <- page %>% 
  html_nodes(css = ".ArticleBody-styles-makeit-subtitle--LnHeO+ .group p:nth-child(1)") %>% 
  html_text()

head(prices)

prices %>% 
  str_split(": ")

head(prices)
