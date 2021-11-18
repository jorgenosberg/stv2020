### ### ### ### ### ### ### ### ### ### ### ###
###     STV2020 - Gallup World Poll data    ###
###       Third hand-in - Spatial data      ###
### ### ### ### ### ### ### ### ### ### ### ###

# Note:

# This is the third hand-in for the STV2020 course, but is only
# one of several scripts I have used and am using for my semester
# assignment. In this one, I focus on more data cleaning and
# visualizing some of the data spatially.

# Preparations ------------------------------------------------------------

rm(list = ls())

setwd("~/OneDrive/Universitetet i Oslo/Statsvitenskap - UiO/6. semester/STV2020")


# Importing data ----------------------------------------------------------

# Loading packages
library(pacman)
p_load(haven, readxl, tidyverse)

# Importing all the Kaggle aggregate files

whr_2015 <- read_csv("data/2015.csv")
whr_2016 <- read_csv("data/2016.csv")
whr_2017 <- read_csv("data/2017.csv")
whr_2018 <- read_csv("data/2018.csv")
whr_2019 <- read_csv("data/2019.csv")
whr_2020 <- read_csv("data/2020.csv")
whr_2021 <- read_csv("data/2021.csv")


# Recoding and renaming variables -----------------------------------------

# I create year variables for each data frame
# and reorder the columns
whr_2015$Year <- "2015" 
whr_2015 <- whr_2015[c(13, 1, 2:12)]

whr_2016$Year <- "2016" 
whr_2016 <- whr_2016[c(14, 1, 2:13)]

whr_2017$Year <- "2017" 
whr_2017 <- whr_2017[c(13, 1, 2:12)]

whr_2018$Year <- "2018" 
whr_2018 <- whr_2018[c(10, 2, 1, 3:9)]

whr_2019$Year <- "2019" 
whr_2019 <- whr_2019[c(10, 2, 1, 3:9)]

whr_2020$Year <- "2020" 
whr_2020 <- whr_2020[c(21, 1, 2:20)]

whr_2021$Year <- "2021" 
whr_2021 <- whr_2021[c(21, 1, 2:20)]

# I now want to combine the datasets
# First I need to rename variables that contain the same
# results, but that are named differently

names(whr_2015)
names(whr_2016)
names(whr_2017)
names(whr_2018)
names(whr_2019)
names(whr_2020)
names(whr_2021)

# I simplify the variable names
# p_install(janitor)
whr_2015 <- whr_2015 %>% 
  janitor::clean_names()

whr_2016 <- whr_2016 %>% 
  janitor::clean_names()

whr_2017 <- whr_2017 %>% 
  janitor::clean_names()

whr_2018 <- whr_2018 %>% 
  janitor::clean_names()

whr_2019 <- whr_2019 %>% 
  janitor::clean_names()

whr_2020 <- whr_2020 %>% 
  janitor::clean_names()

whr_2021 <- whr_2021 %>% 
  janitor::clean_names()

names(whr_2015)
names(whr_2016)
names(whr_2017)
names(whr_2018)
names(whr_2019)
names(whr_2020)
names(whr_2021)

# I use dplyr to drop a few columns
whr_2015 <- whr_2015 %>% 
  dplyr::select(-c("standard_error",
            "region",
            "dystopia_residual"))

whr_2015 <- whr_2015 %>% 
  rename("social_support" = "family",
         "government_corruption" = "trust_government_corruption",
         "life_expectancy" = "health_life_expectancy",
         "gdp_per_capita" = "economy_gdp_per_capita")

# I then use dplyr to "unselect" multiple columns
whr_2016 <- whr_2016 %>% 
  dplyr::select(-c("lower_confidence_interval",
            "upper_confidence_interval",
            "dystopia_residual",
            "region"))

whr_2016 <- whr_2016 %>% 
  rename("social_support" = "family",
         "government_corruption" = "trust_government_corruption",
         "life_expectancy" = "health_life_expectancy",
         "gdp_per_capita" = "economy_gdp_per_capita")

# I use dplyr to rename columns with correctly formatted names
whr_2017 <- whr_2017 %>% 
  dplyr::select(-c("whisker_low", 
            "whisker_high",
            "dystopia_residual")) 

whr_2017 <- whr_2017 %>% 
  rename(
    "gdp_per_capita" = "economy_gdp_per_capita",
    "social_support" = "family",
    "life_expectancy" = "health_life_expectancy",
    "government_corruption" = "trust_government_corruption"
  )
  
# I reorder the columns in whr_2017
whr_2017 <- whr_2017[c(1:8, 10, 9)]

# I rename columns for 2018
whr_2018 <- whr_2018 %>% 
  rename(
    "country" = "country_or_region",
    "happiness_rank" = "overall_rank",
    "happiness_score" = "score",
    "life_expectancy" = "healthy_life_expectancy",
    "freedom" = "freedom_to_make_life_choices",
    "government_corruption" = "perceptions_of_corruption"
  )

# I reorder the last two variables
whr_2018 <- whr_2018[c(1:8, 10, 9)]

# I repeat the renaming for 2019
whr_2019 <- whr_2019 %>% 
  rename(
    "country" = "country_or_region",
    "happiness_rank" = "overall_rank",
    "happiness_score" = "score",
    "life_expectancy" = "healthy_life_expectancy",
    "freedom" = "freedom_to_make_life_choices",
    "government_corruption" = "perceptions_of_corruption"
  )

# I reorder the last variables
whr_2019 <- whr_2019[c(1:8, 10, 9)]

# I remove variables from the 2020 data set
whr_2020 <- whr_2020 %>% 
  dplyr::select(
    "year", "country_name",
    "ladder_score", "explained_by_log_gdp_per_capita",
    "explained_by_social_support", "explained_by_healthy_life_expectancy", 
    "explained_by_freedom_to_make_life_choices", "explained_by_generosity", 
    "explained_by_perceptions_of_corruption", "explained_by_generosity"
         )

whr_2020 <- whr_2020 %>% 
  rename(
    "country" = "country_name",
    "happiness_score" = "ladder_score",
    "gdp_per_capita" = "explained_by_log_gdp_per_capita",
    "social_support" = "explained_by_social_support",
    "life_expectancy" = "explained_by_healthy_life_expectancy",
    "freedom" = "explained_by_freedom_to_make_life_choices",
    "government_corruption" = "explained_by_perceptions_of_corruption",
    "generosity" = "explained_by_generosity"
  )

names(whr_2020)

# Recoding "Happiness Rank" with mutate() ---------------------------------

# I noticed that whr_2020 is missing the "Happiness Rank" column
# I create it using dplyrs mutate() function
whr_2020 <- whr_2020 %>% 
  arrange(desc("happiness_score")) %>% 
  mutate("happiness_rank" = 1:nrow(whr_2020))

whr_2020$happiness_rank

nrow(whr_2020)

# I reorder the variables
whr_2020 <- whr_2020[c(1, 2, 10, 3:7, 9, 8)]

# I drop the extra variables for 2021
whr_2021 <- whr_2021 %>% 
  dplyr::select(
    "year", "country_name",
    "ladder_score", "explained_by_log_gdp_per_capita",
    "explained_by_social_support", "explained_by_healthy_life_expectancy", 
    "explained_by_freedom_to_make_life_choices", "explained_by_generosity", 
    "explained_by_perceptions_of_corruption", "explained_by_generosity"
  )

whr_2021 <- whr_2021 %>% 
  rename(
    "country" = "country_name",
    "happiness_score" = "ladder_score",
    "gdp_per_capita" = "explained_by_log_gdp_per_capita",
    "social_support" = "explained_by_social_support",
    "life_expectancy" = "explained_by_healthy_life_expectancy",
    "freedom" = "explained_by_freedom_to_make_life_choices",
    "government_corruption" = "explained_by_perceptions_of_corruption",
    "generosity" = "explained_by_generosity"
  )

# whr_2021 is also missing the "Happiness Rank". I perform the 
# same calculation as I did for 2020
whr_2021 <- whr_2021 %>% 
  arrange(desc("happiness_score")) %>% 
  mutate("happiness_rank" = 1:nrow(whr_2021))

whr_2021$happiness_rank

nrow(whr_2021)

# I reorder the columns again
whr_2021 <- whr_2021[c(1, 2, 10, 3:7, 9, 8)]

# Combining the data sets --------------------------------------------------

# I have a look at the completed data sets
glimpse(whr_2015)
glimpse(whr_2016)
glimpse(whr_2017)
glimpse(whr_2018)
glimpse(whr_2019)
glimpse(whr_2020)
glimpse(whr_2021)

# For some reason, whr_2018$government_corruption is a character.
# I change this using as.numeric()
whr_2018$government_corruption <- as.numeric(whr_2018$government_corruption)

# I can now use the _join function from dplyr to
# merge the data sets
whr_total <- full_join(whr_2015, whr_2016)
whr_total <- full_join(whr_total, whr_2017)
whr_total <- full_join(whr_total, whr_2018)
whr_total <- full_join(whr_total, whr_2019)
whr_total <- full_join(whr_total, whr_2020)
whr_total <- full_join(whr_total, whr_2021)

head(whr_total)

glimpse(whr_total) 

# View(whr_total) 



# Creating a world map ---------------------------------------------------

# Credit where credit is due: I am using a few tips and tricks from this
# blog post: https://r-spatial.org/r/2018/10/25/ggplot2-sf.html.
# The {rnaturalearth} package has been especially helpful

library(pacman)
p_load(sf, raster, tmap, mapview, rmapshaper, 
       ggmap, cowplot, ggplot2, ggrepel, ggspatial, 
       rnaturalearth, rnaturalearthdata, BiocManager, 
       rnaturalearthhires, lwgeom, tidyverse)

# library(devtools)
# install_github("ropensci/rnaturalearthhires")

# Creating a mappable dataset
whr_map <- whr_total

# I create a world map data set using {rnaturalearth}
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf")
class(world)

glimpse(world)

names(world)

# I select the most important variables

world <- world %>% 
  select("sovereignt", "admin", "sov_a3", "adm0_a3",
         "name", "continent", "geometry", "region_wb")

# I rename the variables, especially the "country" key
# for easy merging
world <- world %>% 
  rename("country" = "sovereignt",
         "region" = "region_wb",
         "country_code" = "sov_a3",
         "territory_code" = "adm0_a3",
         "territory" = "admin")

# I create a simple test map to visualize the data
# ggplot(data = world, aes(geometry = geometry)) +
#   geom_sf(fill = "antiquewhite") +
#   theme(panel.background = element_rect(fill = "aliceblue"))

# I zoom in on Europe to test plot viewing
# ggplot(data = world) + 
#   geom_sf(fill = "antiquewhite") +
#   coord_sf(xlim = c(-20, 45), ylim = c(30, 73), expand = FALSE) +
#   theme(panel.background = element_rect(fill = "aliceblue"))

# I want to create a data set with polygon data by joining
# whr_map and world together. Unique country names seem like 
# a good key, but first I need to know if they're all 
# written and spelled the same in both data sets.

# I check the number of unique values in bot data sets
length(unique(world$country))
length(unique(whr_map$country))

# I return the values to inspect
unique(whr_map$country)
unique(world$country)

# I use dplyrs anti_join() function to return all
# values from whr_map that don't exist in world and vice versa
# View(anti_join(whr_map, world, by = "country"))
# View(anti_join(world, whr_map, by = "country"))

# I rename the values with the wrong names in whr_map
whr_map$country[whr_map$country == "Hong Kong S.A.R. of China"] <- "Hong Kong"
whr_map$country[whr_map$country == "Congo (Kinshasa)"] <- "DR Congo"
whr_map$country[whr_map$country == "Congo (Brazzaville)"] <- "Republic of the Congo"
whr_map$country[whr_map$country == "United States"] <- "United States of America"
whr_map$country[whr_map$country == "Somaliland region"] <- "Somaliland"
whr_map$country[whr_map$country == "Somaliland Region"] <- "Somaliland"
whr_map$country[whr_map$country == "Hong Kong S.A.R., China"] <- "Hong Kong"
whr_map$country[whr_map$country == "Palestinian Territories"] <- "Palestine"
whr_map$country[whr_map$country == "Taiwan Province of China"] <- "Taiwan"
whr_map$country[whr_map$country == "North Cyprus"] <- "Northern Cyprus"
whr_map$country[whr_map$country == "Trinidad & Tobago"] <- "Trinidad and Tobago"

# View(anti_join(whr_map, world, by = "country"))
# View(anti_join(world, whr_map, by = "country"))

# I rename some variables in world
world$country[world$country == "Republic of Congo"] <- "Republic of the Congo"
world$country[world$country == "Democratic Republic of the Congo"] <- "DR Congo"
world$country[world$country == "Republic of Serbia"] <- "Serbia"
world$country[world$country == "United Republic of Tanzania"] <- "Tanzania"
world$country[world$territory == "Palestine"] <- "Palestine"
world$county_code[world$territory == "Palestine"] <- "PSX"

# View(anti_join(whr_map, world, by = "country"))
# View(anti_join(world, whr_map, by = "country"))

# I use right_join to only retrieve matches on sovereign states
whr_map <- right_join(whr_map, world, by = "country")


# Visualizing the WHR data ------------------------------------------------

library(pacman)
p_load(ggplot2, ggspatial, ggthemes)

# I start visualizing the data using ggplot() and geom_sf()
happiness_world <- ggplot(data = whr_map, aes(geometry = geometry)) +
  geom_sf(aes(fill = happiness_score)) +
  scale_fill_distiller(palette = "YlOrBr") +
  theme_classic() +
  theme(panel.background = element_rect(fill = "aliceblue"))

# I add labels and a title
happiness_world <- happiness_world +
  xlab("Longitude") + 
  ylab("Latitude") +
  labs(fill = "Happiness score") +
  xlab("Longitude") + ylab("Latitude") +
  labs(fill = "Happiness score") +
  ggtitle("World Happiness Report 2015-2021",
          subtitle = "Calculated happiness score on the Cantril ladder") +
  theme(panel.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5))


# I move the legend inside the map
happiness_world <- happiness_world +
  theme(legend.position = c(.015, .4),
        legend.justification = c("left", "top"),
        legend.box.just = "left",
        legend.box.background = element_rect(color=gray(.15), fill="white", size=.5),
        legend.margin = margin(6, 6, 6, 6),
        legend.title = element_text(face = "bold")
  )

# I add a "North arrow" and a map scale bar from the ggspatial package
happiness_world <- happiness_world +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl",
                         height = unit(2.5, "cm"),
                         width = unit(2.5, "cm"),
                         pad_x = unit(1, "cm"), 
                         pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering)










# I move the legend inside the map
ggplot(data = whr_map, aes(geometry = geometry)) +
  geom_sf(aes(fill = happiness_score)) +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl",
                         height = unit(2.5, "cm"),
                         width = unit(2.5, "cm"),
                         pad_x = unit(1, "cm"), 
                         pad_y = unit(1, "cm"),
                         style = north_arrow_fancy_orienteering) +
  theme_minimal() +
  scale_fill_distiller(palette = "YlOrBr") +
  xlab("Longitude") + ylab("Latitude") +
  labs(fill = "Happiness score") +
  ggtitle("World Happiness Report 2015-2021", 
          subtitle = "Calculated happiness score on the Cantril ladder") +
  theme(panel.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5),
        legend.position = c(.015, .4),
        legend.justification = c("left", "top"),
        legend.box.just = "left",
        legend.box.background = element_rect(color=gray(.15), fill="white", size=.5),
        legend.margin = margin(6, 6, 6, 6),
        legend.title = element_text(face = "bold")
  )

# I Zoom in on Europe by entering coordinates around the continent 

ggplot(data = whr_map, aes(geometry = geometry)) +
  geom_sf(aes(fill = happiness_score)) +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl",
                         pad_x = unit(0.3, "cm"), pad_y = unit(0.5, "cm"),
                         style = north_arrow_fancy_orienteering) +
  coord_sf(xlim = c(-20, 45), ylim = c(30, 73), expand = FALSE) +
  theme_classic() +
  scale_fill_distiller(palette = "YlOrBr") +
  xlab("Longitude") + ylab("Latitude") +
  labs(fill = "Happiness score") +
  ggtitle("World Happiness Report 2015-2021",
          subtitle = "Calculated happiness score on the Cantril ladder") +
  theme(panel.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5))


# I want to add the country names to the map
country_points <- st_centroid(whr_map$geometry)
country_points <- cbind(whr_map, st_coordinates(st_centroid(whr_map$geometry)))

ggplot(data = whr_map, aes(geometry = geometry)) +
  geom_sf(aes(fill = happiness_score)) +
  geom_text(data = country_points, aes(x = X, y = Y, label = name),
            color = "black", fontface = "bold", check_overlap = FALSE) +
  annotation_scale(location = "bl", width_hint = 0.5) +
  annotation_north_arrow(location = "bl",
                         pad_x = unit(0.3, "cm"), pad_y = unit(0.5, "cm"),
                         style = north_arrow_fancy_orienteering) +
  coord_sf(xlim = c(-20, 45), ylim = c(30, 73), expand = FALSE) +
  theme_classic() +
  scale_fill_distiller(palette = "YlOrBr") +
  xlab("Longitude") + ylab("Latitude") +
  labs(fill = "Happiness score") +
  ggtitle("World Happiness Report 2015-2021",
          subtitle = "Calculated happiness score on the Cantril ladder") +
  theme(panel.background = element_rect(fill = "aliceblue"), 
        panel.grid.major = element_line(color = gray(.5), linetype = "dashed", size = 0.5))
