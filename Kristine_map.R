#### Homework Week 7 ----
#Elizabeth and Kristine

#Kristine's map

#I had previously worked with a lab member (Jade) to make some basic site location maps for my data from a different project
#This code modifies that original output a bit

#Final result: Map of my Wisconsin Field Sites

#Load packages
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tidyverse)
library(grid)
library(ggspatial)
library(viridis) #lets you create color blind friendly maps

#read in field site csv
bb_sites <- read.csv("bb_fieldsites - Sheet1.csv", header = TRUE) #this csv has lat and long coordinates 

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

wi_b #view map

wi_m <- wi_b + theme_nothing()+ #theme_nothing gets rid of grid lines 
  geom_polygon(data = wi_county, fill = NA, color = "white") + #this makes white outline of county
  geom_polygon(color = "black", fill = NA) + 
  geom_point(data = bb_sites, color = "black", mapping = aes(x = longitude, y = latitude),
             color = "black", size = 0.5, inherit.aes = FALSE)#add points for your sites

wi_m #very basic map, in black and white

#I want to make this map better
#zoom in on my field sites, and color code by the cluster
#context, the clusters were just groups of sites visited in the same day or over two days in a row

wi_base <- ggplot(data = wi, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) + #I believe this just applies the aspect ratio for the map
  geom_polygon(color = "black", fill = "#f0f0f0")

wi_base #view wi base map

wi_map <- wi_base + theme_nothing() +
  geom_polygon(data = wi_county, fill = NA, color = "black") + #outline our counties in white
  geom_polygon(color = "black", fill = NA) + #black outline of the state?
  geom_point(data = bb_sites, mapping = 
               aes(x = longitude, y = latitude, color = cluster), 
             size = 2, inherit.aes = FALSE) +
  labs(
    color = "Cluster"
  ) +
  theme(legend.position = "right")

#scale_shape_manual(values = c(16,16,17)) +
# scalebar(wi, dist = 50, st.size=3, height=0.0 +25, dist_unit = "km", transform = TRUE, model = "WGS84", location = "bottomleft")

wi_map #map with the field sites colored by their cluster

#ggsave("wi_map.jpeg") #uncomment this if you want to save the map as an image