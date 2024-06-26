# maps

df<-read_csv("./0_data/local_food_economics/mydata.csv")

# at US level
df_us<-mydata |>
  filter(state_name == "US")

# let's plot
ggplot(df_us, aes(x=year, y=value, color=variable_name))+
  geom_line()+
  labs(title="Food Insecurity Rate in the US", x="Year", y="Rate")+
  theme_minimal()

# let's plot a map
df_states<-mydata |>
  filter(as.numeric(fips)<=56 & year ==2015 & state_name!="US")|>
  filter(variable_name == "overall_food_insecurity_rate")


states<-tigris::states(filter_by = c(xmin=-125, xmax=-66, ymin=24, ymax=50))|>
  left_join(df_states, by = join_by(GEOID==fips))

# plot the map
ggplot(states, aes(fill=value))+
  geom_sf()+
  scale_fill_viridis_c()+
  labs(title="Food Insecurity Rate in the US", fill="Rate")+
  theme_minimal()


# county level maps
df_states<-mydata |>
  filter(as.numeric(fips)>1000 & year ==2015 & state_name!="US")|>
  filter(variable_name == "overall_food_insecurity_rate")
wv_counties <- counties(state="WV")|>
  left_join(df_states, by = join_by(GEOID==fips))


# plot the map
ggplot(wv_counties, aes(fill=value))+
  geom_sf()+
  scale_fill_viridis_c()+
  labs(title="Food Insecurity Rate in WV", fill="Rate")+
  theme_minimal()

# make a function
plot_map<-function(df, state_name, variable_name, year){
  df_states<-df |>
    filter(as.numeric(fips)>1000 & year ==year & state_name==state_name)|>
    filter(variable_name == variable_name)
  
  counties <- counties(state=state_name)|>
    left_join(df_states, by = join_by(GEOID==fips))
  
  # plot the map
  ggplot(counties, aes(fill=value))+
    geom_sf()+
    scale_fill_viridis_c()+
    labs(title=paste(variable_name, "in", state_name), fill="Rate")+
    theme_minimal()
}

# make wv map
plot_map(df, "Ohio", "overall_food_insecurity_rate", 2015)


# let's plot a map in West Virginia
# at US level
df_wv<-mydata |>
  filter(state_name == "West Virginia") |>
  filter(variable_name == "overall_food_insecurity_rate") |>
  filter(year == 2015)

# let's plot
ggplot(df_wv, aes(x=year, y=value))+
  geom_line()+
  labs(title="Food Insecurity Rate in West Virginia", x="Year", y="Rate")+
  theme_minimal()






