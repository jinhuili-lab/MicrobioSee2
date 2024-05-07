source("volcano.R")
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      output$volcano_plot <- renderPlot({
        volcanoplot(input$pfile$datapath,input$P,input$lFC)
      })
    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("volcano", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,width = input$bwidth/100,height = input$bheight/100)
      print(volcanoplot(input$pfile$datapath,input$P,input$lFC))
      
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("volcano", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
      
      print(volcanoplot(input$pfile$datapath,input$P,input$lFC))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("volcano", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
      
      print(volcanoplot(input$pfile$datapath,input$P,input$lFC))
      dev.off()
    },contentType = 'image/jpeg')
})