source("_drake_env.R")
make(plan,
     targets = c(
       "regression1_small", "regression1_large",
       "regression2_small", "regression2_large"
     ),
     envir = drake_env
)
