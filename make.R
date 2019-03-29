library(drake)
library(readr)

import_data <- function(infile) {
  suppressMessages(read_csv(infile))
}

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

stopifnot(file.exists("data/mtcars.csv"))
plan <- drake_plan(
  data = import_data(file_in("data/mtcars.csv")),
  report = knitr::knit(knitr_in("report.Rmd"), file_out("report.md"), quiet = TRUE),
  small = simulate(48, data),
  large = simulate(64, data),
  regression1 = target(
    reg1(data),
    transform = map(data = c(small, large), .tag_out = reg)
  ),
  regression2 = target(
    reg2(data),
    transform = map(data, .tag_out = reg)
  ),
  summ = target(
    suppressWarnings(summary(reg$residuals)),
    transform = map(reg)
  ),
  coef = target(
    suppressWarnings(summary(reg))$coefficients,
    transform = map(reg)
  )
)
prefix <- paste(stringi::stri_rand_strings(1, 10))

config <- drake_config(plan)
vis_drake_graph(config, file = paste0(prefix, ".png")) # requires webshot::install_phantomjs() first

if ("regression1_small" %in% outdated(config)) {
  # build up to and incl regression targets
  make(
    plan,
    targets = c(
      "regression1_small", "regression1_large",
      "regression2_small", "regression2_large"
    ),
    cache_log_file = paste0(prefix, "-step1-cache.log"),
    console_log_file = paste0(prefix, "-step1-console.log")
  )
} else {
  # build everything
  make(
    plan,
    cache_log_file = paste0(prefix, "-step2-cache.log"),
    console_log_file = paste0(prefix, "-step2-console.log")
  )
}


