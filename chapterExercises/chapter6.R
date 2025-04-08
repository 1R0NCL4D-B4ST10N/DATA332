library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(tidyr)

## Previous Chapter's Exercises, needed for Chapter 4 Exercises
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

deck <- data.frame(
  face = c("king", "queen", "jack", "ten", "nine", "eight", "seven", "six",
           "five", "four", "three", "two", "ace", "king", "queen", "jack", "ten",
           "nine", "eight", "seven", "six", "five", "four", "three", "two", "ace",
           "king", "queen", "jack", "ten", "nine", "eight", "seven", "six", "five",
           "four", "three", "two", "ace", "king", "queen", "jack", "ten", "nine",
           "eight", "seven", "six", "five", "four", "three", "two", "ace"),
  suit = c("spades", "spades", "spades", "spades", "spades", "spades",
           "spades", "spades", "spades", "spades", "spades", "spades", "spades",
           "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs", "clubs",
           "clubs", "clubs", "clubs", "clubs", "clubs", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "diamonds",
           "diamonds", "diamonds", "diamonds", "diamonds", "diamonds", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts", "hearts", "hearts",
           "hearts", "hearts", "hearts", "hearts", "hearts"),
  value = c(13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8,
            7, 6, 5, 4, 3, 2, 1, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 13, 12, 11,
            10, 9, 8, 7, 6, 5, 4, 3, 2, 1)
)

head(deck)

write.csv(deck, file = "cards.csv", row.names = FALSE)


## Chapter 4 Exercises

## Exercise 1: 
deal <- function(cards) {
  cards[1, ]
}

deal(deck)

## Exercise 2:
shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}

deal(deck)

deck2 <- shuffle(deck)

deal(deck2)

deck2$face == "ace"

sum(deck2$face == "ace")

deck4 <- deck

deck4$value[deck4$suit == "hearts"] <- 1

deck4$value

## Chapter 6

## Exercise 1:

## Yes! Because deck is in the parent environment.

## Exercise 2:

deal <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}

deal()
## Exercise 3:

shuffle <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", deck[random, ], envir = globalenv())
}

shuffle()


