library(drake)
library(readr)
r_files <- fs::dir_ls("R")
purrr::walk(r_files, source)

# Plan --------------------------------------------------------------------

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

config <- drake_config(plan)
config
