# read in all packages

library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)
library(tidyverse)

# Wrote in .csv file from App State game to create umpire reports

Appalachian_State_4_18_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Appalachian State/20210418-Lipscomb-1_unverified.csv")

# Search for column names for the App State game on 4-18-21

colnames(Appalachian_State_4_18_2021)

# Wrote code to display umpire reports

Appalachian_State_4_18_2021 %>% filter(PitchCall == "StrikeCalled" | PitchCall == 'BallCalled') %>% ggplot(aes(x = PlateLocSide,y = PlateLocHeight, color = PitchCall)) + geom_point() + 
theme_bw() + ggtitle("Todd Henderson Overall vs. App State 4/18/21") + geom_segment(aes(x = -.85, y = 3.5, xend = .85, yend = 3.5,color=))+ geom_segment(aes(x =-.85, y = 1.5, xend = .85, yend = 1.5))+ geom_segment(aes(x = .85, y = 1.5 , xend = .85, yend = 3.5))+
geom_segment(aes(x = -.85, y = 1.5, xend = -.85 , yend = 3.5))

# Wrote in code to display umpire reports with overall strike zone

Appalachian_State_4_18_2021 %>% filter(PitchCall == "StrikeCalled" | PitchCall == 'BallCalled') %>% ggplot(aes(x = PlateLocSide,y = PlateLocHeight, color = PitchCall)) + geom_point() + 
theme_bw() + ggtitle("Todd Henderson Overall vs. App State 4/18/21") + geom_segment(aes(x = -.85, y = 3.5, xend = .85, yend = 3.5,color='black'))+ geom_segment(aes(x =-.85, y = 1.5, xend = .85, yend = 1.5))+ geom_segment(aes(x = .85, y = 1.5 , xend = .85, yend = 3.5))+
geom_segment(aes(x = -.85, y = 1.5, xend = -.85 , yend = 3.5)) + facet_wrap(~BatterSide + TaggedPitchType)

# Wrote in code to display umpire reports with strike zone by batter
Appalachian_State_4_18_2021 %>% filter(PitchCall == "StrikeCalled" | PitchCall == 'BallCalled') %>% ggplot(aes(x = PlateLocSide,y = PlateLocHeight, color = PitchCall)) + geom_point() + 
theme_bw() + ggtitle("Todd Henderson Overall vs. App State 4/18/21") + geom_segment(aes(x = -.85, y = 3.5, xend = .85, yend = 3.5,color="black"))+ geom_segment(aes(x =-.85, y = 1.5, xend = .85, yend = 1.5))+ geom_segment(aes(x = .85, y = 1.5 , xend = .85, yend = 3.5))+
geom_segment(aes(x = -.85, y = 1.5, xend = -.85 , yend = 3.5)) + facet_wrap(~BatterSide + TaggedPitchType)

# Umpire reports by pitch type ggplot

install.packages("ggploty")

library(ggploty)

# Movement charts for pitchers

ggplot(Creighton_2_26_2021 %>% dplyr::filter(Pitcher=="Thompson, Noah"),aes(x = (HorzBreak * -1),y = InducedVertBreak,color = TaggedPitchType)) +
geom_point() + theme_bw() + ggtitle('Pitcher X Movement Plot 2019 (Catchers Perspective)') + xlab("Horizontal Movement (inches)") + 
ylab("Vertical Movement (inches)") + geom_vline(xintercept = 0,linetype = 'dashed') + geom_hline(yintercept = 0,linetype = 'dashed') + annotate("text",x = 0,y = 20,label = "Carry") + 
annotate("text",x = 0,y = -20,label = "Sink") + annotate("text",x = -18.5,y = 1,label = "Gloveside") + annotate("text",x = 18.5,y = 1,label = "Armside") + annotate("text",x = 8,y = 14,label = 93) + 
annotate("text",x = 12,y = 5,label = 87) + annotate("text",x = -5,y = 1,label = 84) + annotate("label", x = 0, y = 20, label = "Carry") + annotate("label",x = 0,y = -20,label = "Sink") + 
annotate("label",x = 18.5,y=1.5,label = "Armside") + annotate("label",x = -18,y = 1.5,label = "Gloveside") +  geom_circle(aes(x0 = 8, y0 = 14, r = 1), inherit.aes = FALSE,color = 'Green') + 
geom_circle(aes(x0 = 12, y0 = 5, r = 1), inherit.aes = FALSE,color = 'Red') + geom_circle(aes(x0 = -5, y0 = 1, r = 1), inherit.aes = FALSE,color = 'Blue')

install.packages("ggforce")
library(ggforce)

xlim(-20,20) + ylim(-20,20)

