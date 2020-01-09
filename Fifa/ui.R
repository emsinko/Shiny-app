#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# shinyUI(navbarPage("App Title",
#                    tabPanel("Tab Name",
#                             sidebarPanel([inputs for the first tab]),
#                             mainPanel([outputs for the first tab])
#                    ),
#                    tabPanel("Second tab name",
#                             sidebarPanel([inputs for the second tab]),
#                             mailPanel([outputs for the second tab])
#                    )
# ))

#install.packages("shiny")
#install.packages("DT")
#install.packages("tidyverse")
# install.packages("shinythemes")
library(shinythemes)
library(shiny)

# Define UI for application that draws a histogram

shinyUI(
  
  navbarPage("FIFA 2019",theme = shinytheme("united"),
             tabPanel("Pochopenie ciela",
                      sidebarLayout(
                        sidebarPanel(
                          radioButtons("plotType", "Plot type",
                                       c("Scatter"="p", "Line"="l")
                          )
                        ),
                        mainPanel(
                          plotOutput("plot")
                        )
                      )
             ),
             tabPanel("Priprava dat",
                      verbatimTextOutput("summary")
             ),
             tabPanel("Modelovanie"#,
                      #verbatimTextOutput("summary")
             ),
             tabPanel("Vyhodnotenie"#,
                      #verbatimTextOutput("summary")
             ),
             navbarMenu("Skusanie",
                        tabPanel("Table",
                                 DT::dataTableOutput("table")
                        ),
                        tabPanel("About",
                                 fluidRow(
                                   column(6,
                                          #includeMarkdown("about.md")
                                          img(class="img-polaroid",
                                              src=paste0("http://upload.wikimedia.org/",
                                                         "wikipedia/commons/9/92/",
                                                         "1919_Ford_Model_T_Highboy_Coupe.jpg"))
                                   ),
                                   column(3,
                                          img(class="img-polaroid",
                                              src=paste0("http://upload.wikimedia.org/",
                                                         "wikipedia/commons/9/92/",
                                                         "1919_Ford_Model_T_Highboy_Coupe.jpg")),
                                          tags$small(
                                            "Source: Photographed at the Bay State Antique ",
                                            "Automobile Club's July 10, 2005 show at the ",
                                            "Endicott Estate in Dedham, MA by ",
                                            a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
                                              "User:Sfoskett")
                                          )
                                   )
                                 )
                        )
             )
  ))


# 
# shinyUI(navbarPage("App Title",
#                    tabPanel("Tab Name",
#                             sidebarPanel(
#                               sliderInput("bins",
#                                           "Number of bins:",
#                                           min = 1,
#                                           max = 50,
#                                           value = 30)
#                               )
#                             ),
#                             mainPanel( 
#                               plotOutput("distPlot")
#                               )
#                    ,
#                    tabPanel("Second tab name",
#                             sidebarPanel(
#                               sliderInput("bins",
#                                           "Number hahaha:",
#                                           min = 2,
#                                           max = 40,
#                                           value = 30)
#                             ),
#                             mainPanel(
#                               plotOutput("distPlot"))
#                    )
# ))
# 
# 
# shinyUI(fluidPage(
# 
#   # Application title
#   titlePanel("Old Faithful Geyser Data"),
# 
#   # Sidebar with a slider input for number of bins
#   sidebarLayout(
#     sidebarPanel(
#        sliderInput("bins",
#                    "Number of bins:",
#                    min = 1,
#                    max = 50,
#                    value = 30)
#     ),
# 
#     # Show a plot of the generated distribution
#     mainPanel(
#        plotOutput("distPlot")
#     )
#   )
# ))
