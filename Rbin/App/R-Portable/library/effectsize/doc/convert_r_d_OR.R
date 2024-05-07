## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(knitr)
options(knitr.kable.NA = "")
knitr::opts_chunk$set(comment = ">")
options(digits = 3)

.eval_if_requireNamespace <- function(...) {
  pkgs <- c(...)
  knitr::opts_chunk$get("eval") && all(sapply(pkgs, requireNamespace, quietly = TRUE))
}

## -----------------------------------------------------------------------------
library(effectsize)
data("hardlyworking")
head(hardlyworking)

## -----------------------------------------------------------------------------
cohens_d(salary ~ is_senior, data = hardlyworking)

## ----warning=FALSE, eval=.eval_if_requireNamespace("correlation")-------------
correlation::cor_test(hardlyworking, "salary", "is_senior")

## -----------------------------------------------------------------------------
d_to_r(-0.72)

## -----------------------------------------------------------------------------
fit <- lm(salary ~ is_senior + xtra_hours, data = hardlyworking)

parameters::model_parameters(fit)

# A couple of ways to get partial-d:
1683.65 / sigma(fit)
t_to_d(5.31, df_error = 497)[[1]]

## ----eval=.eval_if_requireNamespace("correlation")----------------------------
t_to_r(5.31, df_error = 497)

correlation::correlation(hardlyworking[, c("salary", "xtra_hours", "is_senior")],
  include_factors = TRUE,
  partial = TRUE
)[2, ]

# all close to:
d_to_r(0.47)

## -----------------------------------------------------------------------------
# 1. Set a threshold
thresh <- 22500

# 2. dichotomize the outcome
hardlyworking$salary_high <- hardlyworking$salary < thresh

# 3. Fit a logistic regression:
fit <- glm(salary_high ~ is_senior,
  data = hardlyworking,
  family = binomial()
)

parameters::model_parameters(fit)

# Convert log(OR) (the coefficient) to d
oddsratio_to_d(-1.22, log = TRUE)

