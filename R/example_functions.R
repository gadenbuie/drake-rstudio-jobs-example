# Pick a random subset of n rows from a dataset
random_rows <- function(data, n){
  data[sample.int(n = nrow(data), size = n, replace = TRUE), ]
}

# Bootstrapped datasets from mtcars.
simulate <- function(n, data = mtcars){
  # Pick a random set of cars to bootstrap from the mtcars data.
  data <- random_rows(data, n = n)

  # x is the car's weight, and y is the fuel efficiency.
  data.frame(
    x = data$wt,
    y = data$mpg
  )
}

# Is fuel efficiency linearly related to weight?
reg1 <- function(d){
  lm(y ~ + x, data = d)
}

# Is fuel efficiency related to the SQUARE of the weight?
reg2 <- function(d){
  d$x2 <- d$x ^ 2
  lm(y ~ x2, data = d)
}
