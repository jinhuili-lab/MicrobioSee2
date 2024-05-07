## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(effectsize)
options(es.use_symbols = TRUE) # get nice symbols when printing! (On Windows, requires R >= 4.2.0)

cohens_d(mpg ~ am, data = mtcars)

## -----------------------------------------------------------------------------
M <- rbind(
  c(150, 130, 35, 55),
  c(100, 50, 10, 40),
  c(165, 65, 2, 25)
)

cramers_v(M)

## -----------------------------------------------------------------------------
model <- lm(mpg ~ cyl * am,
  data = mtcars
)

datawizard::standardize(model)

parameters::standardize_parameters(model)

## -----------------------------------------------------------------------------
model <- glm(am ~ cyl + hp,
  family = "binomial",
  data = mtcars
)

parameters::standardize_parameters(model, exponentiate = TRUE)

## -----------------------------------------------------------------------------
options(contrasts = c("contr.sum", "contr.poly"))

data("ChickWeight")
# keep only complete cases and convert `Time` to a factor
ChickWeight <- subset(ChickWeight, ave(weight, Chick, FUN = length) == 12)
ChickWeight$Time <- factor(ChickWeight$Time)

model <- aov(weight ~ Diet * Time + Error(Chick / Time),
  data = ChickWeight
)

eta_squared(model, partial = TRUE)

eta_squared(model, generalized = "Time")

## -----------------------------------------------------------------------------
F_to_eta2(
  f = c(40.72, 33.77),
  df = c(2, 1), df_error = c(18, 9)
)

t_to_d(t = -5.14, df_error = 22)

t_to_r(t = -5.14, df_error = 22)

## -----------------------------------------------------------------------------
data(hardlyworking, package = "effectsize")

aov1 <- oneway.test(salary ~ n_comps,
  data = hardlyworking, var.equal = TRUE
)
effectsize(aov1)

xtab <- rbind(c(762, 327, 468), c(484, 239, 477), c(484, 239, 477))
Xsq <- chisq.test(xtab)
effectsize(Xsq)

## -----------------------------------------------------------------------------
r_to_d(0.7)

d_to_oddsratio(1.96)

oddsratio_to_riskratio(34.99, p0 = 0.4)

oddsratio_to_r(34.99)

## -----------------------------------------------------------------------------
interpret_cohens_d(c(0.02, 0.52, 0.86), rules = "cohen1988")

