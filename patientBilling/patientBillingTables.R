library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)
library(tidytext)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/patientBilling')

df_visit <- read_excel('Visit.xlsx', .name_repair = 'universal')
df_patient <- read_excel('Patient.xlsx', .name_repair = 'universal')
df_billing <- read_excel('Billing.xlsx', .name_repair = 'universal')

df_visit_patient <- left_join(df_visit, df_patient, by = 'PatientID')
df <- left_join(df_visit_patient, df_billing, by = 'VisitID')

df$Month <- format(as.Date(df$VisitDate), "%B")

ggplot(df, aes(x = Reason, fill = Month)) +
  geom_bar() +
  theme_minimal() +
  labs(title = "Reason for Visit by Month", x = "Reason", y = "Count", fill = "Month") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(df, aes(x = Reason, fill = WalkIn)) +
  geom_bar(position = "dodge") +
  theme_minimal() +
  labs(title = "Reason for Visit by Walk-In Status", x = "Reason", y = "Count", fill = "Walk-In?") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(df, aes(x = Reason, fill = City)) +
  geom_bar(position = "stack") +
  theme_minimal() +
  labs(title = "Reason for Visit by City", x = "City", y = "Count", fill = "Reason") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(df, aes(x = Reason, y = InvoiceAmt, fill = InvoicePaid)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Total Invoice Amount by Reason for Visit", x = "Reason", y = "Total Invoice Amount", fill = "Invoice Paid?") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggplot(df, aes(x = Month, y = InvoiceAmt, fill = InvoicePaid)) +
  geom_col() +
  theme_minimal() +
  labs(title = "Total Invoice Amount Per Month", x = "Month", y = "Total Invoice Amount", fill = "Invoice Paid?")



