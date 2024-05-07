source("Bubble_chart.R")
shinyServer(function(input, output) {
  observe({
    if (input$submit1>0) {
      output$Bubble_plot <- renderPlot({
        Bubble_chartplot(input$bfile1$datapath,input$x,input$y,input$size,input$color,input$title)
      })
    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("Bubble", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,width = input$bwidth/100,height = input$bheight/100)
      print(Bubble_chartplot(input$bfile1$datapath,input$x,input$y,input$size,input$color,input$title))
      
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("Bubble", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
      
      print(Bubble_chartplot(input$bfile1$datapath,input$x,input$y,input$size,input$color,input$title))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("Bubble", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
      
      print(Bubble_chartplot <-funciton(input$bfile1$datapath,input$x,input$y,input$size,input$color,input$title))
      dev.off()
    },contentType = 'image/jpeg')
})