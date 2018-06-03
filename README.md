
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tidysem <img src="man/figures/logo.png" width="160px" align="right" />

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

🎓 Tidy tools for
academics

## \*\*\* This package is in very early development. Feedback is encouraged\!\!\! \*\*\*

## Installation

<!-- You can install the released version of tidysem from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("tidysem")
```
-->

Install the development version from
[Github](https://github.com/mkearney/tidysem) with:

``` r
## install devtools if not already
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
## install tidysem from Github
devtools::install_github("mkearney/tidysem")
```

Load the package (it, of course, plays nicely with tidyverse).

``` r
## load tidyverse
library(tidyverse)

## load tidysem
library(tidysem)
```

## Latent variable models

### Structural equation modeling (SEM)

Conduct latent variable analysis using structural equation modeling.

``` r
## mutate data and then specify and estimate model
sem1 <- polcom %>%
  mutate(therm_2 = therm_2 / 10, 
    therm_1 = 10 - therm_1 / 10) %>%
  tidy_sem_model(news =~ news_1 + news_2 + news_3 + news_4 + news_5 + news_6,
    ambiv_sexism =~ ambiv_sexism_1 + ambiv_sexism_2 + ambiv_sexism_3 + 
      ambiv_sexism_4 + ambiv_sexism_5 + ambiv_sexism_6,
    partisan =~ a*therm_1 + a*therm_2,
    ambiv_sexism ~ age + sex + hhinc + edu + news + partisan) %>%
  tidy_sem()

## print model summary
sem1 %>%
  tidy_summary()
#> # A tidy model
#> Model formula  : news =~ news_1 + news_2 + news_3 + news_4 + news_5 + news_6
#>                  ambiv_sexism =~ ambiv_sexism_1 + ambiv_sexism_2 + ambiv_sexism_3 + ambiv_sexism_4 + 
#>                      ambiv_sexism_5 + ambiv_sexism_6
#>                  partisan =~ a * therm_1 + a * therm_2
#>                  ambiv_sexism ~ age + sex + hhinc + edu + news + partisan
#> Model type     : Structural Equation Model (SEM)
#> Model pkg::fun : lavaan::sem()
#> Model data     : 235 (observations) X 18 (variables)
#> $fit
#> fit_stat             n     df     estimate    p.value  stars
#> chisq              235    127     239.579      <.001   ***
#> aic                235      -       0.907       -         
#> bic                235      -       0.892       -         
#> cfi                235      -   16138.684       -         
#> tli                235      -   16256.310       -         
#> rmsea              235      -       0.061       -         
#> srmr               235      -       0.073       -         
#> R^2:ambiv_sexism   235      -       0.379       -         
#> 
#> $coef
#> term                               est       se    est.se    p.value  stars   std.est
#> news =~ news_1                   1.000    <.001      -          -               0.173
#> news =~ news_2                   1.592    0.722     2.204      0.028   *        0.340
#> news =~ news_3                   5.069    2.095     2.419      0.016   *        0.781
#> news =~ news_4                   5.587    2.312     2.417      0.016   *        0.851
#> news =~ news_5                   3.493    1.485     2.353      0.019   *        0.520
#> news =~ news_6                   1.255    0.683     1.838      0.066   +        0.196
#> ambiv_sexism =~ ambiv_sexism_1   1.000    <.001      -          -               0.825
#> ambiv_sexism =~ ambiv_sexism_2   0.942    0.067    14.043      <.001   ***      0.801
#> ambiv_sexism =~ ambiv_sexism_3   0.795    0.067    11.844      <.001   ***      0.706
#> ambiv_sexism =~ ambiv_sexism_4   0.743    0.064    11.647      <.001   ***      0.697
#> ambiv_sexism =~ ambiv_sexism_5   0.902    0.062    14.644      <.001   ***      0.825
#> ambiv_sexism =~ ambiv_sexism_6   0.904    0.064    14.185      <.001   ***      0.807
#> partisan =~ therm_1              1.000    <.001      -          -               0.577
#> partisan =~ therm_2              1.000    <.001      -          -               0.592
#> ambiv_sexism ~ age              -0.004    0.005    -0.824      0.410           -0.051
#> ambiv_sexism ~ sex              -0.271    0.130    -2.089      0.037   *       -0.130
#> ambiv_sexism ~ hhinc            -0.021    0.023    -0.878      0.380           -0.057
#> ambiv_sexism ~ edu              -0.088    0.069    -1.279      0.201           -0.083
#> ambiv_sexism ~ news              0.130    0.215     0.607      0.544            0.047
#> ambiv_sexism ~ partisan          0.347    0.069     5.032      <.001   ***      0.592
```
