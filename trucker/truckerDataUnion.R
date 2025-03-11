library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/trucker')

df_truck_0001 <- read_excel('truck data 0001.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_0369 <- read_excel('truck data 0369.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1226 <- read_excel('truck data 1226.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1442 <- read_excel('truck data 1442.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1478 <- read_excel('truck data 1478.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1539 <- read_excel('truck data 1539.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_truck_1769 <- read_excel('truck data 1769.xlsx', sheet = 2, skip = 3, .name_repair = 'universal')
df_pay <- read_excel('Driver Pay Sheet.xlsx', .name_repair = 'universal')

df <- rbind(df_truck_0001, df_truck_0369, df_truck_1226, df_truck_1442,
            df_truck_1478, df_truck_1539, df_truck_1769)

df_starting_pivot <- df %>% group_by(Truck.ID) %>% summarize(count = n())

df <- left_join(df, df_pay, by = c('Truck.ID'))

df_location_counts <- df %>% group_by(Starting.Location,Delivery.Location) %>% summarise(count = n())

df_ending_location_counts <- df %>%
  group_by(Delivery.Location) %>%
  summarise(count = n())

df_ending_pivot <- df %>% group_by(Truck.ID) %>% summarize(count = n(), total_pay = sum(labor_per_mil * (Odometer.Ending - Odometer.Beginning)))
barplot(df_ending_pivot$total_pay, main = "Total Pay", col = c('gold'))

