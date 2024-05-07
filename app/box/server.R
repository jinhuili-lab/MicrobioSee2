source("box.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  observe(
   
    {
    if (input$submit1>0) {
      output$box_plot <- renderPlot({
         color = c(input$color1,input$color2,input$color3)
        box(input$bfile$datapath,input$xname,input$yname,input$main,input$notch,color,input$horizontal)
      })

    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("box", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      pdf(file,width = input$bwidth/100,height = input$bheight/100)
      color = c(input$color1,input$color2,input$color3)
      print(box(input$bfile$datapath,input$xname,input$yname,input$main,input$notch,color,input$horizontal))
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    filename = function() {
      paste("box", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      png(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
      color = c(input$color1,input$color2,input$color3)
      print(box(input$bfile$datapath,input$xname,input$yname,input$main,input$notch,color,input$horizontal))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
    filename = function() {
      paste("box", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
      color = c(input$color1,input$color2,input$color3)
      print(box(input$bfile$datapath,input$xname,input$yname,input$main,input$notch,color,input$horizontal))
      dev.off()
    },contentType = 'image/jpeg')

})

