library("dplyr")
library("ggplot2")
library("shiny")
library("styler")
library("lintr")
#style_file("ui.R")
#lint("ui.R")
source("ui.R")


dataset <- read.csv("data/athlete_events.csv", stringsAsFactors = F)
region_data <- read.csv("data/noc_regions.csv", stringsAsFactors = F)
dataset <- dataset%>%
  filter(Year >= "1980")

server <- function(input, output) {
#GRANT#
  filtered_data <- reactive ({
    filtered <- dataset %>%
      filter(Sex == input$sex,
             Sport == input$sport) %>%
      arrange(Team) %>% 
      group_by(Team) %>%
      summarize(count = n()) %>% 
      top_n(75, wt=count)
    
    return(filtered)
  })
  
  output$bargraph <- renderPlot({
    plot_m <- ggplot(filtered_data(), aes(x = Team, y = count)) +
      geom_col(width = 1) +
      coord_flip() +
      ggtitle(paste0("Sports distribution for", input$sex ,
                     "who participated in Olympic", input$sport, "since 1980")) +
      scale_fill_manual(values = c("#999999", "#E69F00", "#56B4E9"))  +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.text.y = element_text(size = 13),
            axis.text.x = element_text(size = 13))
    return(plot_m)
    #########
  }, height = 2000, width = 860)
  
#CARRIE#
filtered <- reactive({
  filtered <- dataset %>%
  filter(NOC == input$country,
         Year == input$year, !is.na(Medal)) %>%
  group_by(Sex, Medal)%>%
  arrange(NOC) %>%
  summarize(count = length(Medal))

  return(filtered)
})

output$medalplot <- renderPlot({
plot_m <- ggplot(filtered(), aes(x = Sex, y = count, fill = Medal)) +
  geom_col(width = 0.8) +
  coord_flip() + 
  ggtitle(paste0("Medal Counts for ", input$option, 
                 " at the ",input$year," Olympics")) +
  scale_fill_manual(values = c("darkgoldenrod4", "gold1", "gray62")) +
  theme(plot.title = element_text(size = 15, face = "bold"),
       axis.text.y = element_text(size = 13),
       axis.text.x = element_text(size = 13))
plot_m
#########
}, height = 800, width = 860)
#Hedy#

output$graph <- renderPlot({
  if(input$gender == "Both") {
    p <- ggplot(data = plot_data, mapping = aes_string(x=plot_data$Year, y=input$Type, 
                                                       group="Sex", color= "Sex")) +
      geom_point() +
      geom_line() +
      xlab("Year") +
      ggtitle(paste0("Trendline of both Athletes' ", input$Type)) +
      labs(paste0(title="The Trendline of Athletes' ", input$Type)) +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.text.y = element_text(size = 13),
            axis.text.x = element_text(size = 13))
  }else if(input$gender == "F") {
    new_data <- plot_data %>%
      filter(Sex == "F")
    p <- ggplot(data = new_data, mapping = aes_string(x=new_data$Year, y=input$Type, 
                                                      group="Sex", color= "Sex")) +
      geom_point(color = "#F8766D") +
      geom_line(color = "#F8766D") +
      xlab("Year") +
      ggtitle(paste0("Trendline of Female Athletes' ", input$Type)) +
      labs(paste0(title="The Trendline of Athletes' ", input$Type)) +
      theme(plot.title = element_text(size = 15, face = "bold"),
            axis.text.y = element_text(size = 13),
            axis.text.x = element_text(size = 13))
  }else{
    new_data <- plot_data %>%
      filter(Sex == "M")
    p <- ggplot(data = new_data, mapping = aes_string(x=new_data$Year, y=input$Type, 
                                                      group="Sex", color= "Sex")) +
      geom_point(color = "#00BFC4") +
      geom_line(color = "#00BFC4" ) +
      xlab("Year") +
      ggtitle((paste0("Trendline of Male Athletes' ", input$Type))) +
      labs(paste0(title="The Trendline of Athletes' ", input$Type)) +
       theme(plot.title = element_text(size = 15, face = "bold"),
          axis.text.y = element_text(size = 13),
          axis.text.x = element_text(size = 13))
  }
  return(p)
}, height = 800, width = 860)
}
# shinyApp(ui = my.ui, server = server)
