library(shiny)
library(shinythemes)
library(ggplot2)
library(shinydashboard)
library(DT)
shinyUI(fluidPage(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Histogram", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
                    menuItem("Data Format", tabName = "dformat", icon = icon("glyphicon glyphicon-th-list",lib="glyphicon")),
                    menuItem("Use Guide", tabName = "uguide", icon = icon("glyphicon glyphicon-question-sign",lib="glyphicon")),
                    menuItem("Bugs Feedback", tabName = "contactus", icon = icon("glyphicon glyphicon-envelope",lib="glyphicon")),
                    menuItem("Back Home", href = "https://microbiosee.gxu.edu.cn", newtab=FALSE,icon = icon("glyphicon glyphicon-new-window",lib="glyphicon"))
                  )),
                dashboardBody(
                  tabItems(
                    tabItem(
                      tabName = "Start",
                      fluidPage(
                        sidebarLayout(
                          sidebarPanel(tags$style( "#sider{overflow:auto;max-height: 100vh;}"  ),id="sider",#设置滚动
                                       width = 4,
                                       h2("Histogram"),
                                       p("You can download sample data ",a("here", href = "./histogram_chart.txt",download="histogram_chart.txt"),'.'),
                                       fileInput("hfile1", label = h5("File input")),
                                       checkboxInput("transpose1", label = "Transpose:", value = 1),
                                       checkboxInput("Sort1", label = "Sort:", value = 1),
                                       checkboxInput("datalabel", label = "Data label", value = 1),
                                       actionButton("submit1", label=("Start")),
                          ),
                          mainPanel(
                            plotOutput("histogram_plot"),
                            div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                            
                            p(),
                            downloadButton("download.pdf", label="pdf"),
                            downloadButton("download.png", label="png"),
                            downloadButton("download.jpeg", label="jpeg"),
                          ),fluid = TRUE
                        )
                      )),
                    tabItem(tabName = "dformat",
                            fluidRow(
                              p("The sample file format for uploading is as follows."),
                              p("You can download sample data ",a("here", href = "./histogram_chart.txt",download="histogram_chart.txt"),'.'),
                              datatable(read.table("./www/histogram_chart.txt", sep = "\t",header = T),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),
                    tabItem(tabName = "bhome")
                  )
                )
  ) 
)
)