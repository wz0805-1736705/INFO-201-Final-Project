library("shinythemes")
library("plotly")
library("shiny")
library("ggplot2")
library("dplyr")

height_weight_Age_info <- dataset %>%
  select(Year, Height, Weight, Age, Sex) %>%
  filter(!is.na(Height) & !is.na(Weight) & !is.na(Age))

plot_data <- height_weight_Age_info %>%
  group_by(Year, Sex) %>%
  summarise("Height" = mean(Height), "Weight" = mean(Weight), "Age" = mean(Age))

ui <- fluidPage(
  navbarPage(
    "Olympics Games Interactive Statistics",
    ##### Alex######
    tabPanel(
      "Introduction",
      titlePanel(
        tags$html(tags$body(
          tags$link(
            rel = "stylesheet", type = "text/css",
            href = "test.css"
          ),
          div(
            id = "Header",
            h1("Olympics Games Interactive Statistics Tool")
          ),
          div(
            id = "LeftPanel",
            textOutput("event_time_remaining"), br(), paste("TO"), br(),
            img(src = "olympic-games.png"), style = "color:#C44B4F"
          ),
          div(
            id = "RightPanel",
            h2("About this project", style = "color: #C44B4F"),
            p("The Olympic Games are leading international sporting
                       events being held in summer and winter, and thousands
                       of athletes all over the world participate in a variety
                       of competitions. Both male and female athletes bring us
                       exciting games for audience.", style = "margin-left:
                       90px;text-indent: 20px;"),
            p("In our project, our team members are going to have an
                       in-depth study for both male and femal athletes from
                       1980 to 2016 Oylmpic Games. We will compare them from
                       three different aspects,",
              strong("Personal Information (Height, Weight, Age)"), ",",
              strong("Medal Numbers (Gold, Silver, Bronze)"),
              ", and",
              strong("Top 10 Most Popular Sports"),
              style = "margin-left: 90px;text-indent: 20px;"
            ),
            p("Our project draws on data from",
              a("120 years of Olympic history: athletes and results",
                href = "https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results",
                style = "color: #145DA0;"
              ),
              "from Kaggle user",
              a("rgriffin",
                href = "https://www.kaggle.com/heesoo37",
                style = "color: #145DA0;"
              ),
              "which includes infromation on athletes from 1896 to
                       2016, and we filter the dataset for those after 1980
                       for more recent, modern Olympic Games.",
              style = "margin-left: 90px; text-indent: 20px;"
            ),
            div(
              id = "RightBottom",
              div(
                id = "image2",
                img(
                  src = "gender-image.png",
                  align = "right", width = "500px"
                )
              ),
              h2("Authors", style = "color: #C44B4F"),
              tags$ul(
                tags$li(a("Anjie Yao",
                  href = "mailto:anjieyao@uw.edu"
                )),
                tags$li(a("Zhan Wu",
                  href = "mailto:wz0805@uw.edu"
                )),
                tags$li(a("Hanjin Jiang",
                  href = "mailto:hedyj@uw.edu"
                )),
                tags$li(a("Shibo Yang",
                  href = "mailto:gryang@uw.edu"
                )),
                style = "list-style-type: circle;text-indent: 20px;
                                    margin-left: 73px;"
              )
            ),
            br(), br(), br(),
            p(
              "Source Code: ",
              a("GitHub",
                href = "https://github.com/wz0805-1736705/INFO-201-Final-Project",
                style = "color: #145DA0;"
              )
            )
          )
        ))
      )
    ),
    #### GRANT####
    tabPanel(
      "Sports distribution by countries",
      titlePanel(
        tags$body(
          tags$link(rel = "stylesheet", type = "text/css", href = "test.css"),
          tags$div(
            id = "Header",
            tags$h1("Analysis of Sports Distribution by Countries at
                            the Olympics")
          )
        )
      ),
      fluidRow(
        column(
          width = 4,
          div(div(
            br(), br(), selectInput("sex", h4("Choose a sex"),
              choices = c("M", "F"),
              selected = "M"
            ),
            selectInput("sport", h4("Choose a sport"),
              choices = c(
                "Athletics", "Badminton", "Basketball",
                "Boxing", "Cross Country Skiing", "Football",
                "Gymnastics", "Ice Hockey", "Rowing",
                "Speed Skating", "Swimming", "Sailing"
              ),
              selected = "Athletics"
            ),
            helpText("These two drop down menu options allows you to visualize
                 the male and female sports distributions by countries.")
          ),
          style = "margin-left: 75px; margin-right: 75px;"
          ),
          style = "height: 350px; width: 440px; margin-left: 16px; float: left;
                 background-color: #f5f5f5;border-radius: 25px;
                 border-right: 3px solid #C44B4F;
                 border-bottom: 3px solid #C44B4F;"
        ),
        column(
          width = 8,
          plotOutput("bargraph")
        ),
        fluidRow(column(
          width = 4,
          div(
            div(br(), h2("Summary"), style = "margin-left: 45px"),
            div(
              p("This interactive visualization page summarizes the male or
                female athletes of the Top 75 countries in their respective
                Olympic sports program. From this visualization, we can see
                a trend of overwhelming male to female differences in certain
                sports like: Boxing, Football, Ice Hockey, Etc. These programs
                are also considered as 'male dominant sports'. In addition, we
                can interpret which countries have a more mature sports program
                by looking at their total number of male and female athletes.
                For example, the United States and Australia clearly have a
                greater sum of players in their programs than the other
                countries, meaning they have a more mature program than the
                other countries. Users could explore more using the drop down
                menu and interpret the data furthermore."),
              style = "margin-left: 45px; margin-right: 45px; font-size: 15px;
            text-indent: 20px"
            ),
            style = "height: 490px; width: 440px; margin-left: 16px;
                   float: left;
                   background-color: #f5f5f5; border-radius: 25px;
                   border-right: 3px solid #C44B4F; border-bottom:
                   3px solid #C44B4F;"
          )
        ))
      )
    ),
    #### CARRIE####
    tabPanel(
      "Medal Count of Gender at the Olympics",
      titlePanel(
        tags$body(
          tags$link(rel = "stylesheet", type = "text/css", href = "test.css"),
          tags$div(
            id = "Header",
            tags$h1("Analysis of Medal Count of Country at the Olympics")
          )
        )
      ),
      fluidRow(
        column(
          width = 4,
          div(div(br(), br(), selectInput("year",
            label = h4("Select the Games"),
            choices =
              c(
                "1980", "1984", "1988", "1992", "1996",
                "2000", "2004", "2008", "2012", "2016"
              ), selected = "2016"
          ),
          selectInput("Country", h4("Select the Country"), choices = NULL),
          helpText("This interactive allows you to select one year of
                      Olympics Games from 1980 to 2016 and one country to
                      see statistics of medal of female and male. Nobody get
                     medals if blank."),
          style = "margin-left: 75px; margin-right: 75px;"
          ),
          style = "height: 350px; background-color: #f5f5f5;
                     border-radius: 25px; border-right: 3px solid #C44B4F;
                     border-bottom: 3px solid #C44B4F;"
          )
        ),
        column(
          width = 8,
          plotOutput("medalplot")
        )
      ),
      fluidRow(column(
        width = 4,
        div(
          div(br(), h2("Summary"), style = "margin-left: 45px"),
          div(
            p("Each bar on this graph illustrates the medal count of
                    the specific country in the specific year of the Olympics
                    Games. We can see a notably growing number of countries
                    with more female athletics paticiapted in the Olympics
                    and earnedmore medals in the game. It is also worth
                    noticing that women athletics from USA were earning
                    more medals compared to male athletics did since 2000.
                    For Canada, female athletics did better than male after
                    2008 with significant difference of the total medals in
                    2016. Also, countries such as India earned 2 medals in
                    the 2016 Olympics all by women athletics."),
            style = "margin-left: 45px; margin-right: 45px;
                           font-size: 15px; text-indent: 20px"
          ),
          style = "height: 390px; background-color: #f5f5f5; border-radius:
                       25px; border-right: 3px solid #C44B4F; border-bottom:
                       3px solid #C44B4F;"
        )
      ))
    ),
    ##### Hedy####
    tabPanel(
      "Trends of Personal Information",
      tags$body(
        tags$link(rel = "stylesheet", type = "text/css", href = "test.css"),
        tags$div(
          id = "Header",
          tags$h1("Trends of Athletes' Personal Information")
        )
      ),
      fluidRow(
        column(
          width = 4,
          div(div(br(), br(), br(),
            selectInput("Type", h4("Choose a Type:"),
              choices = colnames(plot_data[, 3:5])
            ),
            selectInput("gender", h4("Select the gender:"),
              choices = c("M", "F", "Both"),
              selected = 1
            ),
            helpText("This interactive allows you to select the type of personal
               information(height, weight, age) and gender to see the trends
               from 1980 to 2016"),
            style = "margin-left: 70px; margin-right: 70px;"
          ),
          style = "height: 350px; background-color: #f5f5f5;
                  border-radius: 25px; border-right: 3px solid #C44B4F;
                  border-bottom: 3px solid #C44B4F;"
          )
        ),
        column(
          width = 8,
          div(plotOutput("graph"))
        )
      ),
      fluidRow(column(
        width = 4,
        div(
          div(br(), h2("Summary"), style = "margin-left: 45px"),
          div(br(),
            p("The trendlines show the change of height, weight, and
            age of athletes in different gender for all the countries.
            It shows an increasing trends for all three personal info for
            both genders. We can observe an increasement of athletes' physical
            strength, height and weight, are both going up in average; in
            addition, the average age is also increasing, which suggests
            that more older athletes get involved in Olympic games, not
            only because more older people are healthy enough to join,
            but people keep their enthusiasm on sports game no matter if
            they get older or not."),
            style = "margin-left: 45px; margin-right: 45px; font-size: 15px;
                   text-indent: 20px"
          ),
          style = "height: 390px; background-color: #f5f5f5; border-radius:
             25px; border-right: 3px solid #C44B4F; border-bottom: 3px solid
             #C44B4F;"
        )
      ))
    )
  ),
  tags$style(
    type = "text/css", ".navbar { background-color: #262626;
                           font-family: Arial;
           font-size: 15px;
           color: #FF0000; }",
    ".navbar-default .navbar-brand {
           color: #cc3f3f;
           }"
  )
)

shinyUI(ui)