library(shiny)

shinyUI(pageWithSidebar(
  
  headerPanel("Numericke metody riesenia diferencialnej rovnice"),
  
  sidebarPanel(         
    h3('Parametre'),
    sliderInput("r",label="Parameter r",value=0.07, min = 0.05, max = 0.11, step = 0.002),
    br(),
    dateInput('date',
              label = 'Datum OP: yyyy-mm-dd',
              value = Sys.Date()
    ),
    dateInput('date2',
              label = 'Datum maturity: yyyy-mm-dd',
              value = Sys.Date()
    ),
    
    dateInput('date3',
              label = 'Datum poskytnutia: yyyy-mm-dd',
              value = Sys.Date()
    ),
    
    dateInput('date4',
              label = 'Datum prvej platby: yyyy-mm-dd',
              value = Sys.Date()
    ),
    
    
    dateInput('date3',
              label = 'Datum maturity: yyyy-mm-dd',
              value = Sys.Date()
    ),
    
    sliderInput("h", "Krok", 0.01, 10.00,value = 1, step = 0.1),
    br(),
    sliderInput(inputId="vek",label="Vek osoby",value=80, min = 1, max = 95, step = 1),
    br(),
   
    
    checkboxGroupInput("metody", label = h3("Metody"), 
                       choices = list("Eulerova metoda napred" = 1, "Eulerova spatna metoda " = 2, "Vylepsena polygonova" = 3,"Heunova metoda" = 4, "Runge-Kutta metoda" =5,"Realne udaje"=6))
                       
  ),
  #output$value <- renderPrint({ input$checkGroup }),
  
  mainPanel(
    plotOutput('graf')
  )
  
))






