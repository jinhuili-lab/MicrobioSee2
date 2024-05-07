## ----setup, include=FALSE-----------------------------------------------------
# knitr::opts_chunk$set(eval = TRUE, results = 'hide')
Sys.setenv(R_CONFIG_ACTIVE = "default")

## ---- include=FALSE-----------------------------------------------------------
knitr::knit_engines$set(yaml = function(options) {
  code <- paste(options$code, collapse = "\n")
  options$results <- "hide"
  varname <- options$output.var
  if (!is.null(varname)) {
    assign(varname, code, envir = knitr::knit_global())
  }
  knitr::engine_output(options, code, out = code)
}
                          )

set_codeblock_label <- function(x) {
  sprintf("<p class = 'codeblock-label'>%s</p>", x)
}

knitr::knit_hooks$set(codeblock_label = function(before, options, name) {
  if (before) {
    if (is.character(options[[name]])) {
      set_codeblock_label(options[[name]])
    } else if (options$engine == "yaml") {
      set_codeblock_label("config.yml")
    } else {
      set_codeblock_label(options$engine)
    }
  }
})

knitr::knit_hooks$set(with_config = local({
  old_envvars <- NA
  function(before, options) {
    if (before) {
      config_yml <- base::get(options$config_yml, envir = knitr::knit_global())
      .config_file <- config:::write_yaml_as_file(config_yml)
      new_envvars <- .config_file
      old_envvars <<- config:::keep_old_envvars(new_envvars)
      config:::set_new_envvars(new_envvars)
    } else {
      config:::reset_envvars(old_envvars)
    }
  }
}))

knitr::opts_chunk$set(
  codeblock_label = TRUE
)

## ---- with_config=TRUE, config_yml="config_yaml"------------------------------
config <- config::get()
config$trials
config$dataset

## ---- with_config=TRUE, config_yml="config_yaml"------------------------------
config::get("trials")
config::get("dataset")

## ---- with_config=TRUE, config_yml="config_yaml"------------------------------
# set the active configuration globally via Renviron.site or Rprofile.site
Sys.setenv(R_CONFIG_ACTIVE = "production")

# read configuration value (will return 30 from the "production" config)
config::get("trials")

## ---- with_config=TRUE, config_yml="config_yaml"------------------------------
config::is_active("production")

## -----------------------------------------------------------------------------
Sys.setenv(R_CONFIG_ACTIVE = "default")

## ---- eval=FALSE--------------------------------------------------------------
#  config <- config::get(file = "conf/config.yml")

## ---- eval=FALSE--------------------------------------------------------------
#  config <- config::get(file = "conf/config.yml", use_parent = FALSE)

