library(shiny)
library(ggplot2)
library(readxl)
library(DT)

# Load data
setwd('C:/Users/thewi/Documents/rstudio/carTracker')
dataset <- read_excel('carTracker.xlsx', .name_repair = 'universal')
column_names <- colnames(dataset)

ui <- fluidPage(
  theme = bslib::bs_theme(bootswatch = "darkly"),
  
  titlePanel("Explore Car Track Dataset"),
  h4('Speed Radar Car Tracking'),
  
  fluidRow(
    column(2,
           selectInput('X', 'Choose X', column_names, column_names[1]),
           selectInput('Y', 'Choose Y', column_names, column_names[3]),
    ),
    column(5, plotOutput('plot_01')),
    column(5, DT::dataTableOutput("table_01"))
  ),
  
  fluidRow(
    column(12, h3("Data Analysis Insight")),
    column(12, verbatimTextOutput("analysis"))
  )
)

server <- function(input, output){
  
  output$plot_01 <- renderPlot({
    ggplot(dataset, aes_string(x=input$X, y=input$Y)) +
      geom_point(size=3, alpha=0.7) +
      theme_minimal() +
      theme(panel.background = element_rect(fill="transparent"),
            plot.background = element_rect(fill="transparent", color=NA))
  })
  
  output$table_01 <- DT::renderDataTable(
    dataset[, c(input$X, input$Y)],
    options = list(pageLength = 4, class = 'table-dark')
  )
  
  output$analysis <- renderText({
    avg_speed_mph <- mean(dataset[["MPH"]], na.rm = TRUE)
    max_speed_mph <- max(dataset[["MPH"]], na.rm = TRUE)
    most_common_color <- names(sort(table(dataset$Color), decreasing = TRUE))[1]
    
    paste0(
      "This dataset captures key details from speed radar tracking of vehicles. ",
      "The average recorded speed is ", round(avg_speed_mph, 2), " MPH, while the top speed observed is ",
      round(max_speed_mph, 2), " MPH. ",
      "Interestingly, the most frequently appearing vehicle color is ", most_common_color, ". ",
      "This information is helpful for identifying patterns related to vehicle speed, common appearances, or targeting traffic safety initiatives."
    )
  })
}

shinyApp(ui=ui, server=server)


