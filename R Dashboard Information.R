# read in all packages

library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)
library(tidyverse)
library(flexdashboard)
library(DT)
library(data.table)
library(shiny)
library(plotly)
library(lubridate)

# Ike Buxton Pitcher All 2021 

Ike_All_2021 <- read.csv("Ike Pitches All 2021.csv")

Ike_All_2021 %>% dplyr::group_by(Date, TaggedPitchType) %>% count()

# Van Treeck Pitches All 2021

Van_Treeck_All_2021 <- read.csv("Van Treek All Pitches 2021.csv")

Van_Treeck_All_2021 %>% dplyr::group_by(Date, TaggedPitchType) %>% count()


# All Lipscomb Pitchers Information 2021

Van_Treeck_All_2021_1 <- read.csv("Lipscomb Pitchers 2021 Data.csv")

x<-Van_Treeck_All_2021_1 %>% dplyr::group_by(Date, TaggedPitchType) %>% summarise(AverageVelocity=mean(RelSpeed), n())
Van_Treeck_All_2021_1$Date <- lubridate::date(Van_Treeck_All_2021_1$Date)

ggplot(x, aes(x=Date, y=AverageVelocity, color=TaggedPitchType)) + geom_point() 
Van_Treeck_All_2021_1$Date
