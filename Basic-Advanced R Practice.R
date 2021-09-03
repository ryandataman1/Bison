devtools::install_github("BillPetti/baseballr")

connection: Bison
host : bison.cwaea81emev3.us-east-2.rds.amazonaws.com
Username: Ryan
Password: BisonData1

library(odbc)
install.packages("RMySQL")
library(RMySQL)
library(dplyr)
library(ggplot2)

## connecting sql in Rtest = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")
## return all tables in database

rs = dbSendQuery(test,"show tables")

# displays our tables in the database

fetch(rs,1)

## select * takes all rows and columns from the table we are pulling from
all_rows <- dbSendQuery(test,"select * from lipscomb.trackmanv2")#

# We are creating a Trackman dataframe just like we would read a csv in... now we can play around with the file
Trackman <- fetch(all_rows,-1)

### remember we wont to practice using DPLYR here, I also want to introduce you to other BaseR methods## Look at the column names in Trackman
colnames(Trackman)#

# choose one column also known as a vector in R to pull this out one way to do this is using $# Dataframe$columnnameTrackman$PitcherTeam ## returns all teams in the data set## If I want to see all unique teams .... we can do the same thing with Uniqueunique(Trackman$PitcherTeam)## Selecting columns# we can either go with Dataframe, column1,column2 select(Trackman,HomeTeam,Level,AutoPitchType)## what I prefer is using the pipe / that way we can add things on to eachotherTrackman %>% select(HomeTeam,Level,AutoPitchType)

## every query starts with a select statement and we have to select it FROM a table

#Select * will return all columns
SELECT * 
  FROM lipscomb.trackmanv2;

# Remember in R we use select to choose columns, in SQL we should be able to just choose them by typing in the name
# of the column

# If I just want the pitcher column and Batter you will write in the column name after Select Pitcher,Batter 
from lipscomb.trackmanv2;

## Filter in R == WHERE in SQL

### I want to see all pitches WHERE PitcherTEAM is = KEN_OWL## this is how I would do that
SELECT * 
  FROM lipscomb.trackmanv2
where  pitcherTeam = 'KEN_OWL' ;

## I want to see all the pitchers who do not pitch for KEN_OWl here we would use the != 'KEN_OWL'
SELECT * 
  FROM lipscomb.trackmanv2
where  pitcherTeam != 'KEN_OWL' ;

## Lets say I had I did not want have to spell KEN_OWLS right, 

# I can use a wildcard which we see below allows you to not have to spell right# For a wildcard we use WHERE columnname LIKE and then if the letter starts with k#'k%' if it ends with '%k' if there is a k in there somewhere we can do '%k%'select * 
FROM 
lipscomb.trackmanv2
where pitcherTeam like 'K%';

SELECT * 
  FROM lipscomb.trackmanv2
where  pitcherTeam != 'KEN_OWL' 

select count(*) from lipscomb.trackmanv2 

SELECT count(*) FROM lipscomb.trackmanv2
WHERE pitcherteam != 'KEN_OWL' ;

## every query starts with a select statement and we have to select it FROM a table

#Select * will return all columnsselect * from lipscomb.trackmanv2;SELECT AutoPitchType,PitcherTeam,Date, Pitcher, avg(Relspeed) as `Avg Velo`,max(RelSpeed) `Max Velo`, count(*) as PitchTotal
FROM lipscomb.trackmanv2
group by AutoPitchType,Pitcher,Date
having AutopitchType like '%Four%'
order by Date,Pitcher,PitchTotal;select distinct Pitcher
from lipscomb.trackmanv2;

# Remember in R we use select to choose columns, in SQL we should be able to just choose them by typing in the name

# of the column 

# If I just want the pitcher column and Batter you will write in the column name after 
Select Pitcher,Batter 
from lipscomb.trackmanv2;

## Filter in R == WHERE in SQL

### I want to see all pitches WHERE PitcherTEAM is = KEN_OWL

## this is how I would do that
SELECT * 
  FROM lipscomb.trackmanv2
where  pitcherTeam = 'KEN_OWL' ;

## I want to see all the pitchers who do not pitch for KEN_OWl here we would use the != 'KEN_OWL'
SELECT * 
  FROM lipscomb.trackmanv2
where  pitcherTeam != 'KEN_OWL' ;

## Lets say I had I did not want have to spell KEN_OWLS right, 

# I can use a wildcard which we see below allows you to not have to spell right

# For a wildcard we use WHERE columnname LIKE and then if the letter starts with k

#'k%' if it ends with '%k' if there is a k in there somewhere we can do '%k%'
select * 
  FROM 
lipscomb.trackmanv2
where pitcherTeam like 'K%';


library(ggplot2)
library(dplyr)
library(baseballr)
library(readxl)
library(janitor)

## Read in xlsx, with colnames false
Ike_August <- read_xlsx("Ike/August 2020 Ike Buxton Rapsodo Data.xlsx",col_names = F)

# sliced off empty rows on top and bottom Ike_August2 <- Ike_August %>% slice(4:25) %>%
row_to_names(row_number = 1)# group by (to group by the correct pitch type) / summarise(summarise groups / means / maxs/ medians) // sort order by 
## in R // arrange### change vectors to be numeric vectorsIke_August2$`Strike Zone Height` <- as.numeric(Ike_August2$`Strike Zone Height`)Ike_August2$Velocity <- round(as.numeric(Ike_August2$Velocity),0)(Ike_August_Averages <- Ike_August2 %>% group_by(`Pitch Type`) %>% summarise(Pitchcount = n(),AvgStHeight = mean(`Strike Zone Height`)) %>% arrange(desc(Pitchcount)))

test = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'MLB',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")
## return all tables in database
rs = dbSendQuery(test,"select * from MLB.fangraphs_pitchers")
dw = dbSendQuery(test,"select * from MLB.fangraphs_hitters")
# displays our tables in the database
fangraphs_pitchers <- fetch(rs)
fangraphs_hitters <- fetch(dw)


library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)test = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'MLB',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
rs = dbSendQuery(test,"select * from MLB.fangraphs_hitters")

# displays our tables in the database
fangraphs_hitters <- fetch(rs)

# if we want to run colnamescolnames(fangraphs_hitters)# lets select two columns - name and age, runs, hits, fangraphs_hitters %>% select(Name,Age,R,H,Team)# select name,Age, R,H,BB,SO,AVG,Team save it as fg_test## make a scatter plot using two variables of ur choice # count of hitters per team
fangraphs_hitters %>% group_by(Team) %>% count()# use group by and calculate the mean of batting avg / sb and R by team, save the dataframe as stats_by_team# use mutate to add a new column -- new column should be R * H, name it R_H# use arrange to sort fg hitters by desc HR total

library(RMySQL)name_of_your_file <- read_csv(")
test = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'Lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")
## return all tables in database
dbWriteTable(test,name = "trackmanv2",append = T,name_of_your_file)
# displays our tables in the database

library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)trackman1 <- read.csv("Data/20210319-Lipscomb-1_unverified.csv")
trackman2 <- read.csv("Data/20210320-Lipscomb-1_unverified (1).csv")
trackman3 <- read.csv("Data/20210321-Lipscomb-1_unverified.csv")

# concatanate / trackman_4_all <- rbind(trackman1,trackman2,trackman3)BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# displays our tables in the databasefetch(all_tables)

