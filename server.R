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
}

