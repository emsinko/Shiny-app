#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

data_raw <- readr::read_csv("data/data.csv")

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  output$plot <- renderPlot({
    plot(cars, type=input$plotType)
  })
  
  output$summary <- renderPrint({
    summary(cars)
  })
  
  output$table <- DT::renderDataTable({
    DT::datatable(cars)
  })
  
  # display 10 rows initially
  output$data_raw <- DT::renderDataTable(
    DT::datatable(data_raw, options = list(
      lengthMenu = list(c(10, 25,50, -1), c('10','25','50', 'All')),
      pageLength = 15
    ))
  )
  
  
})
