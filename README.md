# INFO-201-Final-Project

## Project Description

**1. What is the dataset you'll be working with?  Please include background on who collected the data, where you accessed it, and any additional information we should know about how this data came to be.**

The dataset we are working with is the [**Seattle Airbnb dataset**](https://www.kaggle.com/shanelev/seattle-airbnb-listings#seattle_01.csv) which is from _Shane Levine_ on Kaggle. The dataset was scrapped on December 19th, 2018 that contains about 8000 listings of current Airbnb listings in Seattle, and it was created with the help of [Tom Slee’s Airbnb Data collection codebase](https://github.com/tomslee/airbnb-data-collection). The purpose is to gain insight into Seattle’s short-term rental market. The information in it includes locations, prices, reviews, room types, and so on. 

**2. Who is your target audience?  Depending on the domain of your data, there may be a variety of audiences interested in using the dataset.  You should hone in on one of these audiences.**

Our target audience is a group of people who are interested in living in Seattle for a short period of time. People in this group are looking for accommodations in a certain area in Seattle for holiday or business trip. Airbnb, one of the most well-known online marketplace and hospitality service companies, offers choices to those people who are looking for a place to stay instead of the hotel. Our report will provide an analysis of the Seattle Airbnb from different aspects and help people gain an insight into their choices. 

**3. What does your audience want to learn from your data?  Please list out at least 3 specific questions that your project will answer for your audience.**

This dataset has a variety of data ranging from ratings, room types, price to locations and host ids. The viewers of this dataset will mainly look at the price ranges, ratings and locations of the listings even though there are additional data in the set. 
**Question 1:** Which listing is closest to downtown Seattle? 
**Question 2:** Which listing has the highest/lowest rating?
**Question 3:** Which listing is the most/least expensive?

## Technical Description

**4. How will you be reading in your data (i.e., are you using an API, or is it a static .csv/.json file)?**

We will use a **.csv** file from [Kaggle](https://www.kaggle.com/) as the source of this project. We will start by viewing it in excel to analyze what kind of pages we can create with the data. Then use data manipulation tools such as **dplyr/tidyr** and additional packages to have a visualize dataset. Finally, R Markdown everything to create an HTML file.

**5. What types of data-wrangling (reshaping, reformatting, etc.) will you need to do to your data?**

For our project, we will use a bunch of data-wrangling to demonstrate our data. As we said above, the dataset we are going to use is about the Airbnb in the Seattle area, and it contains room types, locations, reviews, price, etc. Thus, we are going to _reshape_ the data from raw format. We will rank the data based on different column properties, thus, we may use **extraction**, **parsing**, **filtering**, and **selecting** to our data in the group of the interests. Besides, we will make an interactive map to show the differences between particular data in different areas. To achieve this goal, we are going to _reformat_ the data in a group of different areas. What’s more, we may also **mutate** new columns to the data set we already have to show the new property. 

**6. What (major/new) libraries will be using in this project (no need to list common libraries that are used in many projects such as dplyr)**

The additional libraries we are going to use will mainly help us to draw different plots and graph, including: 
**ggplot2**,
**tidyr**,
**plotly**,
**leaflet**,
**shiny**.

**7. What major challenges do you anticipate?**

The major challenges that we anticipate are cooperating with teammates and putting our work on a website on different pages. Even if we already finished with the Assignment 7 under our cooperations, we still find a few problems in our team, for example, assigning members to different issues, communicating with each other, setting up a time for meeting, and so on. We are also not familiar with the **shiny** package, which we just learn this week, and this will cause some trouble for our team accomplishing the project.
