source("plot.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
       quit(save = "no", status = 0)
    })
    if (input$submit1>0) {
      if(input$plot_type=="2"){
        output$PCoA_plot <- renderPlot({
          PCoA(input$file_abunt$datapath,input$file_group$datapath,input$anno,input$method)
        })
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("PCoA", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(PCoA(input$file_abunt$datapath,input$file_group$datapath,input$anno,input$method))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("PCoA", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
            print(PCoA(input$file_abunt$datapath,input$file_group$datapath,input$anno,input$method))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("PCoA", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
            print(PCoA(input$file_abunt$datapath,input$file_group$datapath,input$anno,input$method))
            dev.off()
          },contentType = 'image/jpeg')
      }else if(input$plot_type=="1"){
        output$PCA_plot <- renderPlot({
          pcaplot(input$file_abunt$datapath,input$file_group$datapath,input$scale,input$ellipse,input$addlabel,input$labelposition,input$labelsize)
        })
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("pac", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(pcaplot(input$file_abunt$datapath,input$file_group$datapath,input$scale,input$ellipse,input$addlabel,input$labelposition,input$labelsize)
            )
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("pac", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = (input$bwidth),height = (input$bheight),res=input$bdpi)
            print(pcaplot(input$file_abunt$datapath,input$file_group$datapath,input$scale,input$ellipse,input$addlabel,input$labelposition,input$labelsize)
            )
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("pac", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(pcaplot(input$file_abunt$datapath,input$file_group$datapath,input$scale,input$ellipse,input$addlabel,input$labelposition,input$labelsize)
            )
            dev.off()
          },contentType = 'image/jpeg')

      }else if(input$plot_type=="3"){
        output$nmds_plot <- renderPlot({
          nmds(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance)
        })
        # hr(),
        output$stress_value<- renderText({
          strss_value(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance)
          # nmds.stress(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance)
        })
        output$stress_plot <- renderPlot({
          nmds.stress(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance)
        })
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("nmds", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(nmds(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("nmds", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = input$bwidth,height = input$bheight,res = input$bdpi,type="cairo")
            print(nmds(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("nmds", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
            print(nmds(input$file_abunt$datapath,input$file_group$datapath,input$standardization,input$distance))
            dev.off()
          },contentType = 'image/jpeg')
        
      }
    }
   
  })
})