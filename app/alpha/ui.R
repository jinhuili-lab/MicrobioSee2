library(shiny)
library(yarrr)
library(shinyBS)
library(shinydashboard)
library(DT)
library(ggplot2)
library(see)
library(amplicon)
library(markdown)

shinyUI(
  dashboardPage(skin = "purple",
                dashboardHeader(title = "MicrobioSee v2.0.1"),
                dashboardSidebar(
                  sidebarMenu(
                    menuItem("Alpha Plot", tabName = "Start", icon = icon("glyphicon glyphicon-signal",lib="glyphicon")),
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
                                       h2("Alpha Plot"),hr(),
                                       # 输入文件
                                       span("Download alpha data ",a("here", href = "./alpha.txt",download="alpha.txt"),"."),
                                       fileInput("file_alpha", label = "Input alpha diversity result:"),
                                       span("Download meta data ",a("here", href = "./metadata.txt",download="metadata.txt"),"."),
                                       fileInput("file_meta", label = "Input metadata file:"),
                                       numericInput("alpha", label = "Select the alpha diversity result:",value = 2),
                                       selectInput("tt", label = "Statistical method:",
                                                   choices = list("T-test/ANOVA" , "Kruskal-Wallis" ), 
                                                   selected = 1),
                                       selectInput("plot_type",label = "Select plot type:",c("box-plot" = "1", "pirates" = "2","cloudyrain" = "3","violin"="4")),
                                       conditionalPanel(condition="input.plot_type == '1'",
                                                        br(),
                                       ),             
                                       conditionalPanel(condition="input.plot_type == '2'",
                                                        selectInput("ppal", label = "Pal:",
                                                                    choices = list("basel" , "pony" ,"xmen","decision","southpark","google","eternal","evildead","usualsuspects","ohbrother","appletv","brave","bugs","cars","nemo","rat","up","espresso","ipod","info","info2"), 
                                                                    selected = 1),
                                                        selectInput("ptheme", label = "Theme:",
                                                                    choices = list( "1" ,"2","3","4"), 
                                                                    selected = 3),
                                                        selectInput("pinf", label = "Inf.method:",
                                                                    choices = list("hdi" , "ci" ,"iqr"), 
                                                                    selected = 1),
                                                        
                                       ),
                                       conditionalPanel(condition="input.plot_type == '3'",
                                                        
                                                        # dotposition=-.2,
                                                        # dotsize= .25,
                                                        # dotbinwidth = .01
                                                        # boxwidth = .1
                                                        # boxposition = -.1
                                                        numericInput("dotposition", label = "Select your dots position:",value = -.2,step=0.1),
                                                        numericInput("dotsize", label = "Select your dots size:",value = .25,step=0.1),
                                                        numericInput("dotbinwidth", label = "Select your width between dots:",value = .01,step=0.1),
                                                        numericInput("boxwidth", label = "Select your box width:",value = .1,step=0.1),
                                                        numericInput("boxposition", label = "Select your box position:",value = -.1),
                                                        checkboxInput("transpose", label = "Transpose:", value = 0),
                                                        hr(),
                                       ),
                                       
                                       conditionalPanel(condition="input.plot_type == '4'",
                                                        # fileInput("file_alpha", label = "Input alpha diversity result"),
                                                        # numericInput("alpha", label = "Select the alpha diversity results you want to plot",value = 2),
                                                        # fileInput("file_meta", label = "Input metadata file"),
                                                        # numericInput("meta", label = "Select your grouping information",value = 2),
                                                        # selectInput("tt", label = "Statistical method",
                                                        #             choices = list("T-test/ANOVA" , "Kruskal-Wallis" ), 
                                                        #             selected = 1),
                                                        # textInput("mysubtitle", label = "title", value = "example"),
                                                        textInput("xlabel", label = "xlabel", value = "example"),
                                                        textInput("ylabel", label = "ylabel", value = "example"),
                                                        hr()
                                       ),
                                       actionButton("submit1", label = "Start"),
                                       
                          ),
                          
                          mainPanel(
                            #创建下载按钮
                            hr(),
                            conditionalPanel(
                              condition="input.plot_type == '1'",
                              plotOutput("box_plot"),#input$bheight,input$bwidth),
                            ),
                            conditionalPanel(
                              condition="input.plot_type == '2'",
                              plotOutput("pirates_plot"),#input$bheight,input$bwidth),
                            ),
                            conditionalPanel(
                              condition="input.plot_type == '3'",
                              plotOutput("cloudyrain_plot"),#input$bheight,input$bwidth),
                            ),
                            conditionalPanel(
                              condition="input.plot_type == '4'",
                              plotOutput("violin_plot"),#input$bheight,input$bwidth),
                            ),
                            textOutput("pvalue"),
                            div(style="display:inline-block",numericInput("bheight", label = "Download height(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bwidth", label = "Download width(px):", value = 800,width="90%")),
                            div(style="display:inline-block",numericInput("bdpi", label = "Png/Jpeg dpi:", value = 300,width="90%")),
                            p(),
                            downloadButton("download.pdf", label="pdf"),
                            downloadButton("download.png", label="png"),
                            downloadButton("download.jpeg", label="jpeg"),
                            hr(),
                            # textOutput("conf_out"),
                            
                          ),fluid = TRUE
                        )
                      )),
                    tabItem(tabName = "dformat",
                            fluidRow(
                              p("The format of sample files for uploading is as follows."),
                              p("You can download ",a("alpha data", href = "./alpha.txt",download="alpha.txt"),' and ',a("meta data", href = "./metadata.txt",download="metadata.txt"),"."),
                              h3('Alpha data'),
                              datatable(read.table("./www/alpha.txt",sep = "\t",header = TRUE),rownames = FALSE),
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

