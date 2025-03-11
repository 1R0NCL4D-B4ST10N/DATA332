library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

## Exercise 1: 1 is an integer, "1" and "one" are strings.

## Exercise 2: An atomic character vector.
hand <- c("ace", "king", "queen", "jack", "ten")
hand
## Exercise 3:
hand2 <- c("ace", "king", "queen", "jack", "ten", "spades", "spades", "spades", "spades", "spades")
matrix(hand2, nrow = 5, byrow = TRUE)
matrix(hand2, ncol = 2, byrow = TRUE)
## Exercise 4:
card <- c("ace", "hearts", 1)
card
## Exercise 5:
card <- list("ace", "hearts", 1)
card