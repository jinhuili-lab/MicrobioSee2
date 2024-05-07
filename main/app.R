library(shiny)
ui <- fluidPage(
  includeHTML("index.html"),
  #verbatimTextOutput("clickResult")
)

server <- function(input, output, session) {
  observeEvent(input$clickEvent, {
    app_to_launch <- input$clickEvent
    
    if (app_to_launch == "app1") {
      launch_app("../app/alpha/runShinyApp.R")
    } else if (app_to_launch == "app2") {
      launch_app("../app/beta/runShinyApp.R")
    } else if (app_to_launch == "app3") {
      launch_app("../app/venn/runShinyApp.R")
    } else if (app_to_launch == "app4") {
      launch_app("../app/upset/runShinyApp.R")
    } else if (app_to_launch == "app5") {
      launch_app("../app/volcano/runShinyApp.R")
    } else if (app_to_launch == "app6") {
      launch_app("../app/scatter/runShinyApp.R")
    } else if (app_to_launch == "app7") {
      launch_app("../app/heatmap/runShinyApp.R")
    } else if (app_to_launch == "app8") {
      launch_app("../app/histogram/runShinyApp.R")
    } else if (app_to_launch == "app9") {
      launch_app("../app/pie/runShinyApp.R")
    } else if (app_to_launch == "app10") {
      launch_app("../app/stack/runShinyApp.R")
    } else if (app_to_launch == "app11") {
      launch_app("../app/bubble_chart/runShinyApp.R")
    } else if (app_to_launch == "app12") {
      launch_app("../app/box/runShinyApp.R")
    }
    
    output$clickResult <- renderText(paste0("app", app_to_launch, "start!"))
  })
}

launch_app <- function(app_path) {
  r_path <- file.path(R.home("bin"), "Rscript.exe")
  current_dir <- getwd()
  cmd <- paste(r_path, " --no-save --no-environ --no-init-file --no-restore --no-Rconsole", app_path)
  system(cmd)
}

shinyApp(ui, server)