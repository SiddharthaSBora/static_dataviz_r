# Some examples of plots using ggplot2
library("tidyverse")

df_foodsecurity<-read_csv("./0_data/food_insecurity_dataviz.csv")

# Subset data for WV
df_wv <- df_foodsecurity |> 
  filter(fips == "54") |>
  mutate(variable_name = fct_relevel(variable_name, "overall_food_insecurity_rate", 
                                     "child_food_insecurity_rate"),
         value = 100*value)

# line plot
df_wv |>
  filter(variable_name == "overall_food_insecurity_rate") |>
  ggplot(aes(x = year, y = value)) +  
  geom_line()

# create bar chart
df_wv |>
  filter(variable_name == "overall_food_insecurity_rate") |>
  ggplot(aes(x = year, y = value)) +  
  geom_col()

# create line plot for two variables
df_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, color = variable_name)) +  
  geom_line()

# create barchart for two variables 
df_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")

# treat the plot as an object
plot_1 <- df_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")

plot_1<- plot_1+
  labs(title="Food Insecurity Rate in West Virginia", x="Year", y="%")+
  theme_minimal()


# make improvements to the plot 
plot_1 <- df_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")+
  labs(title="Food Insecurity Rates in West Virginia", x="", y="%")+
  # break each year
  scale_x_continuous(breaks = seq(2011, 2021, 1))+
  # add value labels
  geom_text(aes(label = paste0(round(value, 1), "%")), 
            position = position_dodge(width = 1), 
            vjust = -0.5, size = 3)+
  # legend labels and name
  scale_fill_discrete(name = "", labels = c("Overall", "Child"))

# change themes
plot_1 <- df_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")+
  labs(title="Food Insecurity Rates in West Virginia", x="", y="%")+
  # break each year
  scale_x_continuous(breaks = seq(2011, 2021, 1))+
  # add value labels
  geom_text(aes(label = paste0(round(value, 1), "%")), 
            position = position_dodge(width = 1), 
            vjust = -0.5, size = 3)+
  # legend labels and name
  scale_fill_discrete(name = "", labels = c("Overall", "Child"))+
  theme_minimal()+
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        plot.title = element_text(size = 14, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())

plot_1

# Now I want to make plot for Ohio
df_oh <- df_foodsecurity |> 
  filter(fips == "39") |>
  # variable name factor relevel
  mutate(variable_name = fct_relevel(variable_name, "overall_food_insecurity_rate", 
                                     "child_food_insecurity_rate"),
         value = 100*value)

# treat the plot as an object
plot_2 <- df_oh |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")+
  labs(title="Food Insecurity Rates in Ohio", x="", y="%")+
  # break each year
  scale_x_continuous(breaks = seq(2011, 2021, 1))+
  # add value labels
  geom_text(aes(label = paste0(round(value, 1), "%")), 
            position = position_dodge(width = 1), 
            vjust = -0.5, size = 3)+
  # legend labels and name
  scale_fill_discrete(name = "", labels = c("Overall", "Child"))+
  theme_minimal()+
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        plot.title = element_text(size = 14, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())


# faceting by states
# let's make graphs for both US and WV
df_oh_wv <- df_foodsecurity |> 
  filter(fips %in% c("39","54")) |>
  # variable name factor relevel
  mutate(variable_name = fct_relevel(variable_name, "overall_food_insecurity_rate", 
                                     "child_food_insecurity_rate"),
         value = 100*value)

# treat the plot as an object
plot_3 <- df_oh_wv |>
  filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
  ggplot(aes(x = year, y = value, fill = variable_name)) +  
  geom_col(position = "dodge")+
  labs(title="Food Insecurity Rates in the Ohio and West Virginia", x="", y="%")+
  # break each year
  scale_x_continuous(breaks = seq(2011, 2021, 1))+
  # add value labels
  geom_text(aes(label = paste0(round(value, 1), "%")), 
            position = position_dodge(width = 1), 
            vjust = -0.5, size = 3)+
  # legend labels and name
  scale_fill_discrete(name = "", labels = c("Overall", "Child"))+
  theme_minimal()+
  theme(legend.position = "bottom",
        legend.title = element_text(size = 12),
        legend.text = element_text(size = 10),
        plot.title = element_text(size = 14, hjust = 0.5),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())+
  facet_wrap(~state_name)



# Make a function to create the plot for any state
plot_state <- function(state_fips){
  df_state <- df_foodsecurity |> 
    filter(fips == state_fips) |>
    # variable name factor relevel
    mutate(variable_name = fct_relevel(variable_name, "overall_food_insecurity_rate", 
                                       "child_food_insecurity_rate"))
  
  state_name <- df_state |>
    pull(state_name) |>
    unique()
  
  # treat the plot as an object
  plot_state <- df_state |>
    filter(variable_name %in% c("overall_food_insecurity_rate", "child_food_insecurity_rate")) |>
    ggplot(aes(x = year, y = 100*value, fill = variable_name)) +  
    geom_col(position = "dodge")+
    labs(title=paste("Food Insecurity Rates in", state_name), x="", y="%")+
    # break each year
    scale_x_continuous(breaks = seq(2011, 2021, 1))+
    ylim(0, 40)+
    # add value labels
    geom_text(aes(label = paste0(round(100*value, 1), "%")), 
              position = position_dodge(width = 1), 
              vjust = -0.5, size = 3)+
    # legend labels and name
    scale_fill_discrete(name = "", labels = c("Overall", "Child"))+
    theme_minimal()+
    theme(legend.position = "bottom",
          legend.title = element_text(size = 12),
          legend.text = element_text(size = 10),
          plot.title = element_text(size = 14, hjust = 0.5),
          axis.title = element_text(size = 12),
          axis.text = element_text(size = 10),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank())
  
  return(plot_state)
}
  



# Now I want to make plot for West Virginia
plot_state("54")
plot_state("39")

# Arranging plots in a grid
library("gridExtra")
plot_wv<-plot_state("54")

plot_va<-plot_state("51")

# grid arrange and merge legends
grid.arrange(plot_wv, plot_va, ncol=2, top = "Food Insecurity Rates in West Virginia and Virginia")

# Other geoms


# Overall there are facilities for choosing different geoms, and doing pretty fancy stuff with ggplot2.
# The main thing is to get the data in the right format, and creating the barebones plot.
# After that, it's just a matter of adding layers to the plot.
# Anything sensible that you envisage doing with a plot, you can probably do with ggplot2.







  




