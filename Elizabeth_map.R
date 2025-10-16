#### Homework Week 7 ----
#Elizabeth and Kristine

#############################################################33
##Elizabeth's map for data
#############################################################

#adding our libraries 
library(dplyr) 
library(maps)
library(janitor)
library(ggmap) #note: make sure to cite ggmap!! 

#Pulling in data 

#Go to https://wiatri.net/inventory/bbb/exploreData/theSearchResult.cfm and download an Excel file, then save it as a CSV 
#We can't use the URL becuase it doesn't all fit in one webpage
 
d = read.csv("bee_data_braatz.csv")
d <- clean_names(d) #clean_names uses hte janitor package to clean up column names. clean_names turns everything into snake case 

#Let's make made-up lat/longs, I need to do a data agreement form to actually get them from the DNR 

d = d %>% 
  mutate(location = paste(county, " County, Wisconsin"))

#%>%
 # geocode(location, method = "osm", lat = latitude, long = longitude)

# Prepare and geocode using dplyr package 
citiesCR <- citiesCR %>%
  mutate(location = paste(city, state, sep = ", ")) %>% 
  #mutate creates or changes columns. We are creating a column called location and co,mbine the   values of city and state into a string like, "los angeles, California"
  geocode(location, method = "osm", lat = latitude, long = longitude)
#use the ggmap package to send the location strings to a geocoding place to get lat and long 
#method = osm = method OpenStreetMap (geocoder provider, free, open source) 
#The new coordinates get stored into new columns: latitude and longitude

??geocode

