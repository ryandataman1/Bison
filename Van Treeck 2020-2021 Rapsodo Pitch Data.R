# read in all packages
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

install.packages("")

# read in all Rapsodo csvs from 2020-2021 season

# Logan Van Treeck 2020-2021 Season Rapsodo Data

Van_Treeck_August_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/August 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_September_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/September 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_October_Rapsodo_2020 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/October 2020 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_January_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/January 2021 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_February_Rapsodo_2021 <- read.csv ("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/February 2021 Logan Van Treeck Rapsodo Data-1.csv")
Van_Treeck_March_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/March 2021 Logan Van Treeck  Rapsodo Data-1.csv")
Van_Treeck_May_Rapsodo_2021 <- read.csv("Lipscomb University Baseball 2020-2021/Player Development/Projects/Van Treeck/Raw Data/May 2021 Logan Van Treeck Rapsodo Data-1.csv")

# combining all of Van Treeck Rapsodo Bullpens 2020-2021
Van_Treeck_Rapsodo_All <- rbind (Van_Treeck_August_Rapsodo_2020,Van_Treeck_September_Rapsodo_2020,Van_Treeck_October_Rapsodo_2020,Van_Treeck_January_Rapsodo_2021,Van_Treeck_February_Rapsodo_2021, Van_Treeck_March_Rapsodo_2021, Van_Treeck_May_Rapsodo_2021)

# Connecting R to SQL Bison Database
BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# displays our tables in the database
fetch(all_tables)

# write to database

dbWriteTable(BISON_Lipscomb, name='Rapsodo', Van_Treeck_Rapsodo_All, append=TRUE, overwrite=FALSE)

# Selecting the columns that you do not want; this will add in all the ones you want
Van_Treeck_Rapsodo_All <- Van_Treeck_Rapsodo_All %>% select(-c(ï..No))

# Selected pitch type and velocity from Van Treeck 2020-2021 season

Van_Treeck_Rapsodo_2020_2021 <- Van_Treeck_Rapsodo_All %>% select (Pitch.Type, Velocity) 

write.csv(Van_Treeck_Rapsodo_2020_2021, "Van_Treeck Rapsodo 2020-2021.csv")

# Write / make a .csv

write.csv(Van_Treeck_Rapsodo_All, "Van Treeck 2020-2021 Rapsodo.csv")



                                                                                         
