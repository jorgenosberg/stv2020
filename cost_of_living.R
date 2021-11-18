# Preparations ------------------------------------------------------------

rm(list = ls())

setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")

library(pacman)
p_load(rvest, stringr, tidyverse, kableExtra)

# This data is available as an API, but I did not get access to an academic licence when I
# requested one. Since it's just a few tables, I scrape them instead:
# https://www.numbeo.com/common/api.jsp

# First I check to see if web scraping is allowed
p_load(robotstxt)

paths_allowed(
  path = "cost-of-living",
  domain = "https://www.numbeo.com/"
)

# I also double check the instructions included in the robots.txt file to 
# make sure it's fine
get_robotstxt(domain = "https://www.numbeo.com/")

# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2015
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)

# 2016 --------------------------------------------------------------------

# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2016
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)


# 2017 --------------------------------------------------------------------


# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2017
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)




# 2018 --------------------------------------------------------------------



# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2018
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)

# 2019 --------------------------------------------------------------------



# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2019
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)


# 2020 --------------------------------------------------------------------



# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2020
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)


# 2021 --------------------------------------------------------------------



# I save the url as an R object separating the string by year
# By doing this I create code that is 100% reproducible for all the 6 years (2015-2021)
year <- 2021
url <- paste("https://www.numbeo.com/cost-of-living/rankings_by_country.jsp?title=", year, sep = "")
page <- read_html(url, encoding = "UTF-8")

# I check the table numbering on the page
head(html_nodes(page, "table"))

# I extract table number 2
tbl_list <- page %>% 
  html_nodes(css = "table") %>%
  .[2] %>% 
  html_table(fill = TRUE)

names(tbl_list) <- "cost_of_living"

list2env(tbl_list, envir = .GlobalEnv)

# I clean up the names (snake_case)
cost_of_living <- cost_of_living %>% 
  janitor::clean_names()

# I fix the rank column
cost_of_living <- cost_of_living %>% 
  mutate("rank" = 1:nrow(cost_of_living))

# I add a year column
cost_of_living$year <- as.factor(year)

# I remove the additional "_index" suffix using gsub()
colnames(cost_of_living) <- gsub("_index", "", colnames(cost_of_living))

# Finally, I reorder the columns
cost_of_living <- cost_of_living[c(1:2, 9, 3:8)]

# I rename the data frame to include the year
assign(paste("cost_of_living_", year, sep = ""), cost_of_living)

# I inspect the results
glimpse(get(paste0("cost_of_living_", year, sep ="")))

# I clean up and prepare for later scraping
rm(tbl_list, page, url, year, cost_of_living)


# Joining the data frames --------------------------------------------------

library(pacman)
p_load(tidyverse, hrbrthemes)

cost_of_living <- rbind(cost_of_living_2021, cost_of_living_2020, 
                        cost_of_living_2019, cost_of_living_2018,
                        cost_of_living_2017, cost_of_living_2016,
                        cost_of_living_2015)

rm(cost_of_living_2021, cost_of_living_2020, 
   cost_of_living_2019, cost_of_living_2018,
   cost_of_living_2017, cost_of_living_2016,
   cost_of_living_2015)

# I create a quick plot to check that everything works
cost_of_living %>% 
  filter(country == "Norway") %>% 
  ggplot(aes(x = year, group = 1)) +
  geom_line(aes(y = rent)) +
  theme_bw()

saveRDS(cost_of_living, file = "cost_of_living")

  
