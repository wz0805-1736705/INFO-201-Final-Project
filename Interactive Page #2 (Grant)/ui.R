library('shiny')
library('plotly')


my.ui <- fluidPage(
  
  tabsetPanel(
    tabPanel(
      titlePanel("ronney"),
      h1("Analysis of the Average Rating Statistic"),
      sidebarLayout(
        sidebarPanel(
          selectInput("anime", "Choose the first anime", 
                      choices = c("Cowboy Bebop", "Naruto", "Spirited Away", "Monster", "One Piece", "Trigun", "Berserk", "Fullmetal Alchemist", "Slam Dunk", "Dragon Ball", "Prince of Tennis", "Trinity Blood"),
                      selected = "Naruto"),
          selectInput("anime2", "Choose a second anime to compare to", 
                      choices = c("Cowboy Bebop", "Naruto", "Spirited Away", "Monster", "One Piece", "Trigun", "Berserk", "Fullmetal Alchemist", "Slam Dunk", "Dragon Ball", "Prince of Tennis", "Trinity Blood"),
                      selected = "Cowboy Bebop"),
          h3("BACKGROUND:"),
          p("In this interactive bar graph, there are dropdown menus that allow for the selection of TWO different anime series to compare between. On the title of the graph, the overall average user rating of the anime is listed for perspective comparison."),
          
          h3("EXPLANATION OF THE GRAPH:"),
          p("This graph is split up into 10 different sections, which represent what users rated the anime as (from 10% to 100%). When you hover over a specific bar, you will be able to see how many users voted for this specific rating. This gives us greater insight on where the Overall Rating Percentage comes from because we can see specifically what ratings contributed to the overall score.") 
         ),
        
        mainPanel(
          plotlyOutput("bargraph")
        )
      )
      ),
      
      tabPanel(
        titlePanel("jwang/zach"),
        sidebarLayout(
          sidebarPanel(
            radioButtons("ageR","Age Rating:",
                         choices = c("R", "PG", "G"),
                         selected = "PG"),
            radioButtons("showTypes", "Overview of Showtypes or Specific Anime",
                         choices = c("Overview", "Specific")),
            selectInput("specificAnime", "Choose an Anime",
                        choices = c("Neon Genesis Evangelion", 
                                    "Rurouni Kenshin: Meiji Kenkaku Romantan",
                                    "Mobile Suit Gundam", "Cowboy Bebop",
                                    "El Hazard", "Hunter x Hunter",
                                    "Initial D", "Love Hina"), 
                        selected = "Neon Genesis Evangelion"),
            radioButtons("type","Show Type:",
                         choices = c("TV", "movie", "OVA", "special"))
          ),
          
          mainPanel(
            plotlyOutput("scatterplot"),
            plotlyOutput("pie")
          )
        )
      )
    )
) 

shinyUI(my.ui)