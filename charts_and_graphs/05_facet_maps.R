
# Let's create a facet map

################################################################################

# First load all the libraries needed, make sure they are installed
library(tmap) # For mapping
library(ggplot2) # For mapping/plotting
library(dplyr) # For data wrangling
library(tigris) # For get State Polygons

options(tigris_use_cache = TRUE)

################################################################################

# Now load in the data 
df <- read.csv("0_data/local_food_economics/df_foodaccess.csv") # df is just a variable name given to the data
meta_foodaccess<-read.csv("0_data/local_food_economics/meta_foodaccess.csv") # load in the meta data is not need, just a reference 

counties <- counties() |> # Let's only use WV counties
  filter(STATEFP == "54")

by = join_by(GEOID == fips)

df$fips <- as.character(df$fips)

df <- counties |> 
  left_join(df, by = by)

################################################################################

# Now after exploring the data we are going to focus on explore the topic_area "Food Insecurity"
# Filter the data to only include "Food Insecurity"
df <- df |> filter(topic_area == "Food Insecurity")

df <- df |> filter(variable_name == "overall_food_insecurity_rate")

df <- df |> filter(year == 2021 | year == 2020 | year == 2019 | year == 2018)

################################################################################

# first lets make a facet map with ggplot2 

map_1 <- ggplot() +
  geom_sf(data = df,aes(fill = value, geometry = geometry))+
  facet_grid(~year) +
  theme_void() # this removes theme, sometimes this make maps more presentable

map_1

################################################################################

# Now let's make a facet map with tmap

map_2 <- tm_shape(df) +
  tm_polygons(col = "value") +
  tm_facets(by = "year")

map_2

################################################################################

# Using this you can analyze spatial time series trends 


