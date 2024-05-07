source("venn_plot2.R")
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      if(input$vcolor == '1'){
        colors=paste(input$col1,input$col2,input$col3,sep = ',')
      }else{
        colors= input$vcolor
      }
      # color=paste(input$col1,input$col2,input$col3,sep = ',')
      # print(colors)
      output$venn_plot <- renderPlot({
        vennplot(input$vfile1$datapath,colors,input$vopacity)
      })
    }
  })
  output$download.pdf <- downloadHandler(
    filename = function() {
      paste("venn", Sys.Date(), ".pdf", sep="")
    },
    content = function(file) {
      if(input$vcolor == '1'){
        colors=paste(input$col1,input$col2,input$col3,sep = ',')
      }else{
        colors= input$vcolor
      }
      # colors=paste(input$col1,input$col2,input$col3,sep = ',')
      pdf(file,width = input$bwidth/100,height = input$bheight/100)
      print(vennplot(input$vfile1$datapath,colors,input$vopacity))
      
      dev.off()
    },contentType = 'application/pdf')
  output$download.png <- downloadHandler(
    
    filename = function() {
      paste("venn", Sys.Date(), ".png", sep="")
    },
    content = function(file) {
      if(input$vcolor == '1'){
        colors=paste(input$col1,input$col2,input$col3,sep = ',')
      }else{
        colors= input$vcolor
      }
      # colors=paste(input$col1,input$col2,input$col3,sep = ',')
      png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
      
      print(vennplot(input$vfile1$datapath,colors,input$vopacity))
      dev.off()
    },contentType = 'image/png')
  output$download.jpeg <- downloadHandler(
   
    filename = function() {
      paste("venn", Sys.Date(), ".jpeg", sep="")
    },
    content = function(file) {
      if(input$vcolor == '1'){
        colors=paste(input$col1,input$col2,input$col3,sep = ',')
      }else{
        colors= input$vcolor
      }
      # color=paste(input$col1,input$col2,input$col3,sep = ',')
      jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
      print(vennplot(input$vfile1$datapath,colors,input$vopacity))
      dev.off()
    },contentType = 'image/jpeg')
})