
<!-- README.md is generated from README.Rmd. Please edit that file -->

We have a script called `inner.R`.

``` r
inside_inner <- 1
```

And another script called `outer.R`.

``` r
source("inner.R")
inside_outer <- 2
cat(ls(), sep = "\n", file = "outer.out")

cat(ls(envir = .GlobalEnv), sep = "\n", file = "global.out")
```

Running `outer.R` as an RStudio job:

``` r
rstudioapi::jobRunScript("outer.R", workingDir = getwd(), exportEnv = NULL)
```

Yeilding the following results in `outer.out`

``` r
cat(readLines("outer.out"), sep = "\n")
## inside_outer
```

Notice that `inside_inner` is not in the environment where `outer.R` is
evaluated, but it is in the global environment.

``` r
cat(readLines("global.out"), sep = "\n")
## emitProgress
## sourceWithProgress
## x
```
