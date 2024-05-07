library(vegan)
library(ggplot2)
library(ape)
library(shiny)
# library(shinythemes)
library(ggbiplot)
library(shinydashboard)
library(DT)
shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Beta Diversity Plot", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                          sidebarPanel(tags$style( "#sider{overflow:auto;max-height: 100vh;}"  ),id="sider",
                                       width = 4,
                                       h2("Beta Diversity"),hr(),
                                       span("Download sample data ",a("here", href = "./beta.txt",download="beta.txt")),
                                       fileInput("file_abunt", label = "Sample abundance data"),
                                       span("Download sample data ",a("here", href = "./metadata.txt",download="metadata.txt")),
                                       fileInput("file_group", label = "Sample grouping data"),
                                       selectInput("plot_type", label = "PCA/PCoA/NMDS",
                                                   choices = list("PCA"="1", "PCoA"="2","NMDS"="3" ), 
                                                   selected = 2),
                                       conditionalPanel(condition="input.plot_type == '1'",
                                                        br(),
                                                        checkboxInput("ellipse", label = "Whether painting ellipse by group:", value = 1),
                                                        # checkboxInput("circle", label = "Whether painting circle by group", value = 0),
                                                        checkboxInput("addlabel", label = "Whether addinglabels", value = 1),
                                                        numericInput("labelposition", label = "Specify the location of the label:",value = 1.5),
                                                        numericInput("labelsize", label = "Choice the size of the label:",value = 2),
                                                        numericInput("scale", label = "Table scale size:",value = 1),
                                       ),    
                                       conditionalPanel(condition="input.plot_type == '2'",
                                                        br(),
                                                        selectInput("method",label = "Distance matrix",choices = c("bray","manhattan", "euclidean", "canberra", "clark", "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", "mountford", "raup", "binomial", "chao", "cao", "mahalanobis", "chisq" ,"chord"),selected = 1),
                                                        selectInput("anno",label = "Statistics analysis",choices = c("yes","no"),selected = 1), 
                                                        
                                                        
                                       ),   
                                       conditionalPanel(condition="input.plot_type == '3'",
                                                        br(),
                                                        # fileInput("nmdata", label = "Sample abundance data file input"),
                                                        # fileInput("nmdata.env", label = "Sample grouping data File input"),
                                                        # p("You can download sample data ",a("here", href = "./nmds.zip",download="nmds.zip")),
                                                        selectInput("standardization",label = "standardization methods",choices = c("total","max","frequency","normalize","range","standardize","pa","chi.square","hellinger","log"),selected = 1),
                                                        selectInput("distance",label = "Distance matrix",choices = c("manhattan", "euclidean", "canberra", "clark", "bray", "kulczynski", "jaccard", "gower", "altGower", "morisita", "horn", "mountford", "raup", "binomial", "chao", "cao", "mahalanobis", "chisq", "chord"),selected = 1),
                                                        # selectInput("anno",label = "statistics analysis",choices = c("yes","no"),selected = 1),
                                                        # selectInput("anno",label = "Statistics analysis",choices = c("yes","no"),selected = 1), 
                                                        
                                                        
                                       ),   
                                       
                                       actionButton("submit1", label = "Start"),
                          ),
                          mainPanel(
                            hr(),
                            conditionalPanel(
                              condition="input.plot_type == '1'",
                              plotOutput("PCA_plot"),#input$bheight,input$bwidth),
                            ),
                            conditionalPanel(
                              condition="input.plot_type == '2'",
                              plotOutput("PCoA_plot"),#input$bheight,input$bwidth),
                            ),
                            conditionalPanel(
                              condition="input.plot_type == '3'",
                              # plotOutput("NMDS_plot"),#input$bheight,input$bwidth),
                              plotOutput("nmds_plot"),
                              hr(),
                              textOutput('stress_value'),
                              # textOutput("pvalue"),
                              plotOutput("stress_plot"),
                            ),
                            
                            # plotOutput("PCoA_plot"),
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
                              p("The format of sample files for uploading is as follows."),
                              p("You can download ",a("abundance data", href = "./beta.txt",download="beta.txt"),' and ',a("meta data", href = "./metadata.txt",download="metadata.txt"),"."),
                              h3('Abundance data'),
                              datatable(read.table("./www/beta.txt",sep = "\t",header = TRUE),rownames = FALSE),
                              h3('Meta data'),span("The second column is group information, named 'Group'."),
                              datatable(read.table("./www/metadata.txt",sep = "\t",header = TRUE),rownames = FALSE)
                            )
                    ),
                    tabItem(tabName = "uguide",fluidPage(includeMarkdown("md_demo.Rmd"))),
                    tabItem(tabName = "contactus",fluidPage(includeMarkdown("contactus.Rmd"))),
                    tabItem(tabName = "bhome")
                  )
                )
  ) 

)