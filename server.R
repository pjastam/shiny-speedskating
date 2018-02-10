# server.R
require(shiny)

shinyServer(
  function(input, output) {
    
      junior_db <- reactive({
        eval(as.name(paste0("skater_",input$junior, "_", input$distance)))
      })
      
      senior_db <- reactive({
        eval(as.name(paste0("skater_",input$senior, "_", input$distance)))
      })

      senior_db_adj <- reactive({
        if (!input$adjust) return(senior_db())
        adjust(senior_db(), rep(as.Date(skaters_id[skaters_id["id"] == input$junior][3], "%Y-%m-%d") - as.Date(skaters_id[skaters_id["id"] == input$senior][3], "%Y-%m-%d")))
      })
      
      output$timesPlot <- renderPlot({
        f_plot_times(db = rbind(junior_db(), senior_db_adj()), title = paste0("Performance analysis ",skaters_id[skaters_id["id"] == input$junior][2]," vs ",skaters_id[skaters_id["id"] == input$senior][2]," (", input$distance," meter)"), set_of_breaks = c(input$junior, input$senior), set_of_labels = c(skaters_id[skaters_id["id"] == input$junior][2], skaters_id[skaters_id["id"] == input$senior][2]))
      })

  }
)
