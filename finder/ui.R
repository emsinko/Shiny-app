# ui.R  

library(shiny)
library(ggplot2)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("cerulean"),
  includeCSS("bootstrap.css"),  #toto odkomentujte, ak chcete CSS dizajn
  headerPanel("Option strategy"),
  
 
   sidebarPanel(
     strong("Make your first option strategy."),
     strong("Be aware that all options in this application are considered european. "),
     strong("Your strategy may contain up to 4 options."),
     hr(),
     numericInput(inputId="cenastrat", label="Strategy price", value=2, min = 0, max = 50, step = 0.1,width = 100),
     
     sliderInput("slider", label = ("Stock price range"), min = 0, 
                 max = 100, value = c(5, 30))),
  mainPanel(plotOutput("plot")),
 
  hr(),
  hr(),
  hr(),
  hr(),
  
  fluidRow(
    column(3,    
      selectInput(inputId="typ1",label="Option 1",choices=list("None","Call","Put"), selected	="Call", width = 100),
      selectInput(inputId="typ2",label="Option 2",choices=list("None","Call","Put"), selected	="Call", width = 100),
      selectInput(inputId="typ3",label="Option 3",choices=list("None","Call","Put"), selected	="Call", width = 100),
      selectInput(inputId="typ4",label="Option 4",choices=list("None","Call","Put"), selected	="Call", width = 100)
     ),
  
    column(3,
      numericInput(inputId="E1", label="Strike price", value=10, min = 0, max = NA, step = NA,width = 100),
      numericInput(inputId="E2", label="Strike price", value=15, min = 0, max = NA, step = NA,width = 100),
      numericInput(inputId="E3", label="Strike price", value=20, min = 0, max = NA, step = NA,width = 100),
      numericInput(inputId="E4", label="Strike price", value=25, min = 0, max = NA, step = NA,width = 100)
      ),
    
    column(3,
      selectInput(inputId="typ11",label="Buy/Sell",choices=list("Long"=1,"Short"=-1), selected= 1,  width = 100),
      selectInput(inputId="typ22",label="Buy/Sell",choices=list("Long"=1,"Short"=-1), selected=-1, width = 100),
      selectInput(inputId="typ33",label="Buy/Sell",choices=list("Long"=1,"Short"=-1), selected=-1, width = 100),
      selectInput(inputId="typ44",label="Buy/Sell",choices=list("Long"=1,"Short"=-1), selected= 1,  width = 100)
    ),
    
    column(3,
           numericInput(inputId="pocet1",label="Pcs.",value=1, min = 0, max = NA, step = NA, width = 100),
           numericInput(inputId="pocet2",label="Pcs.",value=1, min = 0, max = NA, step = NA, width = 100),
           numericInput(inputId="pocet3",label="Pcs.",value=1, min = 0, max = NA, step = NA, width = 100),
           numericInput(inputId="pocet4",label="Pcs.",value=1, min = 0, max = NA, step = NA, width = 100)
    )
  ),
  hr(),
  h1("Option pricing"),
  fluidRow(column(3,
    selectInput(inputId="aky",label="Option type",choices=list("Call","Put"), selected	="Call", width = 100),
    numericInput(inputId="stock",label="Stock price",value=400, min = 0, max = NA, step = 1, width = 100),
    numericInput(inputId="ecko",label="Strike price",value=300, min = 0, max = NA, step = 1, width = 100),
    numericInput(inputId="urok",label="Interest rate",value=0.1, min = 0.01, max = NA, step = 0.01, width = 100),
    numericInput(inputId="sigma",label="Volatility",value=0.3, min = 0.1, max = NA, step = 0.1, width = 100),
    numericInput(inputId="tau",label="Maturity",value=2, min = 0.1, max = 5, step = 0.25, width = 100)),
    column(9,plotOutput("plot2"),hr(),verbatimTextOutput("text")))
))

