library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/fish')

df_fish <- read_csv('fish.csv')
df_kelp <- read_excel('kelp_fronds.xlsx', .name_repair = 'universal')

df_fish_filtered <- df_fish %>% filter(year >= 2017)

df_kelp_filtered <- df_kelp %>% filter(total_fronds > 50)

df_full_join <- full_join(df_fish_filtered, df_kelp_filtered, by = c("year", "site"))

df_left_join <- left_join(df_fish_filtered, df_kelp_filtered, by = c("year", "site"))

df_inner_join <- inner_join(df_fish_filtered, df_kelp_filtered, by = c("year", "site"))

