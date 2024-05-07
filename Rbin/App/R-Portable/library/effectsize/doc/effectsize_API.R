## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(knitr)
knitr::opts_chunk$set(
  comment = ">",
  warning = FALSE,
  message = FALSE
)
options(digits = 2)
options(knitr.kable.NA = "")

set.seed(333)

## -----------------------------------------------------------------------------
library(effectsize)

## -----------------------------------------------------------------------------
min_aov <- data.frame(
  Parameter = c("(Intercept)", "A", "B", "Residuals"),
  Sum_Squares = c(30, 40, 10, 100),
  df = c(1, 1, 2, 50)
)

## -----------------------------------------------------------------------------
.es_aov_simple(
  min_aov,
  type = "eta", partial = TRUE, generalized = FALSE,
  include_intercept = FALSE,
  ci = 0.95, alternative = "greater",
  verbose = TRUE
)

## -----------------------------------------------------------------------------
min_aovlist <- data.frame(
  Group = c("S", "S", "S:A", "S:A"),
  Parameter = c("(Intercept)", "Residuals", "A", "Residuals"),
  Sum_Squares = c(34, 21, 34, 400),
  df = c(1, 12, 4, 30)
)

## -----------------------------------------------------------------------------
.es_aov_strata(
  min_aovlist,
  DV_names = c("S", "A"),
  type = "omega", partial = TRUE, generalized = FALSE,
  ci = 0.95, alternative = "greater",
  verbose = TRUE,
  include_intercept = TRUE
)

## -----------------------------------------------------------------------------
min_anova <- data.frame(
  Parameter = c("(Intercept)", "A", "B"),
  F = c(4, 7, 0.7),
  df = c(1, 1, 2),
  df_error = 34
)

## -----------------------------------------------------------------------------
.es_aov_table(
  min_anova,
  type = "eta", partial = TRUE, generalized = FALSE,
  include_intercept = FALSE,
  ci = 0.95, alternative = "greater",
  verbose = TRUE
)

## -----------------------------------------------------------------------------
mod <- lm(mpg ~ factor(cyl) + am, mtcars)

class(mod) <- "superMODEL"

## -----------------------------------------------------------------------------
.anova_es.superMODEL <- function(model, ...) {
  # Get ANOVA table
  anov <- suppressWarnings(stats:::anova.lm(model))
  anov <- as.data.frame(anov)

  # Clean up
  anov[["Parameter"]] <- rownames(anov)
  colnames(anov)[2:1] <- c("Sum_Squares", "df")

  # Pass
  out <- .es_aov_simple(anov, ...)

  # Set attribute
  attr(out, "anova_type") <- 1

  out
}

## ----echo=FALSE---------------------------------------------------------------
# This is for: https://github.com/easystats/easystats/issues/348
.anova_es.superMODEL <<- .anova_es.superMODEL

## -----------------------------------------------------------------------------
eta_squared(mod)

eta_squared(mod, partial = FALSE)

omega_squared(mod)

# Etc...

