library(shiny)
library(ggplot2)
library(DT)
library(dplyr)
library(readxl)
library(RCurl)
library(bslib)

# Helper functions
read_csv_url <- function(url) {
  text <- getURL(url, ssl.verifypeer = FALSE, httpheader = c("User-Agent" = "R"))
  read.csv(text = text, stringsAsFactors = FALSE)
}

read_excel_url <- function(url) {
  temp <- tempfile(fileext = ".xlsx")
  download.file(url, destfile = temp, mode = "wb")
  read_excel(temp)
}

# Load datasets
df1 <- read_csv_url("https://raw.githubusercontent.com/1R0NCL4D-B4ST10N/DATA332/main/carTracker/carTracker.csv")
df2 <- read_csv_url("https://raw.githubusercontent.com/nissou62/The-very-basics-of-R/main/shinymtcar_project/Data_Counting_Cars.csv")
df3 <- read_csv_url("https://raw.githubusercontent.com/nickhc41703/Data_332_assignments/main/Homework/counting_cars/counting_cars_final.csv")
df4 <- read_csv_url("https://raw.githubusercontent.com/TommyAnderson/Car-Data-Analysis/main/Car%20Data%20Collection.csv")
df5 <- read_excel_url("https://github.com/rohaanfarrukh/data332_counting_cars/raw/main/counting_cars_project/rscript/speed_counting_cars.xlsx")
df6 <- read_csv_url("https://raw.githubusercontent.com/retflipper/DATA332_CountingCars/main/data/Counting_Cars.csv")
df7 <- read_excel_url("https://github.com/kritansth/data332/raw/main/counting_cars/cars_count.xlsx")

# Safe and robust wrangling
standardize_df <- function(df) {
  colnames(df) <- tolower(gsub("[	
]", "", trimws(colnames(df))))

  df <- df %>%
    rename(
      mph = tidyselect::matches("mph|final_speed|speed.*mph", ignore.case = TRUE),
      description = tidyselect::matches("color|brand", ignore.case = TRUE),
      student = tidyselect::matches("collector.*name|observer|recorder|name|student", ignore.case = TRUE)
    )

  required_cols <- c("mph", "description", "student")
  for (col in required_cols) {
    if (!(col %in% names(df))) {
      df[[col]] <- NA
    }
  }

  df <- df %>%
    select(mph, description, student) %>%
    mutate(
      mph = as.numeric(mph),
      description = as.character(description),
      student = as.character(student)
    ) %>%
    filter(!is.na(mph))

  return(df)
}

# Clean all
df1_clean <- standardize_df(df1)
df2_clean <- standardize_df(df2)
df3_clean <- standardize_df(df3)
df4_clean <- standardize_df(df4)
df5_clean <- standardize_df(df5)
df6_clean <- standardize_df(df6)
df7_clean <- standardize_df(df7)

# Bind
dataset <- bind_rows(df1_clean, df2_clean, df3_clean, df4_clean, df5_clean, df6_clean, df7_clean) %>%
  mutate(
    description = trimws(tolower(description)),
    student = trimws(student)
  )

column_names <- colnames(dataset)

# UI
ui <- fluidPage(
  theme = bs_theme(version = 5, bootswatch = "darkly"),
  titlePanel("Car Tracking Analysis Dashboard (All Sources)"),
  tabsetPanel(
    tabPanel("Data Explorer",
      sidebarLayout(
        sidebarPanel(
          selectInput("X", "Choose X", column_names, "description"),
          selectInput("Y", "Choose Y", column_names, "mph"),
          selectInput("Splitby", "Split By", column_names, "student")
        ),
        mainPanel(plotOutput("plot_01"))
      )
    ),
    tabPanel("Description by Student", plotOutput("description_barplot")),
    tabPanel("Speed Histogram", plotOutput("speed_hist")),
    tabPanel("Speed by Student", plotOutput("speed_boxplot")),
    tabPanel("Summary Statistics", verbatimTextOutput("stats_output")),
    tabPanel("Data Table", DT::dataTableOutput("data_table"))
  )
)

# Server
server <- function(input, output) {
  output$plot_01 <- renderPlot({
    ggplot(dataset, aes_string(x = input$X, y = input$Y, colour = input$Splitby)) +
      geom_point(size = 3, alpha = 0.7) +
      theme_minimal() +
      labs(title = "Data Explorer")
  })

  output$description_barplot <- renderPlot({
    ggplot(dataset, aes(x = description, fill = student)) +
      geom_bar(position = "dodge") +
      theme_minimal() +
      labs(title = "Car Description by Student", x = "Description", y = "Count")
  })

  output$speed_hist <- renderPlot({
    ggplot(dataset, aes(x = mph)) +
      geom_histogram(binwidth = 2, fill = "#738595", color = "black") +
      theme_minimal() +
      labs(title = "Distribution of Vehicle Speeds (MPH)", x = "Speed (MPH)", y = "Frequency")
  })

  output$speed_boxplot <- renderPlot({
    ggplot(dataset, aes(x = student, y = mph, fill = student)) +
      geom_boxplot(outlier.colour = "white", outlier.shape = 16, outlier.size = 2) +
      theme_minimal() +
      labs(title = "Speed by Student", x = "Student", y = "MPH")
  })

  output$stats_output <- renderPrint({
    stats <- dataset$mph
    min_row <- dataset[which.min(dataset$mph), ]
    max_row <- dataset[which.max(dataset$mph), ]
    cat(paste0("There are ", length(stats), " vehicle observations recorded.
"))
    cat(paste0("The minimum recorded speed is ", min(stats), " MPH, observed on a ", min_row$color, " car.
"))
    cat(paste0("The maximum recorded speed is ", max(stats), " MPH, observed on a ", max_row$color, " car.
"))
    cat(paste0("The average speed is ", round(mean(stats), 2), " MPH.
"))
    cat(paste0("The median speed is ", median(stats), " MPH.
"))
    cat(paste0("The standard deviation of speed is ", round(sd(stats), 2), " MPH.
"))
  })

  output$data_table <- DT::renderDataTable({
    DT::datatable(dataset, options = list(pageLength = 10))
  })
}

shinyApp(ui = ui, server = server)
