
# Let's create maps with ggplot2

################################################################################

# First load all the libraries needed, make sure they are installed
library(ggplot2) # For mapping/plotting
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

# Now after exploring the data we are going to focus on explore the topic_area "Federal Nutrition Program"
# Filter the data to only include "Federal Nutrition Program"
df <- df |> filter(topic_area == "Federal Nutrition Program")

# Filter the data again for the variable_name "wic_coverage_rate"
df <- df |> filter(variable_name == "wic_coverage_rate")
################################################################################

# let's only look at year 2021
df_2021 <- df |> filter(year == 2021)

################################################################################
# Lets make a map
map1 <- ggplot() +
  geom_sf(data = df_2021,aes(fill = value, geometry = geometry))

map1

# this map is not made wit the best data, but you can use edit the theme with the same methods as in 01_a_basic_graph


