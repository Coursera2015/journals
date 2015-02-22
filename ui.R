library(shiny)

#Define user interface
shinyUI(fluidPage(
  titlePanel("World scientific journals"),
  
  sidebarLayout(
    #Sidebar panel
    sidebarPanel(
      selectInput("dataset", "Choose a dataset:", 
      choices = c("Number of journals per country", 
                  "Number of journals per publisher")),
      numericInput("obs", "Number of observations to view:", 20)      
      ),    
    
    mainPanel(
      verbatimTextOutput("summary"),
      tableOutput("view"),
      plotOutput("plot")
    )
  )
))