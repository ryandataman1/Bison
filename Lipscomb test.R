# install.package
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

## connecting sql in R
test = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
rs = dbSendQuery(test,"show tables")

# displays our tables in the database
fetch(rs,1)

## select * takes all rows and columns from the table we are pulling from
all_rows <- dbSendQuery(test,"select * from lipscomb.trackmanv2")

## We are creating a Trackman dataframe just like we would read a csv in... now we can play around with the file
Trackman <- fetch(all_rows,-1)

### remeber we wont to practice using DPLYR here, I also want to introduce you to other BaseR methods
## Look at the column names in Trackman
colnames(Trackman)

## choose one column also known as a vector in R to pull this out one way to do this is using $
# Dataframe$columnname
Trackman$PitcherTeam ## returns all teams in the data set

## If I want to see all unique teams .... we can do the same thing with Unique
unique(Trackman$PitcherTeam)

## If I want to see to see all unique pitchers
unique(Trackman$Pitcher)

## Selecting columns
# we can either go with Dataframe, column1,column2 
select(Trackman,HomeTeam,Level,AutoPitchType)

## what I prefer is using the pipe / that way we can add things on to eachother
Pitch <- Trackman %>% select(HomeTeam,Level,AutoPitchType) %>%  filter(AutoPitchType== 'Four-Seam'|AutoPitchType=='Curveball')

Righties <- Trackman %>% filter(BatterSide == "Right")
