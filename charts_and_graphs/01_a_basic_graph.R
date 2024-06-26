
# Let's Create a Line Graph

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

# Now after exploring the data we are going to focus on explore the topic_area "Federal Nutrition Program"
# Filter the data to only include "Federal Nutrition Program"
df <- df |> filter(topic_area == "Federal Nutrition Program")
# Let's now explore this new data 
n_distinct(df$variable_name)

unique(df$variable_name)
# Filter the data again for the variable_name "wic_coverage_rate"
df <- df |> filter(variable_name == "wic_coverage_rate")

################################################################################

# Now create a new data frame from the original df only including state_name "US"
df_us <- df |> filter(state_name == "US") 
# Let's now plot this data
plot_1 <- ggplot(df_us, aes(x = year, y = value)) +
  geom_line()

# View the plot
plot_1

################################################################################

# Now let's recreate this plot but to show US, West Virginia, California, New York
df <- df |> filter(state_name == "US" |state_name == "West Virginia" |state_name == "California" |state_name == "New York")
# Let's now plot this data
plot_2 <- ggplot(df, aes(x = year, y = value, colour = state_name)) +
  geom_line()

plot_2

################################################################################

# Now let's make this graph more presentable
plot_3 <- ggplot(df, aes(x = year, y = value, colour = state_name)) +
  geom_line() +
theme(legend.position = "right", # positions the legend
      legend.title = element_text(size = 10, # element_text sets size and font of text
                                  face = "bold",
                                  family = "sans",
                                  hjust = 0.5,
                                  vjust = 0.5),
      legend.text = element_text(size = 8,
                                 family = "sans",
                                 hjust = 0.5,
                                 vjust = 0.5),
      axis.title.x = element_text(size = 12,
                                  face = "bold", 
                                  family = "sans",
                                  hjust = 0.5,
                                  vjust = 0.5, 
                                  angle = 0,
                                  margin = margin(t = 20)),
      axis.title.y = element_text(size = 12,
                                  face = "bold", 
                                  family = "sans",
                                  hjust = 0.5,
                                  vjust = 0.5, 
                                  angle = 90,
                                  margin = margin(r = 20)),
      axis.text.x = element_text(size = 8,
                                 family = "sans",
                                 hjust = 0.5,
                                 vjust = 0.5, 
                                 angle = 0),
      axis.text.y = element_text(size = 8,
                                 family = "sans",
                                 hjust = 0.5, 
                                 vjust = 0.5, 
                                 angle = 0),
      plot.title = element_text(size = 16, 
                                face = "bold", 
                                family = "sans", 
                                hjust = 0.5, 
                                vjust = 0.5),
      plot.caption = element_text(size = 6,
                                  family = "sans",
                                  hjust = 0.5,
                                  vjust = 0.5),
      plot.caption.position = "panel") + # position of caption
  labs(color = "State", # here you can create your variables 
       x = "Year",
       y = "Rate",
       title = "WIC Coverage Rate from 2016-2021",
       caption = "Caption: WIC Coverage Rate from 2016-2021 in US, West Virginia, California, and New York")

# View the graph
plot_3






