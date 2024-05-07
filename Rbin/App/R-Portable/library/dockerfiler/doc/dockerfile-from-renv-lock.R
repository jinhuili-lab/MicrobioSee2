## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(dockerfiler)

## ----example-dock_from_renv---------------------------------------------------
#' \dontrun{
#' dock <- dock_from_renv("renv.lock", distro = "xenial")
#' dock$write("Dockerfile")
#' }

