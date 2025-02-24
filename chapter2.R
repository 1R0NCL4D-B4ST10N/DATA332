library("ggplot2")

x <- c(1, 2, 2, 2, 3, 3)
qplot(x, binwidth = 1)

x2 <- c(1, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 4)
qplot(x2, binwidth = 1)

x3 <- c(0, 1, 1, 2, 2, 2, 3, 3, 4)
# i think there will 1 unit tall entries at 0 and 4, 2 unit tall entries at 1 and 3, and the tallest entry at 2.
qplot(x3, binwidth = 1)
# shoulda said it would be a triangle


roll <- function() {
  die <- 1:6
  dice <- sample(die, size=2, replace = TRUE, prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)