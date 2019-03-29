library(drake)
library(readr)

import_data <- function(infile) {
  suppressMessages(read_csv(infile))
}

stopifnot(file.exists("data/mtcars.csv"))
plan <- drake_plan(data = import_data(file_in("data/mtcars.csv")))
prefix <- paste(Sys.info()["nodename"], proc.time()["elapsed"], stringi::stri_rand_strings(1, 10), sep = "-")

make(
  plan,
  cache_log_file = paste0(prefix, "-cache.log"),
  console_log_file = paste0(prefix, "-console.log") # much more useful post-#808
)

config <- drake_config(plan)
vis_drake_graph(config, file = paste0(prefix, ".png")) # requires webshot::install_phantomjs() first
