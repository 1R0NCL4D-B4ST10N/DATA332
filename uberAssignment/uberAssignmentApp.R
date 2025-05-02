# Load libraries
library(shiny)
library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(leaflet)
library(plotly)
library(reshape2)

# Load Data
apr <- read.csv("data/uber-raw-data-apr14.csv")
may <- read.csv("data/uber-raw-data-may14.csv")
jun <- read.csv("data/uber-raw-data-jun14.csv")
jul <- read.csv("data/uber-raw-data-jul14.csv")
aug <- read.csv("data/uber-raw-data-aug14.csv")
sep <- read.csv("data/uber-raw-data-sep14.csv")

# Combine data
uber_data <- bind_rows(apr, may, jun, jul, aug, sep)

# Format Date/Time
uber_data$Date.Time <- mdy_hms(uber_data$Date.Time)

# Create columns for analysis
uber_data <- uber_data %>%
  mutate(
    Hour = hour(Date.Time),
    Day = day(Date.Time),
    Month = month(Date.Time, label = TRUE, abbr = TRUE),
    Weekday = wday(Date.Time, label = TRUE, abbr = TRUE),
    Week = week(Date.Time)
  )

ui <- fluidPage(
  titlePanel("Uber Trips Data Analysis (April–September 2014)"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Explore Uber pickup trends, heatmaps, and geospatial maps."),
      helpText("GitHub Link: https://github.com/1R0NCL4D-B4ST10N/DATA332/tree/main/uberAssignment")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Trips by Hour and Month", plotlyOutput("hourMonthPlot")),
        tabPanel("Trips Every Hour", plotlyOutput("everyHourPlot")),
        tabPanel("Trips Every Day", plotlyOutput("everyDayPlot"), tableOutput("dailyTripsTable")),
        tabPanel("Trips by Day and Month", plotlyOutput("dayMonthPlot")),
        tabPanel("Trips by Month", plotlyOutput("monthPlot")),
        tabPanel("Trips by Base and Month", plotlyOutput("baseMonthPlot")),
        tabPanel("Heatmaps", 
                 plotlyOutput("heatHourDay"),
                 plotlyOutput("heatMonthDay"),
                 plotlyOutput("heatMonthWeek"),
                 plotlyOutput("heatBaseWeekday")
        ),
        tabPanel("Map", leafletOutput("uberMap"))
      )
    )
  )
)

server <- function(input, output) {
  
  ## Charts ####
  
  # Trips by Hour and Month
  output$hourMonthPlot <- renderPlotly({
    data <- uber_data %>% 
      group_by(Hour, Month) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Hour, y = Trips, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Trips by Hour and Month", x = "Hour", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Trips Every Hour
  output$everyHourPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Hour) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Hour, y = Trips)) +
      geom_line(group = 1) +
      geom_point() +
      labs(title = "Trips Every Hour", x = "Hour", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Trips Every Day
  output$everyDayPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Day) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Day, y = Trips)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(title = "Trips Every Day", x = "Day of Month", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Table of Trips Every Day
  output$dailyTripsTable <- renderTable({
    uber_data %>%
      group_by(Day) %>%
      summarise(Total_Trips = n()) %>%
      arrange(Day)
  })
  
  # Trips by Day and Month
  output$dayMonthPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Weekday, Month) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Weekday, y = Trips, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Trips by Day of the Week and Month", x = "Day", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Trips by Month
  output$monthPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Month) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Month, y = Trips)) +
      geom_bar(stat = "identity", fill = "orange") +
      labs(title = "Trips by Month", x = "Month", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Trips by Base and Month
  output$baseMonthPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Base, Month) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Base, y = Trips, fill = Month)) +
      geom_bar(stat = "identity", position = "dodge") +
      labs(title = "Trips by Base and Month", x = "Base", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  ## Heatmaps ####
  
  # Heatmap Hour and Day
  output$heatHourDay <- renderPlotly({
    data <- uber_data %>%
      group_by(Weekday, Hour) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Hour, y = Weekday, fill = Trips)) +
      geom_tile() +
      labs(title = "Heatmap: Hour vs Day", x = "Hour", y = "Day of Week") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Heatmap Month and Day
  output$heatMonthDay <- renderPlotly({
    data <- uber_data %>%
      group_by(Month, Day) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Day, y = Month, fill = Trips)) +
      geom_tile() +
      labs(title = "Heatmap: Month vs Day", x = "Day", y = "Month") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Heatmap Month and Week
  output$heatMonthWeek <- renderPlotly({
    data <- uber_data %>%
      group_by(Month, Week) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Week, y = Month, fill = Trips)) +
      geom_tile() +
      labs(title = "Heatmap: Month vs Week", x = "Week Number", y = "Month") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  # Heatmap Base and Day of Week
  output$heatBaseWeekday <- renderPlotly({
    data <- uber_data %>%
      group_by(Base, Weekday) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Weekday, y = Base, fill = Trips)) +
      geom_tile() +
      labs(title = "Heatmap: Base vs Day of Week", x = "Day of Week", y = "Base") +
      theme_minimal()
    
    ggplotly(gg)
  })
  
  ## Leaflet Map ####
  
  output$uberMap <- renderLeaflet({
    # Ensure proper column names exist and filter out bad points
    map_data <- uber_data %>%
      filter(!is.na(Lat), !is.na(Lon)) %>%
      slice_sample(n = 5000)  # Limit to 5,000 points for performance
    
    leaflet(map_data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~Lon,
        lat = ~Lat,
        radius = 2,
        color = "blue",
        stroke = FALSE,
        fillOpacity = 0.3
      )
  })
  
  
}

# Run App
shinyApp(ui = ui, server = server)
