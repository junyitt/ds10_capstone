#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
      fluidPage(
            titlePanel("Predict next word"),
            mainPanel(
                  
                  
                  h3("Predicted next word:"),
                  fluidRow(
                        column(3,p("Prediction 1")),
                        column(3,p("Prediction 2")),
                        column(3,p("Prediction 3"))
                  ),
                  fluidRow(
                        column(3, uiOutput("predictbutton1")  ),
                        column(3, uiOutput("predictbutton2")  ),
                        column(3, uiOutput("predictbutton3")  )
                  ),
                  actionButton("do", "Click Me"),   
                  # ntext <- eventReactive(input$action, {
                  #       # textInput("word1", h3("Write your sentence here:"), "Example", value = ")
                  # }
                  # )
                  textInput("word1", h3("Write your sentence here:"),  value = "Chief Executive"),
                  uiOutput("text1")
            )

            
      )
)
