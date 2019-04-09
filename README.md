
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
## inside_inner
## sourceWithProgress
```

#### Session Info

``` r
sessioninfo::session_info()
## ─ Session info ──────────────────────────────────────────────────────────
##  setting  value                       
##  version  R version 3.5.2 (2018-12-20)
##  os       macOS High Sierra 10.13.6   
##  system   x86_64, darwin15.6.0        
##  ui       X11                         
##  language (EN)                        
##  collate  en_US.UTF-8                 
##  ctype    en_US.UTF-8                 
##  tz       America/New_York            
##  date     2019-04-09                  
## 
## ─ Packages ──────────────────────────────────────────────────────────────
##  package     * version date       lib source                     
##  assertthat    0.2.1   2019-03-21 [1] standard (@0.2.1)          
##  cli           1.1.0   2019-03-19 [1] standard (@1.1.0)          
##  crayon        1.3.4   2017-09-16 [1] CRAN (R 3.5.0)             
##  digest        0.6.18  2018-10-10 [1] CRAN (R 3.5.0)             
##  evaluate      0.13    2019-02-12 [1] CRAN (R 3.5.2)             
##  htmltools     0.3.6   2017-04-28 [1] CRAN (R 3.5.0)             
##  knitr         1.22    2019-03-08 [1] CRAN (R 3.5.2)             
##  magrittr      1.5     2014-11-22 [1] CRAN (R 3.5.0)             
##  Rcpp          1.0.1   2019-03-17 [1] standard (@1.0.1)          
##  rmarkdown     1.11    2018-12-08 [1] CRAN (R 3.5.0)             
##  sessioninfo   1.1.1   2018-11-05 [1] standard (@1.1.1)          
##  stringi       1.4.3   2019-03-12 [1] standard (@1.4.3)          
##  stringr       1.4.0   2019-02-10 [1] CRAN (R 3.5.2)             
##  withr         2.1.2   2018-03-15 [1] CRAN (R 3.5.0)             
##  xfun          0.5.2   2019-03-14 [1] Github (yihui/xfun@d882a87)
##  yaml          2.2.0   2018-07-25 [1] CRAN (R 3.5.0)             
## 
## [1] /Library/Frameworks/R.framework/Versions/3.5/Resources/library
```
