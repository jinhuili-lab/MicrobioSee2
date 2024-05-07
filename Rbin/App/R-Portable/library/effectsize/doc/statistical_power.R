## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE,
  eval = requireNamespace("pwr", quietly = TRUE)
)

options(digits = 4L, knitr.kable.NA = "")

set.seed(123)

## -----------------------------------------------------------------------------
library(pwr)
library(effectsize)

## -----------------------------------------------------------------------------
t <- t.test(mpg ~ am, data = mtcars)

## ----eval = FALSE-------------------------------------------------------------
#  pwr.t2n.test(
#    n1 = ..., n2 = ...,
#    d = ...,
#    sig.level = ...,
#    power = ...,
#    alternative = ...
#  )

## ----eval = FALSE-------------------------------------------------------------
#  t_alt <- t.test(mtcars$mpg[mtcars$am == 0], mtcars$mpg[mtcars$am == 1])
#  
#  effectsize(t_alt, type = "cohens_d")

## ----eval = FALSE-------------------------------------------------------------
#  cohens_d(mpg ~ am, data = mtcars)

## -----------------------------------------------------------------------------
t_to_d(
  t = t$statistic,
  df_error = t$parameter
)

## -----------------------------------------------------------------------------
(result <- cohens_d(mpg ~ am, data = mtcars))
(Ns <- table(mtcars$am))

pwr.t2n.test(
  n1 = Ns[1], n2 = Ns[2],
  d = result[["Cohens_d"]],
  sig.level = 0.05,
  alternative = "two.sided"
)

