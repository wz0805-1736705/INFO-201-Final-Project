library("dplyr")
library("ggplot2")
library("shiny")
library("styler")
library("lintr")
#style_file("ui.R")
#lint("ui.R")

shinyApp(ui = ui, server = server)
dataset <- read.csv("data/athlete_events.csv", stringsAsFactors = F)
dataset <- dataset%>%
  filter(Year >= "1980")

server <- function(input, output) {
#CARRIE#
filtered <- reactive({
  filtered <- dataset %>%
  filter(Sex == input$option,
         Year == input$year, !is.na(Medal)) %>%
  group_by(NOC, Medal)%>%
  arrange(NOC) %>%
  summarize(count = length(Medal))
  
  if(input$option == "Both"){
    filtered <- dataset %>%
      filter(Year == input$year, !is.na(Medal)) %>%
      group_by(NOC, Medal)%>%
      arrange(NOC) %>%
      summarize(count = length(Medal))
  }
  return(filtered)
})

output$medalplot <- renderPlot({
# fig.height = 10, fig.width = 5
plot_m <- ggplot(filtered(), aes(x = NOC, y = count, fill = Medal)) +
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
}, height = 800, width = 800)
output$graph <- renderPlot({
  newData <- gameDate %>%
    filter(Year >= 1980)
  height_weight_Age_info <- newData %>%
    select(Year, Height, Weight, Age, Sex)%>%
    filter(!is.na(Height) & !is.na(Weight) & !is.na(Age))
  plot_data <- height_weight_Age_info %>% 
    group_by(Year, Sex) %>%
    summarise("Height" = mean(Height), "Weight" = mean(Weight), "Age" = mean(Age))
  if(input$gender == "Both") {
    p <- ggplot(data = plot_data, mapping = aes_string(x=plot_data$Year, y=input$Type, 
                                                       group="Sex", color= "Sex")) +
      geom_point() +
      geom_line() +
      xlab("Year") +
      labs(paste0(title="The Trendline of Athletes' ", input$Type))
  }else if(input$gender == "F") {
    new_data <- plot_data %>%
      filter(Sex == "F")
    p <- ggplot(data = new_data, mapping = aes_string(x=new_data$Year, y=input$Type, 
                                                      group="Sex", color= "Sex")) +
      geom_point() +
      geom_line() +
      xlab("Year") +
      labs(paste0(title="The Trendline of Athletes' ", input$Type))
  }else{
    new_data <- plot_data %>%
      filter(Sex == "M")
    p <- ggplot(data = new_data, mapping = aes_string(x=new_data$Year, y=input$Type, 
                                                      group="Sex", color= "Sex")) +
      geom_point() +
      geom_line() +
      xlab("Year") +
      labs(paste0(title="The Trendline of Athletes' ", input$Type))
  }
  return(p)
})
}

