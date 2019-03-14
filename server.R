# Load needed libraries
library("dplyr")
library("ggplot2")
library("shiny")
source("ui.R")


# Read in the dataset
dataset <- read.csv("data/athlete_events.csv", stringsAsFactors = F)
region_data <- read.csv("data/noc_regions.csv", stringsAsFactors = F)
# Filter to data of Olympics after 1980
dataset <- dataset %>%
  filter(Year >= "1980")

# Create a shiny server
server <- function(input, output, session) {

  # Alex: Elements crafted & CSS, introduction page#
  # Add the countdown timer
  event_time_day <- difftime(as.Date("2020-06-24"), Sys.time(),
    units = "mins"
  ) + 60 * 7
  if (round(event_time_day / 24 / 60) > event_time_day / 24 / 60) {
    time_to_event_day <- event_time_day / 24 / 60 - 1
  } else {
    time_to_event_day <- event_time_day / 24 / 60
  }
  event_time_hour <- (event_time_day / 24 / 60 - round(time_to_event_day)) * 24
  if (round(event_time_hour) > event_time_hour) {
    time_to_event_hour <- round(event_time_hour) - 1
  } else {
    time_to_event_hour <- round(event_time_hour)
  }
  output$event_time_remaining <- renderText({
    invalidateLater(1000)
    paste(round(time_to_event_day), "DAYS", time_to_event_hour, "HOURS")
  })

  # GRANT: Interactive page 1#
  # Filter the data 
  filtered_data <- reactive({
    filtered <- dataset %>%
      filter(
        Sex == input$sex,
        Sport == input$sport
      ) %>%
      arrange(Team) %>%
      group_by(Team) %>%
      summarize(count = n()) %>%
      top_n(75, wt = count)
    return(filtered)
  })
  # Plotout graph for male or female
  output$bargraph <- renderPlot({
    if (input$sex == "M") {
      plot_g <- ggplot(filtered_data(), aes(x = reorder(Team, count), y = count)) +
        geom_col(width = 0.8) +
        coord_flip() +
        ggtitle(paste0(
          "Sports distribution for ", input$sex,
          " who participated in Olympic ", input$sport, " since
          1980"
        )) +
        xlab("Country") +
        geom_bar(stat="identity", fill="#56B4E9") +
        geom_text(aes(label=count), position=position_dodge(width= 1), hjust= -0.25)
      theme(
        plot.title = element_text(size = 15, face = "bold"),
        axis.text.y = element_text(size = 13),
        axis.text.x = element_text(size = 13)
      )
    } else if (input$sex == "F") {
      plot_g <- ggplot(filtered_data(), aes(x = Team, y = count)) +
        geom_col(width = 0.8) +
        coord_flip() +
        xlab("Country") +
        ggtitle(paste0(
          "Sports distribution for ", input$sex,
          " who participated in Olympic ", input$sport, " since
        1980"
        )) +
        geom_bar(stat="identity", fill="#FF9999") +
        geom_text(aes(label=count), position=position_dodge(width= 1), hjust= -0.25)
      theme(
        plot.title = element_text(size = 15, face = "bold"),
        axis.text.y = element_text(size = 13),
        axis.text.x = element_text(size = 13)
      )}
    #Return plot
    return(plot_g)
  },
  height = 1500, width = 850
  )

  # CARRIE: Interactive page 2#
  # Create widget2 that update values based on previous value choosen
  observeEvent(input$year, {
    updateSelectInput(session, "Country",
      choices = unique(dataset$NOC[dataset$Year == input$year]),
      !is.na(dataset$Medal)
    )
  })

  # Filter the data
  filtered <- reactive({
    filtered <- dataset %>%
      filter(
        Year == input$year,
        NOC == input$Country, !is.na(Medal)
      ) %>%
      group_by(Sex, Medal) %>%
      arrange(NOC) %>%
      summarize(count = length(Medal))

    return(filtered)
  })

  # Assign a reactive `renderPlot()`
  # function to the outputted 'medalplot' value
  output$medalplot <- renderPlot({
    plot_m <- ggplot(filtered(), aes(x = Sex, y = count, fill = Medal)) +
      geom_col(width = 0.8) +
      coord_flip() +
      ggtitle(paste0(
        "Medal Counts for ", input$Country,
        " at the ", input$year, " Olympics"
      )) +
      scale_fill_manual(values = c("darkgoldenrod4", "gold1", "gray62")) +
      theme(
        plot.title = element_text(size = 15, face = "bold"),
        axis.text.y = element_text(size = 13),
        axis.text.x = element_text(size = 13)
      )
    # return the plot
    plot_m
  },
  height = 800, width = 860
  )

  # Hedy#
  # Assign a reactive `renderPlot()`
  # function to the outputted 'graph' value
  output$graph <- renderPlot({
    if (input$gender == "Both") {
      p <- ggplot(data = plot_data, mapping = aes_string(
        x = plot_data$Year,
        y = input$Type,
        group = "Sex",
        color = "Sex"
      )) +
        geom_point() +
        geom_line() +
        xlab("Year") +
        ggtitle(paste0("Trendline of both Athletes' ", input$Type)) +
        labs(paste0(title = "The Trendline of Athletes' ", input$Type)) +
        theme(
          plot.title = element_text(size = 15, face = "bold"),
          axis.text.y = element_text(size = 13),
          axis.text.x = element_text(size = 13)
        )
    } else if (input$gender == "F") {
      new_data <- plot_data %>%
        filter(Sex == "F")
      p <- ggplot(data = new_data, mapping = aes_string(
        x = new_data$Year,
        y = input$Type,
        group = "Sex",
        color = "Sex"
      )) +
        geom_point(color = "#F8766D") +
        geom_line(color = "#F8766D") +
        xlab("Year") +
        ggtitle(paste0("Trendline of Female Athletes' ", input$Type)) +
        labs(paste0(title = "The Trendline of Athletes' ", input$Type)) +
        theme(
          plot.title = element_text(size = 15, face = "bold"),
          axis.text.y = element_text(size = 13),
          axis.text.x = element_text(size = 13)
        )
    } else {
      new_data <- plot_data %>%
        filter(Sex == "M")
      p <- ggplot(data = new_data, mapping = aes_string(
        x = new_data$Year,
        y = input$Type,
        group = "Sex",
        color = "Sex"
      )) +
        geom_point(color = "#00BFC4") +
        geom_line(color = "#00BFC4") +
        xlab("Year") +
        ggtitle((paste0("Trendline of Male Athletes' ", input$Type))) +
        labs(paste0(title = "The Trendline of Athletes' ", input$Type)) +
        theme(
          plot.title = element_text(size = 15, face = "bold"),
          axis.text.y = element_text(size = 13),
          axis.text.x = element_text(size = 13)
        )
    }
    # return the plot
    return(p)
  },
  height = 800, width = 860
  )
}
shinyServer(server)
