## ----options, echo=FALSE, warning=FALSE, message=FALSE------------------------
library(knitr)
Rpackage <- function (pkg) {sprintf("*%s*", pkg)}
CRANpkg <- function (pkg){
    cran <- "https://CRAN.R-project.org/package"
    fmt <- "[%s](%s=%s)"
    Rpackage(sprintf(fmt, pkg, cran, pkg))
}

library(googleVis)
options(prompt = "R> ", digits = 4, 
        show.signif.stars = FALSE,
        gvis.plot.tag='chart')

## ----demos, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE, results='asis'----
## Code for screen shot
library(googleVis)
df <- data.frame(country=c("A", "B", "C"), 
                 val1=c(1,3,4), val2=c(23,12,32))

Line <- gvisLineChart(df, xvar="country", yvar=c("val1", "val2"),
                      options = list(
                        width=300, height=300,
                        legend = "top",
                        title="Hello World",
                        titleTextStyle = "{color:'red',fontName:'Courier',
            fontSize:16}",
            curveType='function'))

ATL <- gvisAnnotationChart(Stock, datevar="Date",
                           numvar="Value", idvar="Device",
                           titlevar="Title",
                           annotationvar="Annotation",
                           options=list(displayAnnotations=TRUE,
                            legendPosition='newRow',
                            width=300, height=300)
                           )
                          
Gauge <- gvisGauge(CityPopularity, 
                 options=list(min=0, max=800, greenFrom=500,
                              greenTo=800, yellowFrom=300, 
                              yellowTo=500,
                              redFrom=0, redTo=300,
                              width=300, height=200))


Geo <-  gvisGeoChart(Exports, locationvar='Country',
                     colorvar='Profit',
                   options=list(projection="kavrayskiy-vii", 
                                width=300,height=200)) 


# Datetime example 
dat <- data.frame(Room=c("Room 1","Room 2","Room 3"),
                  Language=c("English", "German", "French"),
                  start=as.POSIXct(c("2014-03-14 14:00", "2014-03-14 15:00", 
                                     "2014-03-14 14:30")),
                 end=as.POSIXct(c("2014-03-14 15:00", "2014-03-14 16:00", 
                                  "2014-03-14 15:30")))
TL <- gvisTimeline(data=dat, rowlabel="Language",
                   start="start", end="end",
                   options=list(width=300, height=200))
Tree <- gvisTreeMap(Regions,  "Region", "Parent", "Val", "Fac",
                    options=list(width=300, height=200,
                                 fontSize=16,
                                 minColor='#EDF8FB',
                                 midColor='#66C2A4',
                                 maxColor='#006D2C',
                                 headerHeight=20,
                                 fontColor='black',
                                 showScale=TRUE))

M <- gvisMerge(
  gvisMerge(gvisMerge(Line, ATL, horizontal = TRUE,
                      tableOptions="cellspacing=10"), 
            gvisMerge(Gauge, Geo, horizontal =TRUE, 
                      tableOptions="cellspacing=10")), 
  gvisMerge(TL, Tree, horizontal = TRUE, 
            tableOptions="cellspacing=10"))
plot(M)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages('googleVis')

## ----echo=FALSE, quite=TRUE---------------------------------------------------
library(googleVis)

## ----eval=FALSE---------------------------------------------------------------
#  library(googleVis)

## ----echo=FALSE---------------------------------------------------------------
cat(googleVis:::gvisWelcomeMessage())

## ----GeoChart, eval = FALSE---------------------------------------------------
#  gchart <-  gvisGeoChart(data,
#                       locationvar = "",
#                       colorvar = "",
#                       sizevar = "",
#                       hovervar = "",
#                       options = list(),
#                       chartid)

## ----eval=FALSE---------------------------------------------------------------
#  help('gvisGeoChart')

## -----------------------------------------------------------------------------
data(Exports)
Exports

## -----------------------------------------------------------------------------
 gchart <-  gvisGeoChart(data = Exports, 
                      locationvar='Country',
                      colorvar='Profit',
                      options=list(projection="kavrayskiy-vii", 
                                   width=400, height=200))

## ----eval=FALSE---------------------------------------------------------------
#   str(gchart)

## ----echo=FALSE---------------------------------------------------------------
## This statement avoids truncation
cat(paste(substring( capture.output( str(gchart) ) , 0, 66), sep="\n", collapse="\n"))

## -----------------------------------------------------------------------------
gchart$type
gchart$chartid

## -----------------------------------------------------------------------------
print(gchart, tag='header')

## -----------------------------------------------------------------------------
names(gchart$html$chart)

## -----------------------------------------------------------------------------
print(gchart, tag='chart')  ## or cat(gchart$html$chart)

## ----eval=FALSE---------------------------------------------------------------
#  cat(gchart$html$chart['jsChart']) # or print(gchart, 'jsChart')

## ----echo=FALSE---------------------------------------------------------------
cat(paste(substring( capture.output( cat(gchart$html$chart['jsChart']) ) , 0, 66), sep="\n", collapse="\n"))

## ----eval=FALSE---------------------------------------------------------------
#  print(gchart, tag='caption')

## ----echo=FALSE---------------------------------------------------------------
cat(paste(substring( capture.output( cat(gchart$html$caption) ) , 0, 66), sep="\n", collapse="\n"))

## ----eval=FALSE---------------------------------------------------------------
#  print(gchart, tag='footer')

## ----echo=FALSE---------------------------------------------------------------
cat(paste(substring( capture.output( cat(gchart$html$footer) ) , 0, 66), sep="\n", collapse="\n"))

## ----displaygchart, results='asis'--------------------------------------------
plot(gchart)  # returns invisibly the file name

## ----eval=FALSE---------------------------------------------------------------
#  print(gchart, file="myGoogleVisChart.html")

## ----eval=FALSE---------------------------------------------------------------
#  plot.gvis("/Users/JoeBloggs/myGoogleVisChart.html")

## ----LineChartWithOptions, results="asis"-------------------------------------
df <- data.frame(country=c("US", "GB", "BR"), 
                 val1=c(1,3,4), val2=c(23,12,32))

Line <-  gvisLineChart(df, xvar="country", yvar=c("val1","val2"),
                       options=list(
                         title="Hello World",
                         titleTextStyle="{color:'red', 
                                           fontName:'Courier', 
                                           fontSize:16}",                         
                         backgroundColor="#D3D3D3",                          
                         vAxis="{gridlines:{color:'red', count:3}}",
                         hAxis="{title:'Country', titleTextStyle:{color:'blue'}}",
                         series="[{color:'green', targetAxisIndex: 0},	
                                   {color: 'orange',targetAxisIndex:1}]",
                         vAxes="[{title:'val1'}, {title:'val2'}]",
                         legend="bottom",
                         curveType="function",
                         width=500,
                         height=300                         
                       ))
plot(Line)

## ----chartEdit, results='asis'------------------------------------------------
Editor <- gvisLineChart(df, options=list(gvis.editor='Edit me!'))
plot(Editor)

## ----eval=FALSE---------------------------------------------------------------
#  print(gchart, 'chart')  ## or cat(gchart$html$chart)

## ----eval=FALSE---------------------------------------------------------------
#  print(gchart, 'chart', file='myfilename')

## ----eval=FALSE---------------------------------------------------------------
#  # server.R
#  library(googleVis)
#  
#  shinyServer(function(input, output) {
#    datasetInput <- reactive({
#      switch(input$dataset,
#             "rock" = rock,
#             "pressure" = pressure,
#             "cars" = cars)
#    })
#  
#    output$view <- renderGvis({
#      gvisScatterChart(datasetInput())
#    })
#  })
#  
#  # ui.R
#  shinyUI(pageWithSidebar(
#    headerPanel("googleVis on Shiny"),
#    sidebarPanel(
#      selectInput("dataset", "Choose a dataset:",
#                  choices = c("rock", "pressure", "cars"))
#    ),
#    mainPanel(
#      htmlOutput("view")
#    )
#  ))

## ----eval=FALSE---------------------------------------------------------------
#  library(shiny)
#  runApp(system.file("shiny/", package="googleVis"))

## ----echo=FALSE, class.output="r", comment=""---------------------------------
cat(paste(sep = "\n",
   "```{r results='asis'}",
   "gchart <- gvisColumnChart(CityPopularity, 'City', 'Popularity',",
   "                        options=list(width=550, height=450,",
   "                                     legend='none'))",
   "print(gchart, 'chart')",
   "```"
))

## ----readTrendLines, message=FALSE, echo=FALSE--------------------------------
read_demo('Trendlines', 'googleVis')

## ----LinearTrend, results='asis', tidy=FALSE----------------------------------
plot(
  gvisScatterChart(women, options=list(trendlines="0"))
)

## ----ExponentialTrend, results='asis', tidy=FALSE-----------------------------
plot(
  gvisScatterChart(women, options=list(
    trendlines="{0: { type: 'exponential',  
                     visibleInLegend: 'true', 
                     color: 'green',
                     lineWidth: 10,
                     opacity: 0.5}}",
    chartArea="{left:50,top:20,width:'50%',height:'75%'}"))
)

## ----ColumnChartWithTrendline, results='asis', tidy=FALSE---------------------
dat <- data.frame(val1=c(1,3,4,5,6,8), 
                  val2=c(12,23,32,40,50,55))
plot(
  gvisColumnChart(dat,
                  options=list(trendlines="{0: {}}"))
)

## ----DifferentLabels, results='asis', tidy=FALSE------------------------------
dat$val3 <- c(5,6,10,12,15,20)
plot(
  gvisColumnChart(dat,
                  options=list(trendlines="{
                          0: {
                            labelInLegend: 'Trendline 1',
                            visibleInLegend: true,}, 
                          1:{
                            labelInLegend: 'Trendline 2',
                            visibleInLegend: true}
                          }",
                          chartArea="{left:50,top:20,
                                      width:'50%',height:'75%'}"
                  ))
)

## ----readRoles, message=FALSE, echo=FALSE-------------------------------------
read_demo('Roles', 'googleVis')

## ----Tooltip, results='asis', tidy=FALSE--------------------------------------
df <- data.frame(year=1:11,pop=1:11,
                 pop.html.tooltip=letters[1:11])
plot( 
  gvisScatterChart(df)
)

## ----CertaintyScopeEmphasis, results='asis', tidy=FALSE-----------------------
df <- data.frame(year=1:11, x=1:11,
                 x.scope=c(rep(TRUE, 8), rep(FALSE, 3)),
                 y=11:1, y.html.tooltip=LETTERS[11:1],                 
                 y.certainty=c(rep(TRUE, 5), rep(FALSE, 6)),
                 y.emphasis=c(rep(FALSE, 4), rep(TRUE, 7)))
plot(
  gvisScatterChart(df,options=list(lineWidth=2))
)

## ----ColumnChart, results='asis', tidy=FALSE----------------------------------
dat <- data.frame(Year=2010:2013,
                  Sales=c(600, 1500, 800, 1000),
                  Sales.html.tooltip=c('$600K in our first year!',
                                       'Sunspot activity made this our best year ever!',
                                       '$800K in 2012.',
                                       '$1M in sales last year.'),
                  Sales.certainty=c(TRUE, FALSE, TRUE, FALSE))
plot(
  gvisColumnChart(dat, xvar='Year', 
                  yvar=c('Sales', 'Sales.certainty')
  )
)

## ----TwoLines, results='asis', tidy=FALSE-------------------------------------
df <- data.frame(country=c("US", "GB", "BR"), 
                 val1=c(1,3,4), 
                 val1.emphasis=c(TRUE, TRUE, FALSE),
                 val2=c(23,12,32))
plot(
  gvisLineChart(df, xvar="country", 
                yvar=c("val1", "val1.emphasis")
  )
)

plot(
  gvisLineChart(df, xvar="country", 
                yvar=c("val1", "val1.emphasis", "val2")
  )
)

## ----VerticalReferenceLine, results='asis', tidy=FALSE------------------------
dat <- data.frame(Year=2010:2013, 
                  Sales=c(600, 1500, 800, 1000),
                  Sales.annotation=c('First year', NA, NA, 'Last Year'),
                  Sales.annotationText=c('$600K in our first year!',
                                       NA,
                                       NA,
                                       '$1M in sales last year.'))      

plot(
  gvisLineChart(dat, xvar='Year', 
                  yvar=c('Sales',
                         'Sales.annotation',
                         'Sales.annotationText'),
                         options=list(annotations = "{style:'line'}")
  )
)

## ----Interval, results='asis', tidy=FALSE-------------------------------------
df <- data.frame(Year=2013:2014, Sales=c(120, 130), 
                 Sales.interval.1=c(100,110), 
                 Sales.interval.2=c(140, 150),
                 Sales.interval.3=c(90, 100),
                 Sales.interval.4=c(150, 170),
                 Sales.style=c('red', 'gold'),
                 Sales.annotation=c("North", "South"),
                 check.names=FALSE)

plot(
  gvisBarChart(df, xvar='Year', 
               yvar=c('Sales',                       
                      'Sales.interval.1', 
                      'Sales.interval.2',
                      'Sales.style',
                      'Sales.annotation')
  )
)

plot(
  gvisLineChart(df, xvar='Year', 
               yvar=c('Sales', 
                      'Sales.interval.1', 
                      'Sales.interval.2'),
               options=list(series="[{color:'purple'}]")
  )
)


plot(
  gvisLineChart(df, xvar='Year', 
                yvar=c('Sales', 
                       'Sales.interval.1', 
                       'Sales.interval.2', 
                       'Sales.interval.3', 
                       'Sales.interval.4'),
                options=list(series="[{color:'purple'}]",
                             lineWidth=4,
                             interval="{
            'i1': { 'style':'line', 'color':'#D3362D', 'lineWidth': 0.5 },
            'i2': { 'style':'line', 'color':'#F1CA3A', 'lineWidth': 1 },
            'i3': { 'style':'line', 'color':'#5F9654', 'lineWidth': 2 },
            'i4': { 'style':'line', 'color':'#5F9654', 'lineWidth': 3 }
        }")
  )
)


plot(
  gvisLineChart(df, xvar='Year', 
                yvar=c('Sales', 
                       'Sales.interval.1', 
                       'Sales.interval.2', 
                       'Sales.interval.3', 
                       'Sales.interval.4'),
                options=list(series="[{color:'purple'}]",
                             lineWidth=4,
                             intervals="{ 'style':'area' }",
                             interval="{
                               'i1': { 'color': '#4374E0', 'style':'bars', 'barWidth':0, 'lineWidth':4, 'pointSize':10, 'fillOpacity':1 },
                               'i2': { 'color': '#E49307', 'style':'bars', 'barWidth':0, 'lineWidth':4, 'pointSize':10, 'fillOpacity':1 }}"                                                          
                             )
  )
)

## ----GeoChartTooltip, results='asis', tidy=FALSE------------------------------
Exports$Profit.tooltip <- paste("<b>Test</b>", Exports$Profit)
Exports$Tooltip.header <- ""
GeoTooltip <- gvisGeoChart(
  Exports, 
  locationvar = "Country", 
  colorvar = "Profit",
  hovervar = "Tooltip.header",
  options = list(tooltip = "{isHtml: true}")
)
plot(GeoTooltip)

## ----listener, results="asis"-------------------------------------------------
jscode <- "window.open('https://en.wikipedia.org/wiki/' 
                  + data.getValue(chart.getSelection()[0].row,0)); "

J1 <- gvisGeoChart(Exports, locationvar='Country', sizevar = 'Profit',
                 options=list(dataMode="regions", 
                              gvis.listener.jscode=jscode))
plot(J1)

## ----eval=FALSE---------------------------------------------------------------
#  plot(gvisOrgChart(Regions,  options=list(gvis.listener.jscode=jscode)))
#  plot(gvisLineChart(Regions[,c(1,3)], options=list(gvis.listener.jscode=jscode)))

## ----message, results="asis"--------------------------------------------------
jscode <- "
       var sel = chart.getSelection();
       var row = sel[0].row;
       var text = data.getValue(row,1);
       alert(text);
"
J2 <- gvisTable(Population[1:5,], 
                options=list(gvis.listener.jscode=jscode))
plot(J2)

## ----setlimit, results="asis"-------------------------------------------------
dat <- data.frame(x=LETTERS[1:10], 
                  y=c(0, 4, -2, 2, 4, 3, 8, 15, 10, 4))
area1 <- gvisAreaChart(xvar="x", yvar="y", data=dat,
    	options=list(vAxes="[{viewWindowMode:'explicit',
			viewWindow:{min:0, max:10}}]",
                        width=500, height=400, 
                        title="y-limits set from 0 to 10"),
			chartid="area1ylim")
plot(area1)

## ----columnchart, results='asis'----------------------------------------------
df <- data.frame("Year"=c('2009', '2010'), 
                 "Alice\\'s salary"=c(86.1, 93.3), 
                 "Bob\\'s salary"=c(95.3, 100.5),
                 check.names=FALSE) 
gchart <- gvisColumnChart(df, options=list(vAxis='{baseline:0}', 
                            title="Salary",
                            legend="{position:'bottom'}"))
plot(gchart)

## ----citation-----------------------------------------------------------------
citation("googleVis")

