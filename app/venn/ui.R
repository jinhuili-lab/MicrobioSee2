library(shiny)
library(shinythemes)
library(venn)
library(shinydashboard)
library(DT)
library(RLumShiny)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Venn diagram", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h3("Venn diagram"),hr(),
                                       p("You can download sample data ",a("here", href = "./venn.csv",download="venn.csv")),
                                       fileInput("vfile1", label = h5("File input")),
                                       selectInput("vcolor", label = "Color:",
                                                   choices = list('bw', 'style','user-defined'='1'),
                                                   selected = "style"),
                                       numericInput("vopacity", label = "Opacity:",value="0.5",step ="0.1"),
                                       conditionalPanel(condition="input.vcolor == '1'",
                                                        # br(),
                                                        jscolorInput(inputId = "col1", label = "Color1:", 
                                                                     value = "#ff3333", position = "right", 
                                                                     mode = "HVS", close = TRUE),
                                                        jscolorInput(inputId = "col2", label = "Color2:", 
                                                                     value = "#ccff00", position = "right", 
                                                                     mode = "HVS", close = TRUE),
                                                        jscolorInput(inputId = "col3", label = "Color3:", 
                                                                     value = "#11AF6B", position = "right", 
                                                                     mode = "HVS", close = TRUE),
                                                        
                                       ), 
                                       hr(),
                                       actionButton("submit1", label=("Start")),
                                       # ),
                                       # 4
                          ) ,
                          mainPanel(
                            plotOutput("venn_plot"),
                            hr(),
                            div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                            p(),
                            downloadButton("download.pdf", label="pdf"),
                            downloadButton("download.png", label="png"),
                            downloadButton("download.jpeg", label="jpeg"),
                          ),fluid = TRUE
                        ))),
                    tabItem(tabName = "dformat",
                            fluidRow(
                              p("The sample file format for uploading is as follows."),
                              p("You can download sample data ",a("here", href = "./venn.csv",download="venn.csv"),'.'),
                              datatable(read.table("./www/venn.csv", sep = ","),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),
                    tabItem(tabName = "bhome")
                    
                  )
                ) 
  )
)