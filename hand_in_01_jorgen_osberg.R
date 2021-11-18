### ### ### ### ### ### ### ### ### ### ###
###  STV2020 - Gallup World Poll data   ###
###  First hand-in - Cleaning the data  ###
### ### ### ### ### ### ### ### ### ### ###

# Preparations ------------------------------------------------------------

rm(list = ls())

setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")

# Loading packages --------------------------------------------------------

# Loading my preferred package manager
library(pacman) # install.packages("pacman")

# The Tidyverse
p_load(tidyverse, haven, readxl) # specify install = TRUE, update = TRUE if needed

# The tidyverse includes a number of packages, i.a.:
# ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, 
# forcats, haven, httr, readxl, rvest, jsonlite, xml2
# lubridate, hms, blob, magrittr

# Not all packages are loaded automatically, some may need
# to be called by library()

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


# Explanation -------------------------------------------------------------

# I wanted to use the World Happiness Report for my project, and
# have examine the different sources they list to see what data
# I would need to reproduce their results and analyze the data. 
# Since they base their report on the Gallup World Poll
# annual data, I contacted Gallup directly to see if they had any
# data available for an academic student project (making it clear
# that the project was not intended for publication). They did - after
# a quick chat with Jerry Hansen over Zoom, I was able to obtain full 
# world poll data for Japan, New Jersey, Alabama and Egypt as well as
# an aggregate .csv file.

# I will import the datasets below.

# Japan -------------------------------------------------------------------

# Loading the first dataset from Gallup
japan <- read_sav("data/Japan 2010_2011 Gallup World Poll.sav")

head(japan)
names(japan)

# I use View() to examine the dataset further
View(japan)

# I will select the most interesting variables using the correct codes
# from the Gallup code book I have been sent.

# japan <- japan %>% 
  # select(countrynew, INDEX_LE, WP16, WP18, WP30, WP31, etc...)

# WP16 and WP18 make up the two main life evaluation questions, 
# but other variables are equally relevant for the analysis.

# I will do the same for the other countries/states.


# Egypt -------------------------------------------------------------------

egypt <- read_sav("data/Egypt 2009_2010 Gallup World Poll.sav")

head(egypt)
names(egypt)

# New Jersey --------------------------------------------------------------

new_jersey <- read_sav("data/New Jersey 2011 Gallup Daily Poll.sav")

head(new_jersey)
names(new_jersey)

# Alabama -----------------------------------------------------------------

alabama <- read_sav("data/Alabama 2010 Gallup Daily Poll.sav")

head(alabama)
names(alabama)

# Importing aggregate data ----------------------------------------------------------

# I have received an export from the Gallup Analytics data browser tool.
# This exported file contains data on the "Life Evaluation Index," as well
# as scores from the "life today" and "life in 5 years" questions that 
# the Gallup World Poll uses. The file is an Excel spreadsheet and will
# thus need some work to be imported correctly.

# I could simply export each sheet in Microsoft Excel and save them 
# individually as .csv files. This, however, isn't really any faster
# than just extracting the information I want by using the readxl package
# and a couple of arguments to specify my criteria.

# I use sheet to define which Excel sheet to import and skip to tell R 
# to start the dataset from the first line of the actual data. Readxl's 
# default setting is to use the first line as column names.

# Importing the "Life Evaluation Index"-sheet
life_eval <- read_excel("data/GallupAnalytics_Export_20210312_101948.xlsx", 
                        sheet = "Life Evaluation Index", skip = 7)

head(life_eval)
names(life_eval)
str(life_eval)

# Importing the "Life Today"-sheet
life_today <- read_excel("data/GallupAnalytics_Export_20210312_101948.xlsx", 
                         sheet = "Life Today", skip = 6)

head(life_today)
names(life_today)
str(life_today)

# Importing the "Life in Five years"-sheet
life_in_five <- read_excel("data/GallupAnalytics_Export_20210312_101948.xlsx", 
                           sheet = "Life in Five Years  ", skip = 6)

head(life_in_five)
names(life_in_five)
str(life_in_five)

# Cleaning the aggregate data ---------------------------------------------

# Subsetting the dataframes to drop unnecessary columns

# Life Evaluation Index summary
life_eval <- life_eval %>% 
  select("Geography", "Time", "Thriving", "Struggling", "Suffering", "N Size")

# Life today
life_today <- life_today %>% 
  select("Geography", "Time", "Value", "N Size")

# Life in five years
life_in_five <- life_in_five %>% 
  select("Geography", "Time", "Value", "N Size")

# World Happiness Report summary data -----------------------------------------

# Import .csv summaries by year
# Compiled .csv files downloaded through Kaggle

# 2015
whr_2015 <- read_csv("data/2015.csv")

head(whr_2015)
names(whr_2015)

# 2016
whr_2016 <- read_csv("data/2016.csv")

head(whr_2016)
names(whr_2016)

# 2017
whr_2017 <- read_csv("data/2017.csv")

head(whr_2017)
names(whr_2017)

# 2018
whr_2018 <- read_csv("data/2018.csv")

head(whr_2018)
names(whr_2018)

# 2019
whr_2019 <- read_csv("data/2019.csv")

head(whr_2019)
names(whr_2019)

# 2020
whr_2020 <- read_csv("data/2020.csv")

head(whr_2020)
names(whr_2020)

# 2021
whr_2021 <- read_csv("data/2021.csv")

head(whr_2021)
names(whr_2021)


