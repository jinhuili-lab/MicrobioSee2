library(shiny)
library(shinythemes)
library(ggplot2)
library(shinydashboard)
library(DT)
shinyUI(  dashboardPage(skin = "purple",
                        dashboardHeader(title = "MicrobioSee"),
                        dashboardSidebar(
                          sidebarMenu(
                            menuItem("Scatter Diagram", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                               h3("Scatter Diagram"),hr(),
                                               fileInput("file_input", label = "File input"),
                                               p("You can download sample data ",a("here", href = "./defult.csv",download="defult.csv")),
                                               # scale设置
                                               
                                               textInput("xlabel", label = "xlabel", value = 'xlabel'),
                                               textInput("ylabel", label = "ylabel", value = 'ylabel'),
                                               textInput("groups", label = "groups", value = 'groups'),
                                               textInput("input", label = "What to choose as a label for the scattered points", value = 'ylabel'),
                                               checkboxInput("addtext", label = "whether add text label", value = TRUE),
                                               hr(),
                                               
                                               #GO按键
                                               actionButton("submit1", label = "Start"),
                                               
                                               
                                  ),
                                  mainPanel(
                                    
                                    hr(),
                                    plotOutput("scatter_plot"),
                                    div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                                    div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                                    div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                                    p(),
                                    downloadButton("download.pdf", label="pdf"),
                                    downloadButton("download.png", label="png"),
                                    downloadButton("download.jpeg", label="jpeg")
                                    
                                    
                                  ),fluid = TRUE
                                )
                              )),
                            tabItem(tabName = "dformat",
                                    fluidRow(
                                      p("The sample file format for uploading is as follows."),
                                      p("You can download sample data ",a("here", href = "./defult.csv",download="defult.csv"),'.'),
                                      datatable(read.table("./www/defult.csv", sep = ","),rownames = FALSE)
                                    )
                            ),
                            tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                            tabItem(tabName = "bhome")
                          )
                        )
) 
)

