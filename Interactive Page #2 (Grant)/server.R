library(jsonlite)
library(plyr)
library(dplyr)
library(shiny)
library(plotly)
library(ggplot2)

#API limits one pull to 20 data values
data1 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=0")$data$attributes)
data2 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=20")$data$attributes)
data3 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=40")$data$attributes)
data4 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=60")$data$attributes)
data5 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=80")$data$attributes)
data6 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=100")$data$attributes)
data7 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=120")$data$attributes)
data8 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=140")$data$attributes)
data9 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=160")$data$attributes)
data10 <- flatten(fromJSON("https://kitsu.io/api/edge/anime?page%5Blimit%5D=20&page%5Boffset%5D=180")$data$attributes)

#combines the 10 dataframes into one data frame w/ 200 values
combined <- rbind.fill(list(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10))

data <- select(combined, canonicalTitle, showType, synopsis, averageRating, userCount, favoritesCount, startDate,
               endDate, popularityRank, ratingRank, ageRating, episodeCount, youtubeVideoId, 
               posterImage.original, coverImage.original)


Scatter.one <- function(d, x, y){
  p <- plot_ly(
    data = data, x = ~x, y = ~y, type = "scatter", mode = "markers", 
    marker = list(size = 10,
                  color = 'rgba(139, 72, 246, .9)',
                  line = list(color = 'rgba(166, 111, 236, .8)',
                              width = 2)))
}

Scatter.two <- function(d, x, y){
  p <- ggplot(d, aes_string( x = x, y = y)) + geom_point() +  geom_count(color = "rgba(139, 72, 246, .9") + 
    ggtitle("Viewer Count vs Favorite Count") + xlab("User Count") + ylab("Favorite Count")
  
  return(ggplotly(p))
}

bar <- function(newdata) {
  x <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, "100")
  y <- c(newdata$ratingFrequencies.2, newdata$ratingFrequencies.4,  newdata$ratingFrequencies.6,  
         newdata$ratingFrequencies.8,  newdata$ratingFrequencies.10,  newdata$ratingFrequencies.12,
         newdata$ratingFrequencies.14,  newdata$ratingFrequencies.16,  newdata$ratingFrequencies.18, 
         newdata$ratingFrequencies.20)
  
  plot_ly(data, x = ~x, y = ~y,
          type = 'bar', 
          text = text,
          marker = list(color = 'rgb(158,202,225)',
                        line = list(color = 'rgb(8,48,107)',
                                    width = 1.5))) %>%
    layout(title = paste0("Average Rating for ",newdata$canonicalTitle," is: ",newdata$averageRating),
           xaxis = list(title = ""),
           yaxis = list(title = "")
    )
}

bar <- function(data1, data2) {
  title1 <- data1$canonicalTitle
  title2 <- data2$canonicalTitle
  dat1 <- data.frame(
    anime = factor(c(title1,title1,title1,title1,title1,title1,title1,title1,title1,title1,title2,title2,title2,title2,title2,title2,title2,title2,title2,title2)),
    rating = factor(c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)),
    voteFrequency = as.numeric(c(data1$ratingFrequencies.2, data1$ratingFrequencies.4, data1$ratingFrequencies.6, data1$ratingFrequencies.8, data1$ratingFrequencies.10, data1$ratingFrequencies.12, data1$ratingFrequencies.14, data1$ratingFrequencies.16, data1$ratingFrequencies.18, data1$ratingFrequencies.20,
                  data2$ratingFrequencies.2, data2$ratingFrequencies.4, data2$ratingFrequencies.6, data2$ratingFrequencies.8, data2$ratingFrequencies.10, data2$ratingFrequencies.12, data2$ratingFrequencies.14, data2$ratingFrequencies.16, data2$ratingFrequencies.18, data2$ratingFrequencies.20))
    
  )
  
  p <- ggplot(data=dat1, aes(x=rating, y=voteFrequency, fill=anime)) +
    geom_bar(colour="black", stat="identity",
           position=position_dodge(),
           size=.3) +                        # Thinner lines
    xlab("Rating that users voted for (%)") + ylab("Amount of votes") + # Set axis labels
    ggtitle(paste0(title1, " vs. ", title2, 
                 " Average user rating of (", data1$averageRating, "%) vs (", data2$averageRating, "%)")) +   # Set title
    theme_bw() 
  
  
  p <- ggplotly(p)
}
  
data.ratings <- select(combined, canonicalTitle, averageRating, ratingFrequencies.2, ratingFrequencies.3,
                       ratingFrequencies.4, ratingFrequencies.4, ratingFrequencies.5, ratingFrequencies.6,
                       ratingFrequencies.7, ratingFrequencies.8, ratingFrequencies.9, ratingFrequencies.10,
                       ratingFrequencies.11, ratingFrequencies.12, ratingFrequencies.13, ratingFrequencies.14,
                       ratingFrequencies.15, ratingFrequencies.16, ratingFrequencies.17, ratingFrequencies.18,
                       ratingFrequencies.19, ratingFrequencies.20)

my.server <- function(input, output) {
  output$bargraph <- renderPlotly({ 
    new.data <- filter(data.ratings, canonicalTitle == input$anime)
    new.data2 <- filter(data.ratings, canonicalTitle == input$anime2)
    return(bar(new.data, new.data2))
  }) 
}

shinyServer(my.server)