
# Let's make maps with tmap

################################################################################

# First load all the libraries needed, make sure they are installed
library(tmap) # For mapping
library(dplyr) # For data wrangling
library(tigris) # For get State Polygons

options(tigris_use_cache = TRUE)

################################################################################

# Now load in the data 
df <- read.csv("0_data/local_food_economics/df_foodaccess.csv") # df is just a variable name given to the data
meta_foodaccess<-read.csv("0_data/local_food_economics/meta_foodaccess.csv") # load in the meta data is not need, just a reference 

states <- states() # load in states data from tigris

by = join_by(GEOID == fips)

df$fips <- as.character(df$fips)

df <- states |> 
  left_join(df, by = by)

################################################################################

# Now after exploring the data we are going to focus on explore the topic_area "Food Insecurity"
# Filter the data to only include "Food Insecurity"
df <- df |> filter(topic_area == "Food Insecurity")

df <- df |> filter(variable_name == "overall_food_insecurity_rate")
# let's only look at year 2021
df_2021 <- df |> filter(year == 2021)

################################################################################

map_1 <- tm_shape(df_2021) +
  tm_polygons(col = "value")

map_1 # view map 

# this is how to create a very basic map with tmap




