library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/trucker')

df_truck <- read_excel('NP_Ex_1-2.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')

df <- df_truck[, c(4:15)]

df = subset(df, select = -c(...10) )

date1 <- min(df$Date)
date2 <- max(df$Date)

numbers_days_on_road <- date2 - date1

num_days <- nrow(df)

num_days

hours <- sum(df$Hours)

average_hours_per_day <- hours / num_days

average_hours_per_day

df$Gallons.Cost <- df$Gallons * df$Price.per.Gallon

df$Gallons.Cost

df$Other.Cost <- df$Tolls + df$Misc

total_cost <- sum(df$Gallons.Cost) + sum(df$Other.Cost)

total_cost

gallons <- sum(df$Gallons)

gallons

odo1 <- min(df$Odometer.Beginning)
odo2 <- max(df$Odometer.Ending)

total_miles <- odo2 - odo1

total_miles

miles_per_gallon <- total_miles / gallons

miles_per_gallon

total_cost_per_mile <- total_cost / total_miles

total_cost_per_mile

df[c('warehouse', 'starting_city_state')] <-
  str_split_fixed(df$Starting.Location, ',', 2)

df$starting_city_state <- gsub(',', "", df$starting_city_state)

df[c('col1', 'col2')] <-
  str_split_fixed(df$starting_city_state, ' ', 2)

nchar(df$starting_city_state)[1]

df[c('col1', 'col2', 'col3')] <-
  str_split_fixed(df$col2, ' ', 3)

df_starting_pivot <- df %>%
  group_by(starting_city_state) %>%
  summarize(count = n(),
            mean_size_hours = mean(Hours, na.rm = TRUE),
            sd_hours = sd(Hours, na.rm = TRUE),
            total_hours = sum(Hours, na.rm = TRUE),
            total_gallons = sum(Gallons, na.rm = TRUE))

ggplot(df_starting_pivot, aes(x = starting_city_state, y = count)) +
  geom_col() +
  theme(axis.text = element_text(angle = 45, vjust = .5, hjust = 1))

df$truck_num <- paste0('truck-1')
            