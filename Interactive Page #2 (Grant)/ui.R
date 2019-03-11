library(shiny)
library(ggplot2)
library(dplyr)

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
          p(""),
          
          h3("Summary:"),
          p("As we can see from the data, there is no obvious correlation between player heights and salaries. However, we can observe some small trends in this data from certain teams and certain seasons. For example, during recent seasons such as 2014 and 2015, many teams had outstanding shorter players with significant salaries, such as Stephen Curry, Kyrie Irving, Brandon Knight, Kyle Lowry, etc.Additionally, on most teams, the highest earners tend to be in the low to mid height range compared to their teammates, as well as a few outliers in the highest height ranges on some teams. Interestingly enough, we also see spikes in average turnovers per game for the 2004-2016 range in the low-mid and highest height ranges. This means highest earners are typically in the height ranges corresponding to spikes in average turnovers per game, but no other clear statistic. Although there is a correlation between these two observations, we cannot make any inferences on causality.") 
         ),
        
        mainPanel(
          plotlyOutput("bargraph")
        )
      )
    )  
  )
)
shinyUI(my.ui)

## Tab 3: Height vs. Salary
tabPanel("Height vs. Salary",
         sidebarLayout(
           sidebarPanel(
             selectInput(
               "team",
               "Select a team:",
               nba %>%
                 filter(year >= 2004 & truesalary != "") %>%
                 distinct(tm, .keep_all = TRUE) %>%
                 rename(Team = tm) %>%
                 select(Team),
               selected = "GSW"
             ),
             numericInput("year", "Enter a year:", 2015),
             helpText("Please type a year between 2004 and 2016"),
             actionButton("update", "Update View")
           ),
           mainPanel(htmlOutput("header.t3"),
                     plotOutput("plot.t3"),
                     htmlOutput("text.t3"))
         ))