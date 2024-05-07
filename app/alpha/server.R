source("plot.R")
shinyServer(function(input, output,session) {
  observe({
    session$onSessionEnded(function() {
      quit(save = "no", status = 0)
    })
    if (input$submit1>0) {
      output$pvalue <- renderText({
        pvalue(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$tt)
      })
      
      if(input$plot_type=="2"){
        output$pirates_plot <- renderPlot({
          pirates(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$ppal,input$ptheme,input$pinf)#input$meta
        })
        output$conf_out <- renderPrint({
          conf_out(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$ppal,input$ptheme,input$pinf)
        })
        
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("pirates", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(pirates(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$ppal,input$ptheme,input$pinf))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("pirates", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = (input$bwidth),height = (input$bheight),res=input$bdpi)
            print(pirates(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$ppal,input$ptheme,input$pinf))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("pirates", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(pirates(input$file_alpha$datapath,input$alpha,input$file_meta$datapath,input$ppal,input$ptheme,input$pinf))
            dev.off()
          },contentType = 'image/jpeg')
        
        
      }else if(input$plot_type=="1"){
        output$box_plot <- renderPlot({
          box(input$file_alpha$datapath,input$alpha,input$file_meta$datapath)#,,input$meta)input$main,input$notch,input$color,input$horizontal)
        })
        output$conf_out <- renderPrint({
          conf_out(input$file_alpha$datapath,input$alpha,input$file_meta$datapath)
        })
        
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("box", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(box(input$file_alpha$datapath,input$alpha,input$file_meta$datapath))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("box", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(box(input$file_alpha$datapath,input$alpha,input$file_meta$datapath))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("box", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(box(input$file_alpha$datapath,input$alpha,input$file_meta$datapath))
            dev.off()
          },contentType = 'image/jpeg')
      }else if(input$plot_type=="3"){
        output$cloudyrain_plot <- renderPlot({
          cloudyrainplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$dotposition,input$dotsize,input$dotbinwidth,input$boxwidth,input$boxposition,input$transpose)
        })
        output$conf_out <- renderPrint({
          conf_out(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$dotposition,input$dotsize,input$dotbinwidth,input$boxwidth,input$boxposition,input$transpose)
        })
        
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("cloudyrain", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(cloudyrainplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$dotposition,input$dotsize,input$dotbinwidth,input$boxwidth,input$boxposition,input$transpose))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("cloudyrain", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = (input$bwidth),height = (input$bheight),res=input$bdpi)
            print(cloudyrainplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$dotposition,input$dotsize,input$dotbinwidth,input$boxwidth,input$boxposition,input$transpose))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("cloudyrain", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(cloudyrainplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$dotposition,input$dotsize,input$dotbinwidth,input$boxwidth,input$boxposition,input$transpose))
            dev.off()
          },contentType = 'image/jpeg')
      }else if(input$plot_type=="4"){
        output$conf_out <- renderPrint({
          conf_out(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$xlabel,input$ylabel)
        })
        
        output$violin_plot <- renderPlot({
          violinplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$xlabel,input$ylabel)
        })
        output$download.pdf <- downloadHandler(
          filename = function() {
            paste("violin", Sys.Date(), ".pdf", sep="")
          },
          content = function(file) {
            pdf(file,width = input$bwidth/100,height = input$bheight/100)
            print(violinplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$xlabel,input$ylabel))
            dev.off()
          },contentType = 'application/pdf')
        output$download.png <- downloadHandler(
          filename = function() {
            paste("violin", Sys.Date(), ".png", sep="")
          },
          content = function(file) {
            png(file,width = (input$bwidth),height = (input$bheight),res=input$bdpi)
            print(violinplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$xlabel,input$ylabel))
            dev.off()
          },contentType = 'image/png')
        output$download.jpeg <- downloadHandler(
          filename = function() {
            paste("violin", Sys.Date(), ".jpeg", sep="")
          },
          content = function(file) {
            jpeg(file,width = input$bwidth,height = input$bheight,res=input$bdpi)
            print(violinplot(input$file_alpha$datapath,input$file_meta$datapath,input$alpha,input$meta,input$xlabel,input$ylabel))
            dev.off()
          },contentType = 'image/jpeg')
      }
    }
  })
})