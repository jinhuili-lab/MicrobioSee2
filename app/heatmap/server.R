source("heatmap.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
  observe({
   session$onSessionEnded(function() {
    quit(save = "no", status = 0)
  })
    if (input$submit1>0) {
      output$heatmap_plot <- renderPlot({
        #file,scale,cluster_rows,cluster_cols,clustering_method,border,cellwidth,cellheight,display_numbers,
        # main,show_colnames,show_rownames,fontsize_number,fontsize
        heatmap(input$hfile$datapath,
                input$hscale,
                input$hcluster_rows,
                input$hcluster_cols,
                input$hclustering_method,
                input$hborder,
                input$hdisplay_numbers,
                input$hmain,
                input$hshow_colnames,
                input$hshow_rownames,
                input$hfontsize_number,
                input$hfontsize)
      }
      )}
    output$download.pdf <- downloadHandler(
      filename = function() {
        paste("heatmap", Sys.Date(), ".pdf", sep="")
      },
      content = function(file) {
        pdf(file,width = input$bwidth/100,height = input$bheight/100)
        print(heatmap(input$hfile$datapath,
                      input$hscale,
                      input$hcluster_rows,
                      input$hcluster_cols,
                      input$hclustering_method,
                      input$hborder,
                      input$hdisplay_numbers,
                      input$hmain,
                      input$hshow_colnames,
                      input$hshow_rownames,
                      input$hfontsize_number,
                      input$hfontsize))
        dev.off()
      },contentType = 'application/pdf')
    output$download.png <- downloadHandler(
      filename = function() {
        paste("heatmap", Sys.Date(), ".png", sep="")
      },
      content = function(file) {
        png(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
        print(heatmap(input$hfile$datapath,
                      input$hscale,
                      input$hcluster_rows,
                      input$hcluster_cols,
                      input$hclustering_method,
                      input$hborder,
                      input$hdisplay_numbers,
                      input$hmain,
                      input$hshow_colnames,
                      input$hshow_rownames,
                      input$hfontsize_number,
                      input$hfontsize))
        dev.off()
      },contentType = 'image/png')
    output$download.jpeg <- downloadHandler(
      filename = function() {
        paste("heatmap", Sys.Date(), ".jpeg", sep="")
      },
      content = function(file) {
        jpeg(file,width = input$bwidth,height = input$bheight,res = input$bdpi)
        print(heatmap(input$hfile$datapath,
                      input$hscale,
                      input$hcluster_rows,
                      input$hcluster_cols,
                      input$hclustering_method,
                      input$hborder,
                      input$hdisplay_numbers,
                      input$hmain,
                      input$hshow_colnames,
                      input$hshow_rownames,
                      input$hfontsize_number,
                      input$hfontsize))
        dev.off()
      },contentType = 'image/jpeg')
  })
  
})

