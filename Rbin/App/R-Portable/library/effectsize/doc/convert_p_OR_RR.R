## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(knitr)
options(knitr.kable.NA = "")
knitr::opts_chunk$set(comment = ">")
options(digits = 3)

## -----------------------------------------------------------------------------
library(effectsize)

odds_to_probs(13 / 4)

# or
odds_to_probs(3.25)

# convert back
probs_to_odds(0.764)

## -----------------------------------------------------------------------------
OR <- 3.5
baserate <- 0.85

(RR <- oddsratio_to_riskratio(OR, baserate))

## -----------------------------------------------------------------------------
riskratio_to_arr(RR, baserate)

## -----------------------------------------------------------------------------
oddsratio_to_arr(OR, baserate)

## -----------------------------------------------------------------------------
oddsratio_to_riskratio(OR, 0.04)

