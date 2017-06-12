#DS 10 - Swiftkey capstone

library(shiny)
library(shinyjs)

shinyUI(
      fluidPage(
            titlePanel("Predict next word"),

            mainPanel(
                  br(),
                  p("Welcome to my Shiny App!"),
                  p("This shiny application was inspired by Swiftkey keyboard in both Android and iOS."),
                  p("As the user types a sentence, 3 buttons above show the predictions of the next word,
                     where the leftmost word is the most probable word; rightmost word is the 3rd most probable word."),
                  p("The user may click on either one of the 3 predicted words to fill in the selected predicted word at the end of the sentence."),
                  br(),

                  useShinyjs(),
                  div(
                        id = "loading_page",
                        h3("Loading... Please wait...")
                  ),
                  
                  fluidRow(
                        column(3, uiOutput("predictbutton1")  ),
                        column(3, uiOutput("predictbutton2")  ),
                        column(3, uiOutput("predictbutton3")  )
                  ),
                  textInput("word1", label = "", placeholder = "Your sentence goes here", width =  "100%")
            )

            
      )
)
