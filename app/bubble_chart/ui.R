library(shiny)
library(shinythemes)
library(ggplot2)
library(shinydashboard)
library(DT)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Bubble Chart", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h2("Bubble Chart"),hr(),
                                       fileInput("bfile1", label = h5("File input")),
                                       p("You can download sample data.",a("here", href = "./bubble_chart.txt",download="bubble_chart.txt")),
                                       
                                       textInput("x", label = "Select the parameter in the table as the x-axis", value = "clarity"),
                                       textInput("y", label = "Select the parameter in the table as the y-axis", value = "depth"),
                                       textInput("size", label = "bubble size based on which parameter", value = "carat"),
                                       textInput("color", label = "color based on which parameter", value = "color"),
                                       textInput("title", label = "title of table", value = "test"),
                                       hr(),
                                       actionButton("submit1", label=("Start")),
                          ),
                          mainPanel(
                            hr(),
                            plotOutput("Bubble_plot"),
                            div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                            p(),
                            downloadButton("download.pdf", label="pdf"),
                            downloadButton("download.png", label="png"),
                            downloadButton("download.jpeg", label="jpeg"),
                          )
                        )
                      )),
                    tabItem(tabName = "dformat",
                            fluidRow(
                              p("The sample file format for uploading is as follows."),
                              p("You can download sample data ",a("here", href = "./bubble_chart.txt",download="bubble_chart.txt"),'.'),
                              datatable(read.table("./www/bubble_chart.txt", sep = ","),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "bhome")
                  )
                )
  ) 
)
