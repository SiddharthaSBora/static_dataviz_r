library("tidyverse")

# load the data
df_foodaccess<-read_csv("./0_data/df_foodaccess.csv")
meta_foodaccess<-read_csv("./0_data/meta_foodaccess.csv")

# let's keep only overall_food_insecurity_rate and child_food_insecurity_rate
df_foodsecurity<-df_foodaccess |>
  filter(variable_name %in% c("overall_food_insecurity_rate", 
                              "child_food_insecurity_rate")
  )

# inspect first 10 rows
head(df_foodsecurity, 10)

# write data into a csv
write_csv(df_foodsecurity, "./0_data/food_insecurity_dataviz.csv")

