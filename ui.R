shinyUI(fluidPage(
  
  # Application title
  titlePanel("Text Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("text", "Enter your sentence here:","You mean the"),
       submitButton("Submit")
    ),
#show predictions
  mainPanel(
    h4("Predictions"),
    htmlOutput("prediction")
    )
  )
))