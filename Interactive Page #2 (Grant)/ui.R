library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  tabsetPanel(
    tabPanel(
      titlePanel("Sports distribution by countries"),
      h1("Analysis of sports distribution by countries"),
      sidebarLayout(
        sidebarPanel(
          selectInput("gender", "Choose a gender", 
                      choices = c("Male", "Female"),
                      selected = "Male"),
          selectInput("sport", "Choose a sport", 
                      choices = c("Athletics", "Badminton", "Basketball", "Boxing", "Cross country skiing", "Football", "Gymnastics", "Ice hockey", "Rowing", "Speed Skating", "Swimming", "Sailing"),
                      selected = "Athletics"),
          h3("Background:"),
          p("In this interactive bar graph, there are dropdown menus that allow for the selection of TWO different anime series to compare between. On the title of the graph, the overall average user rating of the anime is listed for perspective comparison."),
          
          h3("Summary:"),
          p("") 
         ),
        
        mainPanel(
          plotlyOutput("bargraph")
        )
      )
    )  
  )
)
shinyUI(my.ui)