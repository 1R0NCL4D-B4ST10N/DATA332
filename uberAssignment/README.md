# Uber Trip Analysis Dashboard (April–September 2014)

This Shiny application analyzes Uber pickup data in New York City from April to September 2014. The app features interactive charts, heatmaps, a Leaflet-based geospatial map, and a simple predictive model. Each output is presented in its own tab for easy grading and exploration.

---

## Shiny App Deployment

View the deployed app here:  
[https://1r0ncl4d-b4st10n.shinyapps.io/uberAssignment/]

---

## How to Run Locally

1. Clone or download this repository.
2. Place all six CSV files into a folder named `data/`.
3. Open `uberAssignmentApp.R` in RStudio.
4. Run the app.

## Folder Structure

```
Uber_Trips_Project/
├── uberAssignmentApp.R            # Shiny application file
├── README.md        # Project documentation (this file)
└──	data
	├── uber-raw-data-apr14.csv
	├── uber-raw-data-may14.csv
	├── uber-raw-data-jun14.csv
	├── uber-raw-data-jul14.csv
	├── uber-raw-data-aug14.csv
	└── uber-raw-data-sep14.csv
```

---

## Chart Tabs in the Shiny App

### 1. Trips by Hour and Month

```r
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
```

---

### 2️. Trips Every Hour

```r
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
```

---

### 3️. Trips Every Day (Chart and Table)

```r
	output$everyDayPlot <- renderPlotly({
    data <- uber_data %>%
      group_by(Day) %>%
      summarise(Trips = n())
    
    gg <- ggplot(data, aes(x = Day, y = Trips)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(title = "Trips Every Day", x = "Day of Month", y = "Number of Trips") +
      theme_minimal()
    
    ggplotly(gg)
	
	output$dailyTripsTable <- renderTable({
    uber_data %>%
      group_by(Day) %>%
      summarise(Total_Trips = n()) %>%
      arrange(Day)
  })
  })
```

---

### 4️. Trips by Day of Week and Month

```r
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
```

---

### 5️. Trips by Month

```r
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
```

---

### 6️. Trips by Base and Month

```r
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
```

---

## Heatmap Tabs in the Shiny App

### 1. Hour vs Day of Week

```r
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
```

---

### 2. Month vs Day of Month

```r
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
```

---

### 3. Month vs Week Number

```r
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
```

---

### 4. Base vs Day of Week

```r
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
```

---

##️ Leaflet Geospatial Map

Displays all Uber pickup points on a map using latitude and longitude. Currently not working for some reason.

```r
	output$uberMap <- renderLeaflet({
    
    map_data <- uber_data %>%
      filter(!is.na(Lat), !is.na(Lon)) %>%
      slice_sample(n = 5000)
    
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
```

---

## Data Preparation

### Read & Combine CSVs

```r
	# Load Data
	apr <- read.csv("data/uber-raw-data-apr14.csv")
	may <- read.csv("data/uber-raw-data-may14.csv")
	jun <- read.csv("data/uber-raw-data-jun14.csv")
	jul <- read.csv("data/uber-raw-data-jul14.csv")
	aug <- read.csv("data/uber-raw-data-aug14.csv")
	sep <- read.csv("data/uber-raw-data-sep14.csv")

	# Combine data
	uber_data <- bind_rows(apr, may, jun, jul, aug, sep)
```

### Convert Date/Time and Extract Features

```r
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
```

---


## Author Info

**Name**: *Xander Williams*  
**Course**: *DATA-332*  
**Instructor**: *John Brosius*  
**Term**: *Fall 2025*
