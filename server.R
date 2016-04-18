source("Input.R")
# Define server logic required to draw a histogram

shinyServer(
  function(input, output) {
  output$prediction <- renderUI({
    input$submit
    pred <-takeinput(input$text)
    pred <- pred[!is.na(pred)]
    HTML(paste(pred[!is.na(pred)],"<br/>"))
    freq <- c(5,4,3,2,1)
    HTML(wordcloud(pred,freq, min.freq=0,scale=c(5,0.5),
              colors=brewer.pal(8, "Dark2")))
  })
})