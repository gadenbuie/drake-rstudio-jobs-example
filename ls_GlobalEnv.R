source("_drake.R")

ls_global <- ls(envir = .GlobalEnv, all.names = TRUE)

cat(capture.output(print(ls_global)), sep = "\n")
