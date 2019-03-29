---
title: "Final results report for the mtcars example"
author: You
output: html_document
---

# The weight and fuel efficiency of cars

Is there an association between the weight and the fuel efficiency of cars? To find out, we use the `mtcars` dataset from the `datasets` package. The `mtcars` data originally came from the 1974 Motor Trend US magazine, and it contains design and performance data on 32 models of automobile.


```r
# ?mtcars # more info
head(mtcars)
```

```
##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

Here, `wt` is weight in tons, and `mpg` is fuel efficiency in miles per gallon. We want to figure out if there is an association between `wt` and `mpg`. The `mtcars` dataset itself only has 32 rows, so we generated two larger bootstrapped datasets. We called them `small` and `large`.


```r
library(drake)
head(readd(small)) # 48 rows
```

```
##       x    y
## 1 5.424 10.4
## 2 3.440 17.8
## 3 3.440 19.2
## 4 3.170 15.8
## 5 3.730 17.3
## 6 3.845 19.2
```

```r
loadd(large)       # 64 rows
head(large)
```

```
##       x    y
## 1 3.170 15.8
## 2 5.345 14.7
## 3 4.070 16.4
## 4 1.615 30.4
## 5 3.170 15.8
## 6 1.513 30.4
```

Then, we fit a couple regression models to the `small` and `large` to try to detect an association between `wt` and `mpg`. Here are the coefficients and p-values from one of the model fits.


```r
readd(coef_regression2_small)
```

```
##               Estimate Std. Error   t value     Pr(>|t|)
## (Intercept) 27.8369441 1.07966324 25.782988 5.443436e-29
## x2          -0.6359335 0.07138918 -8.907981 1.408597e-11
```

Since the p-value on `x2` is so small, there may be an association between weight and fuel efficiency after all.

# A note on knitr reports in drake projects.

Because of the calls to `readd()` and `loadd()`, `drake` knows that `small`, `large`, and `coef_regression2_small` are dependencies of this R Markdown report. This dependency relationship is what causes the report to be processed at the very end.
