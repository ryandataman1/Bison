# read in all packages
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

# how to name a variable

Name_of_variable <- ("")

# number
x <- 2

# camelcase

# string / character
dayOfGame <- 'Monday'
todays_date <- 'Tuesday'

tomorrows_date <- 'Wednesday'

my_birthday <- 'April'

my_middle_name <- 'James'

# double / float / int / numeric

x <-2.3
y <- 7

# Lindor
batting_avg <- .301
On_base_percentage <- .323
Slg <- .601
OPS <- On_base_percentage + Slg
  
# Harden //// make a variable called shots 33 // make a variable called makes 11

shots <- 33
makes <- 11
# give me shooting percentage -- call it what u think u should assign it to // save it as a variable

shooting_percentage <- makes / shots


# as -- converting to data type /// is checking if it IS a type

# vector / List 

vandy_opponents <- c("Bama","A&M","Vols")

# create a vector 


vandy_games <- c(6,4,3)

vandy_wins <- c(3, 3, 2)

# total games

totalVandygames <- sum(vandy_games) 

meanvandygames <- mean(vandy_games) 

## Data frame is a r x c or a bunch of vectors put together, an excel sheet/ when we read in a csv


vandy_schedule <- data.frame(vandy_opponents,vandy_games,vandy_wins)

vandy_schedule$vandy_games

vandy_schedule$vandy_opponents

mean(vandy_schedule$vandy_games)

sum(vandy_schedule$vandy_games)


x <- 2

name <- "Ryan"

tutoring_days <- c ("monday", "wednesday", "friday")

day_hours <- c ("3", "3", "3")

total_tutoring <- data.frame(tutoring_days, day_hours)

total_tutoring$day_hours

total_tutoring$day_hours <- as.numeric(total_tutoring$day_hours)

# A function is anything in ()

#mean()

sum(total_tutoring$day_hours)

mean(total_tutoring$day_hours)


# dplyr ---- a package with a bunch of functions that make it easy to work with dfs

# select -- select is selecting the columns we want

#Selected pitch type and velocity from Van Treeck Aug 2020

Van_Treeck_August_Rapsodo_2020 %>% select (Pitch.Type, Velocity)

# Head will show you the amount of rows at the top of the chart

Van_Treeck_August_Rapsodo_2020 %>% select (Pitch.Type, Velocity) %>% head(12)

# Tail will show you the amount of rows from the bottom of the chart

Van_Treeck_August_Rapsodo_2020 %>% select (Pitch.Type, Velocity) %>% tail(12)


#sample

Van_Treeck_August_Rapsodo_2020 %>% select (Pitch.Type, Velocity) %>% sample()



## Another way of seeing all column names that are in a chart

colnames(Van_Treeck_August_Rapsodo_2020)

## how to sort
Van_Treeck_August_Rapsodo_2020 %>% select (Pitch.Type, Velocity) %>% head(12)

#select(Van_Treeck_August_Rapsodo_2020,Pitch.Type)


## Sorting with arrange for velocity from slowest to fastest 
Van_Treeck_March_Rapsodo_2021 %>% select (Pitch.Type,Velocity,Spin.Direction) %>% arrange(Velocity) %>% head(3)

Van_Treeck_March_Rapsodo_2021 %>% select (Pitch.Type,Velocity,Spin.Direction) %>% arrange(Velocity) %>%  tail (3)

# Use the desc

Van_Treeck_March_Rapsodo_2021 %>% select (Pitch.Type,Velocity,Spin.Direction) %>% arrange(desc(Velocity)) 

Van_Treeck_March_Rapsodo_2021 <- read.csv()


Van_Track_March_All <- Van_Treeck_March_Rapsodo_2021 %>% select (Pitch.Type,Velocity,Spin.Direction) %>% arrange(desc(Velocity)) 

write.csv(Van_Track_March_All, "Van Treeck March 2020 Rapsodo.csv")


##Additional information-------Need to get this information clarified what its doing and how it relates

# This is fixing the Bellarmine game to show the proper name in the column

Bellarmine_all <- Bellarmine_all %>% rename(`Top/Bottom` = Top.Bottom)

# write to database

dbWriteTable(BISON_Lipscomb, name='trackmanv2', Bellarmine_all, append=TRUE)

#To change the name of a table-- all you have to do is change the name


#Changing name of table to batting practice????


# dbWriteTable(BISON_Lipscomb, name='batting_practice', , append=TRUE)---- Just needs to be edited properly

# ????

trackman <- dbSendQuery(BISON_Lipscomb,"select * from trackmanv2 limit 5")

# Fetch means to take the trackman data 

test <- fetch(trackman)

# Read in Trackman Data and create 10 scatter plots  

Bierman_May_Rapsodo_2021 %>% ggplot(aes(x =Velocity, y = Spin.Efficiency..release., color= Pitch.Type))+ geom_point() + ggtitle("Bierman May Rapsodo 2021") + theme_gray()

