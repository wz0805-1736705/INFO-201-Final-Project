library("plotly")
library("shiny")
library("ggplot2")
library("dplyr")
library("styler")
library("lintr")
#style_file("ui.R")
# lint("ui.R")


ui <- fluidPage(
navbarPage("Olympics Games Interactive Statistics",
           
###GRANT#### 
    tabPanel("Sports distribution by countries",
      titlePanel("Analysis of Sports Distribution by Countries at the Olympics"),
      
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
    ), 

####CARRIE####
    tabPanel("Medal Count of Gender at the Olympics",
      titlePanel("Analysis of Medal Count of Gender at the Olympics"),
        sidebarLayout(
  sidebarPanel(
                   selectInput("year",
                               label = h4("Select the Games"),
                               choices = c(
                                 "1980", "1984", "1988", "1992", "1996",
                                 "2000", "2004", "2008", "2012", "2016"
                               ),
                               selected = 1
                   ),
                   selectInput("option",
                               label = h4("Select the gender"),
                               choices = c("M", "F", "Both"),
                               selected = 1
                   ),
                   helpText("This interactive allows you to select one
                            Olympics Games to see statistics of medal 
                            of female, male or both.")
                   ),
                 mainPanel(
                   plotOutput("medalplot"),
                   h3("Summary"),
                   p("Each bar on this graph illustrates the medal count of
                     each country in the specific year of the Olympics Games.
                     We can see a growing number of countries had female athletes
                     paticiapted in the Olympics and earned more medals in the game.
                     It is also worth noticing that USA has the largest number of medals
                     after 1996.")
                   )
                 )
    )
  ##########
  )
)
