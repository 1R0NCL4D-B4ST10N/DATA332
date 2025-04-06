library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/inClassWork')

df <- read_excel('clean_transactions.xlsx', .name_repair = 'universal')
df <- read_excel('credit_card_transactions.xlsx', .name_repair = 'universal')

## Clean Transactions
df$amount <- str_extract(df$Description.Amount, "[0-9]+.[0-9]+")

## Credit Card Transactions
df$Date <- str_extract(df$Details, "[0-9]+-[0-9]+-[0-9]+")
df$Amount <- str_extract(df$Details, "$[0-9]+.[0-9]+")

