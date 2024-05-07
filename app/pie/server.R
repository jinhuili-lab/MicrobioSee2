source("pie.R")
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      output$pie_plot <- renderPlot({
        pieplot(input$pfile1$datapath,input$pcolor)
      })
    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("pie", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,width = input$bwidth/100,height = input$bheight/100)
      print(pieplot(input$pfile1$datapath,input$pcolor))
      
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("pie", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
      
      print(pieplot(input$pfile1$datapath,input$pcolor))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("pie", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
      
      print(pieplot(input$pfile1$datapath,input$pcolor))
      dev.off()
    },contentType = 'image/jpeg')
})