
# Let's Create a Facet Grid

################################################################################

# First load all the libraries needed, make sure they are installed
library(ggplot2) # For plotting
library(dplyr) # For data wrangling

################################################################################

# Now load in the data 
df <- read.csv("0_data/local_food_economics/df_foodaccess.csv") # df is just a variable name given to the data
meta_foodaccess<-read.csv("0_data/local_food_economics/meta_foodaccess.csv") # load in the meta data is not need, just a reference 

################################################################################

# Then, explore the data
head(df) 

unique(df$topic_area) 

################################################################################

# Now after exploring the data we are going to focus on explore the topic_area "Food Insecurity"
# Filter the data to only include "Food Insecurity"
df <- df |> filter(topic_area == "Food Insecurity")

################################################################################

# Now let's recreate this plot but to show US, West Virginia, California, New York
df<- df |> filter(fips == 54| fips == 36 | fips == 6 | fips == 0) # filtering with the fips removes the counties

plot_1 <- ggplot(df, aes(x = state_name, y = value, color = variable_name)) +
  geom_bar(stat = "identity")

# View this plot
plot_1

################################################################################

# Notice that the two variables are stacked on each other 
# We can fix that with position = "dodge"
plot_2 <- ggplot(df, aes(x = state_name, y = value, color = variable_name)) +
  geom_bar(stat = "identity", position = "dodge")

# View this plot
plot_2

################################################################################

# However we want to be able to view the differences between the rate child food insecurity and overall food insecurity
# there are two way we can do this

################################################################################

plot_3 <- ggplot(df, aes(x = state_name, y = value, color = variable_name, fill = as.factor(year))) +
  geom_bar(stat = "identity", position = "dodge")

# View this plot
plot_3

################################################################################

# plot_3 is very messy and hard to read
# Let's try faceting

plot_4 <- ggplot(df, aes(x = year, y = value)) +
  geom_bar(stat = "identity") +
  facet_grid(variable_name ~ state_name)

plot_4

# This is much easier to read 
# Now the same aesthetic changes can be made to this graph as seen in 01_a_basic_graph





