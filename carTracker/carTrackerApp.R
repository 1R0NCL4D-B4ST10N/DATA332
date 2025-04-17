library(shiny)
library(ggplot2)
library(readxl)
library(DT)

rm(list = ls())

setwd('C:/Users/thewi/Documents/rstudio/carTracker')


dataset <- read_excel('carTracker.xlsx', .name_repair = 'universal')
column_names<-colnames(dataset) #for input selections


ui<-fluidPage( 
  theme = bslib::bs_theme(bootswatch = "darkly"),
  
  titlePanel(title = "Explore Car Track Dataset"),
  h4('Speed Radar Car Tracking'),
  
  fluidRow(
    column(2,
           selectInput('X', 'Choose X', column_names, column_names[1]),
           selectInput('Y', 'Choose Y', column_names, column_names[3]),
           selectInput('chartType', 'Select Chart Type', choices = c("Histogram", "Boxplot", "Bar Chart"))
    ),
    column(4,plotOutput('plot_01')),
    column(6,DT::dataTableOutput("table_01", width = "100%"))
  ),
  
  fluidRow(
    column(12, h3("Data Analysis Insight")),
    column(12, verbatimTextOutput("analysis"))
  )
  
)

server <- function(input, output) {
  
  output$plot_01 <- renderPlot({
    ggplot(dataset, aes_string(x = input$X)) +
      geom_bar() +
      labs(x = input$X, y = "Count") +
      theme_minimal()
  })
  
  output$table_01 <- DT::renderDataTable({
    dataset[, c(input$X, input$Y)]
  }, options = list(pageLength = 10))
  
  output$analysis <- renderText({
    # Compute stats
    min_speed <- min(dataset$MPH, na.rm = TRUE)
    max_speed <- max(dataset$MPH, na.rm = TRUE)
    mean_speed <- mean(dataset$MPH, na.rm = TRUE)
    
    paste0(
      "Data Summary:\n",
      "- Minimum Speed: ", round(min_speed, 2), " MPH\n",
      "- Maximum Speed: ", round(max_speed, 2), " MPH\n",
      "- Average Speed: ", round(mean_speed, 2), " MPH\n",
    )
  })
}

shinyApp(ui=ui, server=server)
