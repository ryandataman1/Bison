# Read in all packages
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)
library(plotly)
library(DT)

# Read in all Rapsodo csvs from 2020-2021 season

# Logan Van Treeck 2020-2021 Season Rapsodo Data

Van_Treeck_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/August 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_September_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/September 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/October 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/January 2021 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_February_Rapsodo_2021 <- read.csv ("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/February 2021 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/March 2021 Logan Van Treeck  Rapsodo Data-1.csv")
Van_Treeck_May_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/May 2021 Logan Van Treeck Rapsodo Data-1.csv")

# Combining all of Van Treeck Rapsodo Bullpens 2020-2021
Van_Treeck_Rapsodo_All <- rbind (Van_Treeck_August_Rapsodo_2020,Van_Treeck_September_Rapsodo_2020,Van_Treeck_October_Rapsodo_2020,Van_Treeck_January_Rapsodo_2021,Van_Treeck_February_Rapsodo_2021, Van_Treeck_March_Rapsodo_2021, Van_Treeck_May_Rapsodo_2021)

# Connecting R to SQL Bison Database
BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

# Return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# Displays our tables in the database
fetch(all_tables)

# Write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Van_Treeck_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Selecting the columns that you do not want; this will add in all the ones you want
Van_Treeck_Rapsodo_All <- Van_Treeck_Rapsodo_All %>% select(-c(ï..No))

# Selected pitch type and velocity from Van Treeck 2020-2021 season

Van_Treeck_Rapsodo_2020_2021 <- Van_Treeck_Rapsodo_All %>% select (Pitch.Type, Velocity) 

write.csv(Van_Treeck_Rapsodo_2020_2021, "Van_Treeck Rapsodo 2020-2021.csv")

# Write / make a .csv

write.csv(Van_Treeck_Rapsodo_All, "Van Treeck 2020-2021 Rapsodo.csv")

# Graphs ggplot2 / dplyr filtering/ sorting

Van_Treeck_Rapsodo_All %>% ggplot(aes(x = Velocity, y = Total.Spin, color= Pitch.Type))+ geom_point() +
ggtitle("Van Treeck Rapsodo Data 2020-2021") + theme_gray() 

colnames(Van_Treeck_August_Rapsodo_2020)

# Practicing select statement using dplyr package

Van_Treeck_Rapsodo_All %>%  dplyr::select(Velocity,Pitch.Type)

Van_Treeck_Rapsodo_All %>%  dplyr::group_by(Pitch.Type) %>% dplyr::summarise("Average Velocity" = mean(Velocity)) %>%
dplyr::rename("Pitch Type" = Pitch.Type)

colnames(Van_Treeck_Rapsodo_All)

# Dylan Bierman 2020-2021 Season Rapsodo Data

Bierman_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/August 2020 Dylan Bierman Rapsodo Data-1.csv")
Bierman_September_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/September 2020 Dylan Bierman Rapsodo Data-1.csv")
Bierman_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/October 2020 Dylan Bierman Rapsodo Data-1.csv")
Bierman_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/January 2021 Dylan Bierman Rapsodo Data-1.csv")
Bierman_February_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/February 2021 Dylan Bierman Rapsodo Data-1.csv")
Bierman_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/March 2021 Dylan Bierman Rapsodo Data-1.csv")
Bierman_May_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Bierman/Raw Data/May 2021 Dylan Bierman Rapsodo Data-1.csv")

# combining all of Bierman Rapsodo Bullpens 2020-2021
Bierman_Rapsodo_All <- rbind (Bierman_August_Rapsodo_2020,Bierman_September_Rapsodo_2020,Bierman_October_Rapsodo_2020,Bierman_January_Rapsodo_2021,Bierman_February_Rapsodo_2021,Bierman_March_Rapsodo_2021,Bierman_May_Rapsodo_2021)

Bierman_Feb_Velo_Avg <- Bierman_February_Rapsodo_2021 %>% dplyr::group_by(Pitch.Type) %>% dplyr::summarise("Average Velocity"= mean(Velocity))

write.csv(Bierman_Feb_Velo_Avg, "February 2021-Bierman.csv")


# Connecting R to SQL Bison Database

BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# displays our tables in the database
fetch(all_tables)

# write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Bierman_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Selecting columns minus the one you don't want
Bierman_Rapsodo_All <- Bierman_Rapsodo_All %>% select(-c(ï..No))

# Selected pitch type and velocity from Van Treeck 2020-2021 season

Bierman_Rapsodo_Whole_Year <- Bierman_Rapsodo_Whole_Year %>% select (Pitch.Type, Velocity) 

write.csv(Bierman_Rapsodo_Whole_Year, "Bierman Rapsodo 2020-2021 Pitch Type and Velocity.csv")

# Write / make a .csv

write.csv(Bierman_Rapsodo_All, "Bierman 2020-2021 Rapsodo.csv")

# Graphs ggplot2 / dplyr filtering/ sorting

Bierman_May_Rapsodo_2021 %>% ggplot(aes(x =Velocity, y = Spin.Efficiency..release., color= Pitch.Type))+ geom_point() +
ggtitle("Bierman May Rapsodo 2021") + theme_gray()

# Ike Buxton 2020-2021 Season Rapsodo Data

Buxton_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/August 2020 Ike Buxton Rapsodo Data-1.csv")
Buxton_September_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/September 2020 Ike Buxton Rapsodo Data-1.csv")
Buxton_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/October 2020 Ike Buxton Rapsodo Data-1.csv")
Buxton_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/January 2021 Ike Buxton Rapsodo Data-1.csv")
Buxton_February_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/February 2021 Ike Buxton Rapsodo Data-1.csv")
Buxton_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/March 2021 Ike Buxton Rapsodo Data-1.csv")
Buxton_May_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Buxton/Raw Data/May 2021 Ike Buxton Rapsodo Data-1.csv")

# Combining all of Buxton Rapsodo Bullpens 2020-2021
Buxton_Rapsodo_All <- rbind (Buxton_August_Rapsodo_2020,Buxton_September_Rapsodo_2020,Buxton_October_Rapsodo_2020,Buxton_January_Rapsodo_2021,Buxton_February_Rapsodo_2021,Buxton_March_Rapsodo_2021,Buxton_May_Rapsodo_2021)

# Connecting R to SQL Bison Database

BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

# Return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# Displays our tables in the database
fetch(all_tables)

# Write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Buxton_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Checking column names using pipe operator???
Buxton_Rapsodo_All <- Buxton_Rapsodo_All %>% select(-c(ï..No))

# Write / make a .csv

write.csv(Buxton_Rapsodo_All, "Buxton 2020-2021 Rapsodo.csv")

# Matthew Maldonado 2020-2021 Season Rapsodo Data

Maldonado_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/August 2020 Matthew Maldonado Rapsodo Data-1.csv")
Maldonado_September_Rapsodo_2020 <- read.csv ("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/September 2020 Matthew Maldonado Rapsodo Data-1.csv")
Maldonado_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/October 2020 Matthew Maldonado Rapsodo Data-1.csv")
Maldonado_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/January 2021 Matthew Maldonado Rapsodo Data-1.csv")
Maldonado_February_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/February 2021 Matthew Maldonado Rapsodo Data-1.csv") 
Maldonado_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Maldonado/Raw Data/March 2021 Matthew Maldonado Rapsodo Data-1.csv")

# Combining all of Bierman Rapsodo Bullpens 2020-2021
Maldonado_Rapsodo_All <- rbind (Maldonado_August_Rapsodo_2020,Maldonado_September_Rapsodo_2020,Maldonado_October_Rapsodo_2020,Maldonado_January_Rapsodo_2021,Maldonado_February_Rapsodo_2021,Maldonado_March_Rapsodo_2021)

# Connecting R to SQL Bison Database

BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

# Return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# Displays our tables in the database
fetch(all_tables)

# Write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Maldonado_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Checking column names using pipe operator???--> make sure you do this first before dbwriteTable
Maldonado_Rapsodo_All <- Maldonado_Rapsodo_All %>% select(-c(ï..No))

# Write / make a .csv

write.csv(Maldonado_Rapsodo_All, "Maldonado 2020-2021 Rapsodo.csv")

# Graphs ggplot2 / dplyr filtering/ sorting

Maldonado_October_Rapsodo_2020 %>% ggplot (aes (x= Release.Side, y= Release.Angle, color=Pitch.Type))+geom_point() + ggtitle ("Maldonado Rapsodo Pitch Data October 2020")

# Patrick Williams 2020-2021 Season Rapsodo Data

Williams_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/August 2020 Patrick Williams Rapsodo Data-1.csv")
Williams_September_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/September 2020 Patrick Williams Rapsodo Data-1.csv")
Williams_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/October 2020 Patrick Williams Rapsodo Data-1.csv")
Williams_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/January 2021 Patrick Williams Rapsodo Data-1.csv")
Williams_February_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/February 2021 Patrick Williams Rapsodo Data-1.csv")
Williams_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/P.Williams/Raw Data/March 2021 Patrick Williams Rapsodo Data-1.csv")

# Combining all of Bierman Rapsodo Bullpens 2020-2021
Williams_Rapsodo_All <- rbind (Williams_August_Rapsodo_2020,Williams_September_Rapsodo_2020,Williams_October_Rapsodo_2020,Williams_January_Rapsodo_2021,Williams_February_Rapsodo_2021,Williams_March_Rapsodo_2021)

# Connecting R to SQL Bison Database

BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

# Return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# Displays our tables in the database
fetch(all_tables)

# Write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Williams_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Checking column names using pipe operator???
Williams_Rapsodo_All <- Williams_Rapsodo_All %>% select(-c(ï..No))

# Write / make a .csv

write.csv(Williams_Rapsodo_All, "Williams 2020-2021 Rapsodo.csv")

# Graphs ggplot2 / dplyr filtering/ sorting

Williams_February_Rapsodo_2021 %>% ggplot(aes(x = HB..spin. , y= VB..spin., color= Pitch.Type))+geom_point() + ggtitle (" Williams Pitch Movement February 2021 Rapsodo")

colnames(Williams_February_Rapsodo_2021)

## Bar charts


Williams_February_Rapsodo_2021 %>% ggplot(aes(x = HB..spin. , y= VB..spin., color= Pitch.Type))+geom_point() + ggtitle (" Williams Pitch Movement February 2021 Rapsodo")

colnames(Williams_February_Rapsodo_2021)

# Using Group By, Summarise, and Arrange

Williams_Rapsodo_All %>% group_by(Pitch.Type) %>% summarise(pitch_count=n(), mean_velocity=mean(Velocity),mean_total_spin=mean(Total.Spin),mean_spinrate=mean(Spin.Efficiency..release.)) %>% 
arrange(desc(pitch_count))  

# Using Group By, Summarise, and Arrange (continued)

Williams_Pitch_Summary <- Williams_Rapsodo_All %>% group_by(Pitch.Type) %>% summarise(pitch_count=n(), mean_velocity=mean(Velocity),mean_total_spin=mean(Total.Spin),mean_spin_efficiency=mean(Spin.Efficiency..release.)) %>% 
arrange(desc(pitch_count))

# Making lines on graph, lines on x and y intercept and title in center of chart

Williams_Rapsodo_All %>% ggplot(aes(x = HB..spin. , y= VB..spin., color= Pitch.Type))+geom_point(alpha=0.5)+ labs(title="Williams Rapsodo All 2021", x="Horizontal Break", y="Vertical Break")+theme_bw()+
xlim(-20, 20) + geom_vline(xintercept = c(0,0), linetype="dashed") + geom_hline(yintercept = c(0,0), linetype="dashed") + theme(plot.title = element_text(hjust = 0.5)) + Legend_Title="Pitch Type"

Legend_Title <- "pitch type"
  

url="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc-k9gxES91f2QCWsr6yL4XuQJaI41IFMszQ&usqp=CAU"

image()

download.file






 