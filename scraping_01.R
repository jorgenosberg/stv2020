### ### ### ### ### ### ### ### ### ###
###  STV2020 - Static Web Scraping  ###
### ### ### ### ### ### ### ### ### ###

# Preparations ------------------------------------------------------------

# Clearing the global environment
rm(list = ls())

# Setting the Working Directory
setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")

# Loading packages
library(pacman)
p_load(rvest, jsonlite, lubridate, stringr,
       RSelenium, Rcrawler, binman)


# Scraping the website ----------------------------------------------------

# 1st try = is a dynamic website
# Another nice visualization of beer prices with some interesting info 
# is included in a table over on https://www.expensivity.com/beer-around-the-world/.
# However, since the table is an iFrame, an embedded HTML chunk, scraping the information
# directly from the main page is not as easy.

# I extract the source URL from the code: https://embed.neomam.com/tables/world-beer-index/
url <- "https://embed.neomam.com/tables/world-beer-index/"
page <- read_html(url, encoding = "UTF-8")

table <- page %>% 
  html_nodes(css = "#__layout > div > main > div.view > div") %>% 
  html_text(trim = TRUE)

header <- page %>% 
  html_nodes(xpath = "/html/body/div/div[2]/div/main/div[2]/div/div/table/thead/tr") %>% 
  html_text(trim = TRUE)

head(table)


