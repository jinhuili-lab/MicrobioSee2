## ----cite---------------------------------------------------------------------
citation("correlation")

## ---- include=FALSE-----------------------------------------------------------
library(knitr)
options(
  knitr.kable.NA = "",
  digits = 2,
  out.width = "100%",
  message = FALSE,
  warning = FALSE,
  dpi = 450
)

if (!requireNamespace("ggplot2", quietly = TRUE) ||
  !requireNamespace("BayesFactor", quietly = TRUE) ||
  !requireNamespace("lme4", quietly = TRUE)) {
  knitr::opts_chunk$set(eval = FALSE)
}

## -----------------------------------------------------------------------------
library(correlation)

data <- simulate_simpson(n = 100, groups = 10)

summary(data)

## -----------------------------------------------------------------------------
library(ggplot2)

ggplot(data, aes(x = V1, y = V2)) +
  geom_point() +
  geom_smooth(colour = "black", method = "lm", se = FALSE) +
  theme_classic()

## -----------------------------------------------------------------------------
correlation(data)

## -----------------------------------------------------------------------------
library(ggplot2)

ggplot(data, aes(x = V1, y = V2)) +
  geom_point(aes(colour = Group)) +
  geom_smooth(aes(colour = Group), method = "lm", se = FALSE) +
  geom_smooth(colour = "black", method = "lm", se = FALSE) +
  theme_classic()

## -----------------------------------------------------------------------------
correlation(data, multilevel = TRUE)

## -----------------------------------------------------------------------------
correlation(data, multilevel = TRUE, bayesian = TRUE)

