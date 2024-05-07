library(shiny)
library(shinythemes)
library(ggplot2)
library(RLumShiny)
library(shinyBS)
library(shinydashboard)
library(DT)
# library(rmarkdown)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Box Plot", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h3("Box plot"),hr(),
                                       # 输入文件
                                       fileInput("bfile", label = "File input"),
                                       p("You can download sample data ",a("here", href = "./box.txt",download="box.txt"),'.'),
                                       textInput("xname", label = "xlab", value = "cyl"),
                                       textInput("yname", label = "ylab", value = "mpg"),
                                       # title设置,main在boxplot中指的是title
                                       textInput("main", label = "title", value = "test"),
                                       # 是否设置凹痕
                                       checkboxInput("notch", label = "notch", value = FALSE),
                                       # 水平设置
                                       checkboxInput("horizontal", label = "horizontal", value = FALSE),
                                       ####颜色设置
                                       # h5("color",bsButton("color1b", label="?",  style="info", size="small")),
                                       bsPopover("color1b", 'Set the color of three box', trigger = "focus"),
                                       jscolorInput("color1", label = NULL, value = "#70CBFF"),
                                       jscolorInput("color2", label = NULL, value = "#C273FF"),
                                       jscolorInput("color3", label = NULL, value = "#FF0A0A"),
                                       div(style="display:inline-block",numericInput("bheight", label = "height input", value = 800)),
                                       div(style="display:inline-block",numericInput("bwidth", label = "width input", value = 800)),
                                       # 高度输入
                                       # h4("try",bsButton("try1",label = "?",style = "info",size = "small"),),
                                       # bsPopover("try1",'QAQ',trigger = "focus"),
                                       # textInput("try", label = NULL, value = 800),
                                       # 宽度输入
                                       hr(),
                                       # 开始按???
                                       actionButton("submit1", label = "Start"),
                          ),
                          mainPanel(
                            #创建下载按钮
                            hr(),
                            plotOutput("box_plot"),
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
                              p("You can download sample data ",a("here", href = "./box.txt",download="box.txt"),'.'),
                              datatable(read.table("./www/box.txt", sep = ","),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),                    
tabItem(tabName = "bhome")
                  )
                )
  ) 
)


