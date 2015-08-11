---
title       : Comparison of KNN, C4.5 and C5.0 classification methods
subtitle    : (mainly for visualization purpose)
author      : Chau Nguyen
job         : UET, VNU
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
url         :
    libraries: ../libraries
    assets: ../assets
---

## Slide 2
- Issue 1
- Issue 2

```r
y = rnorm(100)
x1 = runif(100)
x2 = rpois(100, 5)
x3 = rexp(100)
fit <- lm(y ~ x1 + x2 + x3)
# summary(fit)
```

--- .intro #1

## Slide 2

```
## 
## Call:
## lm(formula = y ~ x1 + x2 + x3)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -3.3188 -0.5718 -0.0998  0.5335  2.5951 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)  
## (Intercept) -0.36844    0.30475  -1.209   0.2296  
## x1           0.85774    0.34882   2.459   0.0157 *
## x2           0.00822    0.03824   0.215   0.8303  
## x3           0.01773    0.07700   0.230   0.8184  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.9165 on 96 degrees of freedom
## Multiple R-squared:  0.05936,	Adjusted R-squared:  0.02997 
## F-statistic: 2.019 on 3 and 96 DF,  p-value: 0.1163
```

--- 
