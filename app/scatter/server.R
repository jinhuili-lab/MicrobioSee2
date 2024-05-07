source("scatter.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      output$scatter_plot <- renderPlot({
        scatterplot(input$file_input$datapath,input$xlabel,input$ylabel,input$groups,input$input,input$addtext)
      }
      )}
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("scatter", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,width = input$hwidth/100,height = input$hheight/100,)
      print(scatterplot(input$file_input$datapath,input$xlabel,input$ylabel,input$groups,input$input,input$addtext))
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("scatter", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$hwidth,height = input$hheight,res = input$bdpi)
      print(scatterplot(input$file_input$datapath,input$xlabel,input$ylabel,input$groups,input$input,input$addtext))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("scatter", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$hwidth,height = input$hheight,res = input$bdpi)
      print(scatterplot(input$file_input$datapath,input$xlabel,input$ylabel,input$groups,input$input,input$addtext))
      dev.off()
    },contentType = 'image/jpeg')
})

