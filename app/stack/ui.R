library(shinythemes)
library(shiny)
library(stringr)
library(shinyBS)
library(DT)
library(shinydashboard)
library(reshape2)
library(ggplot2)
library(dbplyr)
library(plyr)
library(dplyr)
# library(tidyverse)
# library(ggthemes)
library(ggsci)
library(dplyr)
library(ggplot2)
library(reshape2)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Stack column charts", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h3("Stack column charts"),hr(),
                                       fileInput("sfile", label = h5("File input:")),
                                       p("You can download sample data ",a("here", href = "./stack.txt",download="stack.txt")),
                                       selectInput("sline", label = h5("Straight or curve"), 
                                                   choices = list("straight", "curve","none"), 
                                                   selected = "curve"),
                                       selectInput("stheme", label = h5("Theme:"), 
                                                   choices = list("bw", "classic", "economist", "fivethirtyeight", "map", "base", "wsj", "dark"), 
                                                   selected = "bw"),
                                       selectInput("scolor", label = h5("Color:"), 
                                                   choices = list("npg", "nejm", "lancet", "rickandmorty", "tron", "grey"), 
                                                   selected = "npg"),
                                       
                                       actionButton("submit1", label=("start")),
                          ),
                          mainPanel(
                           
                            plotOutput("stacks"),
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
                              p("You can download sample data ",a("here", href = "./stack.txt",download="stack.txt"),'.'),
                              datatable(read.table("./www/stack.txt", sep = "\t"),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),
                    tabItem(tabName = "bhome")
                  )
                )
  ) 
)
