library(dplyr)
library(ggplot2)

data(mtcars)

head(mtcars)

cyl_counts <- table(mtcars$cyl)

barplot(cyl_counts,
        main = "Number of Cars by Cylinder Count",
        xlab = "Number of Cylinders",
        ylab = "Count of Cars",
        col = "skyblue",
        border = "black")

mtcars$cyl <- as.factor(mtcars$cyl)

ggplot(mtcars, aes(x = cyl, fill = cyl)) +
  geom_bar() +
  labs(title = "Number of Cars by Cylinder Count",
       x = "Number of Cylinders",
       y = "Count of Cars") +
  scale_fill_brewer(palette = "Set2") +
  theme_minimal()

