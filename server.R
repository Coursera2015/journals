library(shiny)
library(dplyr)
library(xtable)

#Load and prepare data
df <- arrange(read.delim("test.txt", 
              header = TRUE, stringsAsFactors = FALSE), desc(SJR_2013)) 
country_j   <- arrange(count(df, Publishers_Country),desc(n))
publisher_j <- arrange(count(df, Publishers_Name), desc(n))

#Define shiny server
shinyServer(function(input, output) {  
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "Number of journals per country" = country_j,                      
           "Number of journals per publisher" = publisher_j)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
    })

  output$plot <- renderPlot({
      dataset <- datasetInput()
      plot(dataset$n, type = "l", col = 'darkblue', lwd = 3)
    })    
})
