library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/studentData')

df_student <- read_excel('Student.xlsx', .name_repair = 'universal')
df_course <- read_excel('Course.xlsx', .name_repair = 'universal')
df_registration <- read_excel('Registration.xlsx', .name_repair = 'universal')

df_course_registration <- left_join(df_registration, df_course, by = c('Instance.ID'))

df <- left_join(df_student, df_course_registration, by = c('Student.ID'))

df_majors <- df %>% group_by(Title) %>% summarise(Count = n())

ggplot(df_majors, aes(x=Title, y=Count)) + geom_bar(stat = "identity")

df_birth_years <- df %>% mutate(Birth.Date = year(Birth.Date))

df_birth_years <- df_birth_years %>% group_by(Birth.Date) %>% summarise(count = n())

ggplot(df_birth_years, aes(x=Birth.Date, y=count)) + geom_bar(stat = "identity")

df_total_cost <- df %>% group_by(Title, Payment.Plan) %>% summarise(cost = (sum(Total.Cost)))

ggplot(df_total_cost, aes(fill=Payment.Plan, y=cost, x=Title)) + geom_bar(position="dodge", stat="identity")

df_total_balance <- df %>% group_by(Title, Payment.Plan) %>% summarise(balance = sum(Balance.Due))

ggplot(df_total_balance, aes(fill=Payment.Plan, y=balance, x=Title)) + geom_bar(position="dodge", stat="identity")