library(shiny)
library(shinythemes)
library(UpSetR) 
library(plyr)
library(ggplot2)
library(shinydashboard)
library(DT)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Upset Plot", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h3("Upset plot"),hr(),
                                       p("You can download sample data ",a("here", href = "./upset.csv",download="upset.csv")),
                                       fileInput("ufile1", label = h5("File input")),
                                       textInput("ucomparison", label = "Set the columns that need to be displayed", value = "2,4,5,6,9,10,11"),
                                       textInput("uylabel", label = "mainbar_y_label",value="mainbarlabel"),
                                       textInput("uxlabel", label = "sets_x_label",value="setslabel"),
                                       actionButton("submit1", label=("Go!")),
                          ),
                          mainPanel(
                            plotOutput("upset_plot"),
                            hr(),
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
                              p("You can download sample data ",a("here", href = "./upset.csv",download="upset.csv"),'.'),
                              datatable(read.table("./www/upset.csv", sep = ","),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),                    
                    tabItem(tabName = "bhome")
                  )
                )
  ) 
)
