#### Homework Week 7 ----
#Elizabeth and Kristine

#Kristine's map

#I had previously worked with a lab member to make some basic site location maps for my data.
#This code modifies that original output

#Final result: Map of my Wisconsin Field Sites

#Load packages
library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(tidyverse)
library(grid)
library(ggsn)
library(ggspatial)

#read in field site csv

bb_sites <- read.csv("bb_fieldsites - Sheet1.csv", header = TRUE)
