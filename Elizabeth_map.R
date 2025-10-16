#### Homework Week 7 ----
#Elizabeth and Kristine

#############################################################33
##Elizabeth's map for data
#############################################################

#adding our libraries 
library(rvest)
library(janitor)
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tidyverse)
library(grid)
library(ggspatial)

#Pulling in data 

#Go to https://wiatri.net/inventory/bbb/exploreData/theSearchResult.cfm and download an Excel file, then save it as a CSV 
#We can't use the URL becuase it doesn't all fit in one webpage
 
d = read.csv("bee_data_braatz.csv")
d <- clean_names(d) #clean_names uses the janitor package to clean up column names. clean_names turns everything into snake case 
d = d[, -6] #remove the county  names 
d = d[1:25,] #since this is made up data, let's just keep it a small number of points for ease of loading 

#------------------------------------------
#Let's make made-up lat/longs, I need to do a data agreement form to actually get them from the DNR 

set.seed(42) #when creating random numbers, ew want them to be reproducible. So this way, in the future when I run this, it'll create the same random numbers. 

d = d %>% 
  mutate(
    latitude = runif(n(), 43.5, 45), 
    #runif(number of numbers to create, min, max) 
    #n() tells it to pick however many rows you have 
    longitude = runif(n(), -90.9, -89.5)
  )

#------------------------------------------
#Time to map (thank you KRistine, Jade, and Jeremy) 

#we can use the maps library to pull a basic map of Wisconsin and save as an object

states <- map_data("state") #load data for each state
wi <- subset(states, region =="wisconsin") #create object with wi data

#also make df objects with your county lines
counties <- map_data("county")
wi_county <- subset(counties, region == "wisconsin")

#we can now use ggplot to generate a simple map of field sites
#with county lines also marked

wi_b <- ggplot(data = wi, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + 
  geom_polygon(color = "black", fill = "#f0f0f0") #can change background color of map

wi_b #view map of empty WI 

wi_m <- wi_b + theme_nothing()+ #theme_nothing gets rid of grid lines 
  geom_polygon(data = wi_county, fill = NA, color = "white") + #this makes white outline of county
  geom_polygon(color = "black", fill = NA) + 
  geom_point(data = d, color = "black", mapping = aes(x = longitude, y = latitude),
             color = "black", size = 0.5, inherit.aes = FALSE)#add points for your sites

wi_m 

#Let's make it prettier 

wi_m_pretty <- wi_b +
  theme_nothing() + #theme_nothing gets rid of grid lines 
  geom_polygon(data = wi_county, fill = NA, color = "dark grey") + 
  #this makes white outline of county
  geom_polygon(color = "black", fill = NA) + 
  # this adds in a black outline I think 
  geom_point(data = d, 
             mapping = aes(
               x = longitude,
               y = latitude, 
               size = number, 
               shape = sex, 
               color = species), 
             alpha = 0.5, 
             inherit.aes = FALSE) + 
          #add points for my sites, and make their size dependent on how many bees were found, the shape dependent on the sex of the bees, and the color dependent on the species of bees 

  labs(
    title = "Bumble bees in WI \n Bumble Bee Brigade 2025", 
    size = "Number of bees",
    shape = "Sex", 
    color = "Bee Species",
    x = "Longitude",
    y = "Latitude"
  ) + 
  #adding legend labels and title 
  
  theme(
    legend.position = "right", 
    plot.title = element_text(
      hjust = 0.5, 
      size = 14, 
      face = "bold")) 
  #if you don't add hte theme, it gets mad and doesn't plot them 

wi_m_pretty # heads up this takeas a while to load 

