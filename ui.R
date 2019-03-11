library("plotly")
library("shiny")
library("ggplot2")
library("dplyr")
# library("styler")
# library("lintr")
# style_file("ui.R")
# lint("ui.R")


ui <- fluidPage(
navbarPage("Olympics Games Interactive Statistics",

####CARRIE####
    tabPanel("Medal Count of Gender at the Olympics",
      titlePanel("Analysis of Medal Count of Gender at the Olympics"),
        sidebarLayout(
  sidebarPanel(
    selectInput("year",
                label = h4("Select the Games"),
                choices = c("1980", "1984", "1988", "1992", "1996",
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
        h3("Summary"),
        p("Each bar on this graph illustrates the medal count of
          each country in the specific year of the Olympics Games.
          We can see a notably growing number of countries with more
          female athletics paticiapted in the Olympics and earned
          more medals in the game. However, there is still an inequal
          number of participation of female and male athletics.
          It is also worth noticing that USA has the largest number of medals
          after 1996, and women athletics were earning almost equal number of medals,
          sometimes they have earned more compared to male athletics did."),
        plotOutput("medalplot")
        
)
)
),
  #####Hedy####
tabPanel(
  "Trends of Personal Information)",
  titlePanel("Trends of Athletes' Personal Information"),
  sidebarLayout(
    sidebarPanel(
      em("While there is huge development of society in the past about thirty years, the Olympic game 
         plays more important role in showing the strengh and energy of each country. Not only do better athletes 
         come to the game to represent their countries, but also the better trainings are provided. There is a
         trendline to show the change of height, weight, and age of athletes in different gender 
         for the sum of all countries since the game of 1980 to
         2016."),
      ("Choose a type of personal information below to see the trends"),
      selectInput(
        "Type", "Choose a Type： ", choices = colnames(plot_data[, 3:5])
      ),
      selectInput("gender", "Select the gender: ", choices = c("M", "F", "Both"),
                  selected = 1
      )
      ),
    mainPanel(plotOutput("graph"),
              strong("Summary"),
              ("For the three types of personal information, they all have an increased trends for both 
               male and female athletes. From this data visualization, we can observe an increasement
               of athletes' physical strength, while height and weight are both go up in average. In addtion, 
               the average age of athletes are increasing also. It suggets that more older athletes get 
               involved in Olympic games, not only because more older people are healthy enough to join, 
               but people keep their enthusiasm on sports game no matter if they get older or not.")
              )
              )
              )
  )
)
