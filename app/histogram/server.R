source("histogram.R")
shinyServer(function(input, output,session) {
  observe({
   session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      output$histogram_plot <- renderPlot({
        histogram(input$hfile1$datapath,input$transpose1,input$Sort1,input$datalabel)
      })
    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("histogram", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,input$bwidth/100,height = input$bheight/100)
      print(histogram(input$hfile1$datapath,input$transpose1,input$Sort1,input$datalabel))
      
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("histogram", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
      
      print(histogram(input$hfile1$datapath,input$transpose1,input$Sort1,input$datalabel))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("histogram", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
      
      print(histogram(input$hfile1$datapath,input$transpose1,input$Sort1,input$datalabel))
      dev.off()
    },contentType = 'image/jpeg')
})