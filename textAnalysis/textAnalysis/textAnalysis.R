# Consumer Complaints Sentiment Analysis in R

# Load necessary libraries
library(tidyverse)
library(tidytext)
library(ggplot2)
library(wordcloud)
library(scales)
library(RColorBrewer)

rm(list = ls())

# Insert your directory here
setwd('C:/Users/thewi/Documents/rstudio/textAnalysis')

# Load the dataset
data <- read.csv("Consumer_Complaints.csv", stringsAsFactors = FALSE)

# Data Cleaning
cleaned_data <- data %>%
  select(Date.received, Product, Issue, Consumer.complaint.narrative) %>%
  filter(!is.na(Consumer.complaint.narrative)) %>%
  mutate(Date.received = as.Date(Date.received, format = "%m/%d/%Y"))

# Tokenize words for sentiment analysis
words_data <- cleaned_data %>%
  unnest_tokens(word, Consumer.complaint.narrative) %>%
  anti_join(stop_words)

# Sentiment Analysis using Bing Lexicon
bing_sentiment <- words_data %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE)

# Sentiment Analysis using NRC Lexicon
nrc_sentiment <- words_data %>%
  inner_join(get_sentiments("nrc")) %>%
  count(sentiment, sort = TRUE)

# Aggregate Sentiment by Product Category
sentiment_by_product <- words_data %>%
  inner_join(get_sentiments("bing")) %>%
  group_by(Product, sentiment) %>%
  summarise(count = n()) %>%
  spread(sentiment, count, fill = 0)

# Plot Bing Sentiment Distribution
bing_plot <- bing_sentiment %>%
  ggplot(aes(x = sentiment, y = n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Bing Sentiment Distribution in Consumer Complaints") +
  scale_y_continuous(labels = comma)

bing_plot

ggsave("images/bing_sentiment.png", bing_plot)


# Plot NRC Sentiment Distribution
nrc_plot <- nrc_sentiment %>%
  ggplot(aes(x = sentiment, y = n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("NRC Sentiment Breakdown in Consumer Complaints") +
  scale_y_continuous(labels = comma)

nrc_plot


ggsave("images/nrc_sentiment.png", nrc_plot)

# Generate Word Cloud of Issues
issue_wordcloud <- cleaned_data %>%
  count(Issue, sort = TRUE)

wordcloud <- wordcloud(words = issue_wordcloud$Issue, freq = issue_wordcloud$n, min.freq = 50, random.order = FALSE, colors = brewer.pal(8, "Dark2"))

ggsave("images/wordcloud.png", wordcloud)