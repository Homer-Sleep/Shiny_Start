library(shiny)
ui = fluidPage(
  sliderInput(inputId = "num",
              label = "Choose a number", 
              value = 25, min = 1, max = 100),
  textInput(inputId = "title", 
            label = "Edit title of histogram below", 
            placeholder = "Default Histogram Title"),
  actionButton(inputId = "Update",
               label = "Rename Histogram"),
  plotOutput(outputId = 'hist'),
  plotOutput(outputId = 'scatter')

)

server = function(input, output){
  rand = reactiveValues( data = rnorm(input$num))
  
  observeEvent(input$clicks, { rand_data = reactive({ # acts as a function when called downstream
    rnorm(input$num)
  })
  })
  
  output$hist = renderPlot({
    title = paste(input$num, "random normal values")
    hist(rand$data, main = isolate({input$title}))
  })
  output$scatter = renderPlot({
    title = paste(input$num, "random normal values")
    plot(rand$data, main = isolate({input$title}))
  })
}

shinyApp(ui = ui, server = server)