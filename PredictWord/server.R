#DS 10 - Swiftkey capstone

library(shiny)
library(dplyr); library(tidytext); library(tidyr)



con <- file("https://raw.githubusercontent.com/junyitt/ds10_capstone/master/00_main_f.R")
source(con)
close(con)





#load the Rdata that contains the ngram calculated before
load_data <- function(){
      con <- file("https://github.com/junyitt/ds10_capstone/raw/master/nlist1.Rdata")
      load(con, envir = .GlobalEnv)
      close(con)
      
      hide("loading_page")
}




# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
      
      load_data()
      
      observeEvent(input$action1, {
            updateTextInput( session, 'word1', value=paste(trimws(input$word1, "right"), predict()[1]) )
      })
      
      observeEvent(input$action2, {
            updateTextInput( session, 'word1', value=paste(trimws(input$word1, "right"), predict()[2]) )
      })
      
      observeEvent(input$action3, {
            updateTextInput( session, 'word1', value=paste(trimws(input$word1, "right"), predict()[3]) )
      })
      
      predict <- reactive({
            word <- input$word1
            pred_df <- p2(word, nlist1, k = 3)
            predict1 <- as.data.frame(pred_df[,"predict"])[1:nrow(pred_df),1]
            
            if(is.na(predict1[2])){
                  predict1[2] <- "the"
            }
            if(is.na(predict1[3])){
                  predict1[3] <- "the"
            }
            predict1
      })
      
            output$predicttext1 <- renderText({ 
                  predict()[1]
            })
            
            output$predicttext2 <- renderText({ 
                        predict()[2]
            })
            
            output$predicttext3 <- renderText({ 
                        predict()[3]
            }) 
            
            output$predictbutton1 <- renderUI({
                  actionButton("action1", label = predict()[1], width = "150px")
            }) 
            output$predictbutton2 <- renderUI({
                  actionButton("action2", label = predict()[2], width = "150px")
            })
            output$predictbutton3 <- renderUI({
                  actionButton("action3", label = predict()[3], width = "150px")
            })
            
           
            # output$text1 <- renderUI({
            #       textInput("text12", h3("Write your sentence here2:"), placeholder = "Your sentence", value = "")
            # })
})
