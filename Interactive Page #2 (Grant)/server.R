library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

### Data Wrangling

# our initial dataset from the CSV file
nba <- read.csv("./data/nba_season_data.csv", stringsAsFactors=FALSE)

# The NBA reorganized its teams in 2004, so we need this dataset for
# functions that organize statistics by team
nba2004 <- nba %>% filter(year >= 2004 & truesalary != "" & height > 0) %>%
  mutate(height.feet = height * 0.0833333)

# For our functions that do not organize by team, we can include all the teams from
# 1978 - 2016 (the year range provided in the CSV file)
modifieddata <- nba %>% filter(height > 0) %>% mutate(heightinft = height * 0.083)
heightsdata <- modifieddata %>% group_by(year) %>% summarize(mean = mean(heightinft))


### --------------- Tab 3: Height Versus Salary by Team --------------- ###

# Add a header
output$header.t3 <- renderUI({HTML(
  "<h1>Player Heights vs Salaries by Team and Season<h1/>")})

# Add an interactive plot
output$plot.t3 <- renderPlot({
  
  # Reactive function to read data from users
  specData <- eventReactive(input$update,{
    teamData <- nba2004 %>% filter(tm == input$team & year == input$year)
    teamData$truesalary <- as.numeric(gsub("[\\$,]","",teamData$truesalary))
    teamData <- arrange(teamData, truesalary)
  }, ignoreNULL = FALSE)
  
  # Handle exceptions with user input
  validate(need(nrow(specData()) > 0,
                "No data is availible for this query."))
  validate(need(input$year >= 2004 & input$year <= 2016,
                "Please choose a year between 2004 and 2016!"))
  
  # Create the plot
  ggplot(data = specData()) +
    geom_bar(mapping = aes(x = reorder(player, height.feet),
                           y = truesalary / 1e+6,
                           fill = height.feet),
             stat = "identity") +
    labs(x = "Player Name",
         y = "Salary (Dollars)")+
    coord_flip() +
    scale_fill_gradientn(colors = c("turquoise2", "violet", "navy"), 
                         guide = guide_colorbar(title = "Height (Feet)")) +
    scale_y_continuous(name = "Salary (US Dollars)",
                       labels = scales::dollar_format(
                         prefix = "$", suffix = " million",
                         largest_with_cents = 1e+5,
                         big.mark = "",
                         negative_parens = FALSE)) +
    theme(text = element_text(size=17)) +
    ggtitle(paste0(input$team, ", ", input$year, " Season"))
},
height = 500, width = 800)

# Add a summary paragraph
output$text.t3 <- renderUI({
  HTML(strrep("<br/>", 5),
       "<h4>Summary<h4/>",
       "<p>", read("txt/tab3/p1.txt"),
       "<p>", read("txt/tab3/p2.txt"),
       strrep("<br/>", 2)
  )
})