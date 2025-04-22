2 * 3
## 6

4 - 1
## 3

6 / (4 - 1)
## 2

(((1 + 2) * 3) - 6) / 3
## 1

1:6
## 1 2 3 4 5 6

a <- 1
a
## 1

a + 2
## 3

die <- 1:6

die
## 1 2 3 4 5 6

Name <- 1
name <- 0

Name + 1
## 2

my_number <- 1
my_number
## 1

my_number <- 999
my_number

ls()
## "a"         "die"       "my_number" "name"      "Name" 

die - 1
## 0 1 2 3 4 5

die / 2
## 0.5 1.0 1.5 2.0 2.5 3.0

die * die
## 1  4  9 16 25 36

1:2
## 1 2

1:4
## 1 2 3 4

die
## 1 2 3 4 5 6

die + 1:2
## misread instructions first time
## 2 4 4 6 6 8

die + 1:4
## 2 4 6 8 6 8
Warning message:
  In die + 1:4 :
  longer object length is not a multiple of shorter object length

die %*% die
##     [,1]
##[1,]   91

die %o% die
## [,1] [,2] [,3] [,4] [,5] [,6]
## [1,]    1    2    3    4    5    6
## [2,]    2    4    6    8   10   12
## [3,]    3    6    9   12   15   18
## [4,]    4    8   12   16   20   24
## [5,]    5   10   15   20   25   30
## [6,]    6   12   18   24   30   36

round(3.1415)
## 3

factorial(3)
## 6

mean(1:6)
## 3.5

round(mean(die))
## 4

sample(x = 1:4, size = 2)
## 4 3

sample(x = die, size = 1)
## 5
## 2
## 2

sample(die, size = 1)
## 2

round(3.1415, corners = 2)
## Error in round(3.1415, corners = 2) : unused argument (corners = 2)

args(round)
## function (x, digits = 0, ...) 
## NULL

round(3.1415, digits = 2)
## 3.14

sample(die, 1)
## 2

sample(size = 1, x = die)
## 1

sample(die, size = 2)
## 2 6

dice <- sample(die, size = 2, replace = TRUE)
dice
## 6 6

sum(dice)
## 12

roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll()
## 6
## 7
## 10
## 9

dice
1 + 1
sqrt(2)
## 6 6
## 2
## 1.414214

dice <- sample(die, size = 2, replace = TRUE)
two <- 1 + 1
a <- sqrt(2)

roll2 <- function() {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2()
## Error in roll2() : object 'bones' not found

roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2(bones = 1:4)
## 5

roll2(bones = 1:6)
## 9

roll2(1:20)
## 23

roll2()
## Error in roll2() : argument "bones" is missing, with no default

roll2 <- function(bones = 1:6) {
  dice <- sample(bones, size = 2, replace = TRUE)
  sum(dice)
}

roll2()
## 4

rolls <- expand.grid(die, die)

rolls

rolls$value <- rolls$Var1 + rolls$Var2
head(rolls, 3)

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)

prob[rolls$Var1]

rolls$prob1 <- prob[rolls$Var1]
head(rolls, 3)

rolls$prob2 <- prob[rolls$Var2]
head(rolls, 3)

rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls, 3)

sum(rolls$value * rolls$prob)

wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")

combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
combos

prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06,
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)

combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
head(combos, 3)

combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos, 3)

sum(combos$prob)

symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])

score(symbols)

score <- function(symbols) {
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
  # identify case
  # since diamonds are wild, only nondiamonds
  # matter for three of a kind and all bars
  slots <- symbols[symbols != "DD"]
  same <- length(unique(slots)) == 1
  bars <- slots %in% c("B", "BB", "BBB")
  # assign prize
  if (diamonds == 3) {
    prize <- 100
  } else if (same) {
    payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
                 "B" = 10, "C" = 10, "0" = 0)
    prize <- unname(payouts[slots[1]])
  } else if (all(bars)) {
    prize <- 5
  } else if (cherries > 0) {
    # diamonds count as cherries
    # so long as there is one real cherry
    prize <- c(0, 2, 5)[cherries + diamonds + 1]
  } else {
    prize <- 0
  }
  # double for each diamond
  prize * 2^diamonds
}

for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

head(combos, 3)

sum(combos$prize * combos$prob)

