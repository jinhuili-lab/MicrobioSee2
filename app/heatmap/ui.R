library(shiny)
library(shinythemes)
library(pheatmap)
library(DT)
library(shinydashboard)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Heatmap", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h2("Heatmap"),hr(),
                                       # file,scale,cluster_rows,cluster_cols,clustering_method,border,display_numbers,main,show_colnames,show_rownames,fontsize_number,fontsize
                                       p("You can download sample data ",a("here", href = "./heatmap.txt",download="heatmap.txt"),'.'),
                                       fileInput("hfile", label = "File input"),
                                       selectInput("hscale", label = "Scale",
                                                   choices = list("row","column","none"), 
                                                   selected = 1),
                                       checkboxInput("hcluster_rows", label = "Cluster_rows", value = TRUE),
                                       checkboxInput("hcluster_cols", label = "Cluster_cols", value = TRUE),
                                       selectInput("hclustering_method", label = "Clustering_method",
                                                   choices = list("ward.D","ward.D2","single","complete","average","mcquitty","median","centroid"), 
                                                   selected = 1),
                                       checkboxInput("hborder", label = "Border", value = TRUE),
                                       textInput("hmain", label = "Main title", value = "text gene"),
                                       checkboxInput("hshow_colnames", label = "Show_colnames", value = TRUE),
                                       checkboxInput("hshow_rownames", label = "Show_rownames", value = TRUE),
                                       checkboxInput("hdisplay_numbers", label = "display_numbers", value = TRUE),
                                       numericInput("hfontsize_number", label = "fontsize_number", value = 5),
                                       numericInput("hfontsize", label = "Fontsize", value = 7),
                                       hr(),
                                       actionButton("submit1", label = "Start"),
                          ),
                          mainPanel(
                            hr(),
                            plotOutput("heatmap_plot"),
                            div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                            p(),
                            downloadButton("download.pdf", label="pdf"),
                            downloadButton("download.png", label="png"),
                            downloadButton("download.jpeg", label="jpeg"),
                          ),fluid = TRUE
                        ),
                      )
                    ), tabItem(tabName = "dformat",
                               fluidRow(
                                 p("The sample file format for uploading is as follows."),
                                 p("You can download sample data ",a("here", href = "./heatmap.txt",download="heatmap.txt"),'.'),
                                 datatable(read.table("./www/heatmap.txt", sep = "\t"),rownames = FALSE)
                               )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),
                    tabItem(tabName = "bhome")
                  )
                )
  ) 
)