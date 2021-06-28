library(shiny)
ui = fluidPage(
  sliderInput(inputId = "num",
              label = "Choos a number", 
              value = 25, min = 1, max = 100),
  plotOutput(outputId = 'hist'),
  plotOutput(outputId = 'scatter')

)

server = function(input, output){
  rand_data = reactive({
    rnorm(input$num)
  })
  
  output$hist = renderPlot({
    title = paste(input$num, "random normal values")
    hist(rand_data(), main = title)
  })
  output$scatter = renderPlot({
    title = paste(input$num, "random normal values")
    plot(rand_data(), main = title)
  })
}

shinyApp(ui = ui, server = server)