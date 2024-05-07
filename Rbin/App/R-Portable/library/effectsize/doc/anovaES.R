## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(knitr)
options(knitr.kable.NA = "")
options(digits = 2)
knitr::opts_chunk$set(comment = ">", warning = FALSE)

set.seed(1)


.eval_if_requireNamespace <- function(...) {
  pkgs <- c(...)
  knitr::opts_chunk$get("eval") && all(sapply(pkgs, requireNamespace, quietly = TRUE))
}

knitr::opts_chunk$set(eval = .eval_if_requireNamespace("effectsize", "afex"))

## -----------------------------------------------------------------------------
data(obk.long, package = "afex")
# modify the data slightly for the demonstration:
obk.long <- obk.long[1:240 %% 3 == 0, ]
obk.long$id <- seq_len(nrow(obk.long))

m <- lm(value ~ treatment, data = obk.long)

parameters::model_parameters(m)

## -----------------------------------------------------------------------------
parameters::model_parameters(anova(m))

## -----------------------------------------------------------------------------
library(effectsize)
options(es.use_symbols = TRUE) # get nice symbols when printing! (On Windows, requires R >= 4.2.0)


eta_squared(m, partial = FALSE)

## -----------------------------------------------------------------------------
m <- lm(value ~ gender + phase + treatment, data = obk.long)

eta_squared(m, partial = FALSE)

eta_squared(m) # partial = TRUE by default

## ----eval=.eval_if_requireNamespace("car")------------------------------------
eta_squared(car::Anova(m, type = 2), partial = FALSE)

eta_squared(car::Anova(m, type = 3)) # partial = TRUE by default

## ----eval=.eval_if_requireNamespace("car")------------------------------------
# compare
m_interaction1 <- lm(value ~ treatment * gender, data = obk.long)

# to:
m_interaction2 <- lm(
  value ~ treatment * gender,
  data = obk.long,
  contrasts = list(
    treatment = "contr.sum",
    gender = "contr.sum"
  )
)

eta_squared(car::Anova(m_interaction1, type = 3))
eta_squared(car::Anova(m_interaction2, type = 3))

## -----------------------------------------------------------------------------
library(afex)
m_afex <- aov_car(value ~ treatment * gender + Error(id), data = obk.long)

eta_squared(m_afex)

## -----------------------------------------------------------------------------
omega_squared(m_afex)

epsilon_squared(m_afex)

## -----------------------------------------------------------------------------
eta_squared(m_afex, generalized = "gender")

## -----------------------------------------------------------------------------
cohens_f(m_afex)

## ----eval=.eval_if_requireNamespace("lmerTest", "lme4")-----------------------
library(lmerTest)

fit_lmm <- lmer(Reaction ~ Days + (Days | Subject), sleepstudy)

anova(fit_lmm) # note the type-3 errors

F_to_eta2(45.8, df = 1, df_error = 17)

## ----eval=.eval_if_requireNamespace("lmerTest", "lme4")-----------------------
eta_squared(fit_lmm)
epsilon_squared(fit_lmm)
omega_squared(fit_lmm)

## ----eval = .eval_if_requireNamespace("rstanarm", "bayestestR", "car")--------
library(rstanarm)

m_bayes <- stan_glm(value ~ gender + phase + treatment,
  data = obk.long, family = gaussian(),
  refresh = 0
)

## ----eval = .eval_if_requireNamespace("rstanarm", "bayestestR", "car")--------
pes_posterior <- eta_squared_posterior(m_bayes,
  draws = 500, # how many samples from the PPD?
  partial = TRUE, # partial eta squared
  # type 3 SS
  ss_function = car::Anova, type = 3,
  verbose = FALSE
)

head(pes_posterior)

bayestestR::describe_posterior(pes_posterior,
  rope_range = c(0, 0.1), test = "rope"
)

## ----eval = .eval_if_requireNamespace("rstanarm", "bayestestR", "car")--------
m_ML <- lm(value ~ gender + phase + treatment, data = obk.long)

eta_squared(car::Anova(m_ML, type = 3))

## -----------------------------------------------------------------------------
group_data <- list(
  g1 = c(2.9, 3.0, 2.5, 2.6, 3.2), # normal subjects
  g2 = c(3.8, 2.7, 4.0, 2.4), # with obstructive airway disease
  g3 = c(2.8, 3.4, 3.7, 2.2, 2.0) # with asbestosis
)

kruskal.test(group_data)

rank_epsilon_squared(group_data)

rank_eta_squared(group_data)

## -----------------------------------------------------------------------------
# Subjects are COLUMNS
(ReactionTimes <- matrix(
  c(
    398, 338, 520,
    325, 388, 555,
    393, 363, 561,
    367, 433, 470,
    286, 492, 536,
    362, 475, 496,
    253, 334, 610
  ),
  nrow = 7, byrow = TRUE,
  dimnames = list(
    paste0("Subject", 1:7),
    c("Congruent", "Neutral", "Incongruent")
  )
))

friedman.test(ReactionTimes)

kendalls_w(ReactionTimes)

