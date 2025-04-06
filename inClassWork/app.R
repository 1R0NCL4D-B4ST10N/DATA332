library(shiny)
# 
# ui <- fluidPage(
#   selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
#   verbatimTextOutput("summary"),
#   tableOutput("table")
# )
# server <- function(input, output, session) {
#   # Create a reactive expression
#   dataset <- reactive({
#     get(input$dataset, "package:datasets")
#   })
#   
#   output$summary <- renderPrint({
#     # Use a reactive expression by calling it like a function
#     summary(dataset())
#   })
#   
#   output$table <- renderTable({
#     dataset()
#   })
# }
# shinyApp(ui, server)

# 
# ui <- fluidPage(
#   textInput("name", "What's your name?"),
#   textOutput("greeting")
# )
# server <- function(input,output, session) {
#   output$greeting <- renderText({
#     paste0("Hello ", input$name)
#   })
# }
# shinyApp(ui, server)

ui <- fluidPage(
  sliderInput("x", label = "If x is", min = 1, max = 50, value = 30),
  sliderInput("y", label = "and y is", min = 1, max = 50, value = 5),
  "then, (x * y) is", textOutput("product"),
  "and, (x * y) + 5 is", textOutput("product_plus5"),
  "and (x * y) + 10 is", textOutput("product_plus10")
)

server <- function(input, output, session) {
  output$product <- renderText({ reactive({
    product <- input$x * input$y
  })
  })
  
  output$product_plus5 <- renderText({
      product() + 5
    })
  
  output$product_plus10 <- renderText({
    product() + 10
  })
}

shinyApp(ui, server)

