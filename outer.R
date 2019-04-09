source("inner.R")
inside_outer <- 2
cat(ls(), sep = "\n", file = "outer.out")

cat(ls(envir = .GlobalEnv), sep = "\n", file = "global.out")
