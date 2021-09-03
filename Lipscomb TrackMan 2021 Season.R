# read in all packages
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

# Read in all TrackMan csvs from 2021 season

# Creighton

Creighton_2_26_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Creighton/20210226-Lipscomb-1_unverified.csv")

# Using dplyr package, created a chart to get pitchers velocities from a game

Creighton_2_26_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Creighton/20210226-Lipscomb-1_unverified.csv")

colnames(Creighton_2_26_2021)

Creighton_2_26_2021 %>% dplyr::group_by(Pitcher,TaggedPitchType) %>% dplyr::count("Average Velocity"= mean(RelSpeed)) %>% arrange(Pitcher)

Creighton_2_26_2021 %>% dplyr::group_by(Pitcher,TaggedPitchType) %>% dplyr::summarise("Average Velocity"= mean(RelSpeed)) %>% arrange(Pitcher)

Test_1 <- Creighton_2_26_2021 %>% dplyr::group_by(Pitcher,TaggedPitchType) %>% dplyr::summarise("Average Velocity"= mean(RelSpeed)) %>% arrange(Pitcher)

Test_2 <- Creighton_2_26_2021 %>% dplyr::group_by(Batter, Inning, TaggedPitchType, RelSpeed) %>% dplyr::summarise("Exit Velocity"= ExitSpeed) %>% arrange(Batter)


write.csv(Test_1, "Test file for Creighton.csv")    

# Searching for column names from Creighton game on 2-26-21

colnames(Creighton_2_26_2021)

# Hitters chart 

Creighton_2_26_2021 %>% dplyr::select(Batter,TaggedPitchType,Inning, ExitSpeed) %>% 
dplyr::summarise("Average Exit Velocity"= mean(ExitSpeed)) %>% arrange(Batter)

Exit_Velo <- Creighton_2_26_2021 %>% dplyr::filter(BatterTeam=="LIP_BIS") %>% group_by(Batter,TaggedPitchType) %>% dplyr::summarise(count=n(), ("Average Exit Velocity"= mean(ExitSpeed,na.rm = T)))

na.omit(Exit_Velo)

Creighton_2_26_2021 %>% dplyr::filter(BatterTeam=="LIP_BIS") %>% group_by(Batter,TaggedPitchType) %>% dplyr::summarise(count=n(), ("Average Exit Velocity"= mean(ExitSpeed,na.rm = T))) %>% drop_na()

Creighton_2_26_2021 %>% dplyr::filter(BatterTeam=="LIP_BIS" & Batter=="Borom, Tiger") %>% select(Batter,TaggedPitchType, Inning, RelSpeed, PlayResult, ExitSpeed) %>% arrange(-ExitSpeed) %>% drop_na()

colnames(Creighton_2_26_2021)

# Created a chart with data using ggplot from Creighton games

Creighton_2_26_2021 %>% ggplot(aes(x = RelSpeed, y = SpinRate, color= AutoPitchType,))+ geom_point() + ggtitle("Creighton 2-26-21 All Pitches") + theme_gray()

# Northern Kentucky

Northern_Kentucky_2_27_2021_DH_1<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Northern Kentucky/20210227-Lipscomb-1_unverified.csv")

# Searching for column names from the Northern Kentucky game on 2-27-21

colnames(Northern_Kentucky_2_27_2021_DH_1)

# Created a chart using ggplot for Northern Kentucky games

Northern_Kentucky_2_27_2021_DH_1 %>% ggplot(aes(x = RelSpeed, y = HorzBreak, color= AutoPitchType,))+ geom_point() + ggtitle("NKU 2-27-21 Horizontal Break All Pitchers") + theme_dark()

Northern_Kentucky_2_27_2021_DH_2<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Northern Kentucky/20210227-Lipscomb-2_unverified.csv")

# Creighton

Creighton_2_28_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Creighton/20210228-Lipscomb-1_unverified.csv")

# Georgia 

Georgia_3_12_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Georgia/3-12-21 LU.csv")

colnames(Georgia_3_12_2021)

Georgia_3_12_2021 %>% ggplot(aes(x = ExitSpeed, y = HitSpinRate, color= TaggedPitchType,))+ geom_point() + ggtitle("Georgia 3-12-21 Exit Velo and Hit Spin Rate All Hitters") + theme_bw()

Georgia_3_13_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Georgia/3-13-21 LU.csv")
Georgia_3_14_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Georgia/3-14-21 LU.csv")

# Auburn

Auburn_3_16_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Auburn/20210316-Lispcomb-1_unverified.csv")

colnames(Auburn_3_16_2021)

Auburn_3_16_2021 %>% ggplot(aes(x = HorzBreak, y = VertBreak, color= TaggedPitchType,))+ geom_point() + ggtitle("Auburn 3-16-21 Horz and Vert Break All Pitchers") + theme_light()

Auburn_3_16_2021 %>% ggplot(aes(x = HitSpinRate , y = HitSpinAxis , color= AutoPitchType,))+ geom_point() + ggtitle("Auburn 3-16-21 HitSpinRate by HitSpinAxis All Hitters") + theme_linedraw()

# Kennesaw State

Kennesaw_State_3_19_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Kennesaw State/20210319-Lipscomb-1_unverified.csv")
Kennesaw_State_3_20_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Kennesaw State/20210320-Lipscomb-1_unverified.csv")
Kennesaw_State_3_21_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Kennesaw State/20210321-Lipscomb-1_unverified.csv")

# Vanderbilt

Vanderbilt_3_23_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Vanderbilt/import_20210323-Vanderbilt-1.csv")

Vanderbilt_3_23_2021 %>% ggplot(aes(x = RelSpeed   , y = VertRelAngle  , color= TaggedPitchType,))+ geom_point() + ggtitle("Vanderbilt 3-23-21 Relspeed by VertRelAngle All Pitchers") + theme_grey()


Vanderbilt_3_23_2021 %>% ggplot(aes(x = RelSpeed   , y =   , color= TaggedPitchType,))+ geom_point() + ggtitle("Vanderbilt 3-23-21 Relspeed by VertRelAngle All Pitchers") + theme_grey()

# Austin Peay

Austin_Peay_3_30_2021<- read.csv ("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Austin Peay/20210330-Lipscomb-1_unverified.csv")

#Austin Peay ggplots

Austin_Peay_3_30_2021%>% ggplot(aes(x = RelSpeed   , y = InducedVertBreak   , color= TaggedPitchType,))+ geom_point() + ggtitle("Austin Peay RelSpeed by InducedVertBreak March All Pitchers") + theme_grey()

Austin_Peay_3_30_2021%>% ggplot(aes(x = RelSpeed , y = ZoneSpeed  , color= TaggedPitchType,))+ geom_point() + ggtitle("RelSpeed and ZoneSpeed by PitchType Austin Peay All Pitchers") + theme_grey()

# Bellarmine

Bellarmine_4_1_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Bellarmine/20210401-Lispcomb-1_unverified.csv")
Bellarmine_4_2_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Bellarmine/20210402-Lispcomb-1_unverified.csv")
Bellarmine_4_3_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Bellarmine/20210403-Lispcomb-1_unverified.csv")

# Liberty 

Liberty_4_9_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Liberty/4-9-21_Lipscomb.csv")
Liberty_4_10_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Liberty/4-10-21_Lipscomb.csv")
Liberty_4_11_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Liberty/4-11-21_Lipscomb.csv")

# Pittsburgh

Pittsburgh_4_13_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Pittsburgh/Lipscomb @ Pitt 4-13-21.csv")

# Appalachian State

Appalachian_State_4_16_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Appalachian State/20210416-Lipscomb-1_unverified.csv")
Appalachian_State_4_17_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Appalachian State/20210417-Lipscomb-2_unverified.csv")
Appalachian_State_4_18_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Appalachian State/20210418-Lipscomb-1_unverified.csv")


# Belmont 

Belmont_4_21_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Belmont/20210421-Lipscomb-1_unverified.csv")

# Tennessee

Tennessee_4_27_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Tennessee/4-27 Lipscomb Raw.csv")

# North Alabama

North_Alabama_4_30_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/North Alabama/20210430-Lipscomb-1_unverified.csv")
North_Alabama_5_1_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/North Alabama/20210501-Lipscomb-1_unverified.csv")
North_Alabama_5_2_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/North Alabama/20210502-Lipscomb-2_unverified.csv")

# Southeast Missouri State University

SEMO_5_13_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Southeast Missouri State University/20210513-Lipscomb-1_unverified.csv")
SEMO_5_14_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Southeast Missouri State University/20210514-Lipscomb-1_unverified.csv")
SEMO_5_15_2021<- read.csv("Lipscomb University Baseball 2020-2021/Player Development/TrackMan 2021/Season/Southeast Missouri State University/20210515-Lipscomb-1_unverified.csv")

# Creighton 
Creighton_all <- rbind (Creighton_2_26_2021, Creighton_2_28_2021)

# Northern Kentucky
Northern_Kentucky_all <- rbind (Northern_Kentucky_2_27_2021_DH_1,Northern_Kentucky_2_27_2021_DH_2)

# Georgia
Georgia_all <- rbind (Georgia_3_12_2021,Georgia_3_13_2021,Georgia_3_14_2021)

colnames(Georgia_all)

# Auburn
Auburn_all <- read.csv()

# Kennesaw State 

Kennsaw_State_all <- rbind (Kennesaw_State_3_19_2021, Kennesaw_State_3_20_2021, Kennesaw_State_3_21_2021)

Kennsaw_State_all %>% ggplot(aes(x = RelSpeed   , y = SpeedDrop  , color= TaggedPitchType,))+ geom_point() + ggtitle("Kennesaw State RelSpeed by SpeedDrop All Pitchers March Series") + theme_dark()

# Vanderbilt
Vanderbilt_all <- read.csv()

# Austin Peay
Austin_Peay_all < read.csv()

# Bellarmine
Bellarmine_all <- rbind()

# Liberty
Liberty_all < rbind()

# Pittsburgh
Pittsburgh_all <- read.csv()

# Appalachian State
Appalachian_State_all <- rbind()

# Belmont
Belmont_all <- rbind()

# Tennessee
Tennessee_all <- read.csv()

# North Alabama
North_Alabama_all <- rbind()

# SEMO
SEMO_all <- rbind()

# All February games
February_all <- rbind()

# All March games
March_all <- rbind()

# All April games
April_all <- rbind()

# All May games
May_all < rbind()

# All games
All_Games_2021 <- rbind()

# concatenate / and combine number of games in series into one file
Name_of_Variable <- rbind()

# Connecting R to SQL Bison Database

BISON_Lipscomb <- dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
all_tables <-  dbSendQuery(BISON_Lipscomb,"show tables from lipscomb")

# displays our tables in the database
fetch(all_tables)

# write to database

dbWriteTable(BISON_Lipscomb, name='trackmanv2', variable_name, append=TRUE, overwrite=FALSE)

Creighton_2_26_2021 %>% dplyr::filter(Pitcher=="Thompson, Noah") %>% 
  ggplot(aes(x=PitchNo,y=RelSpeed, color=TaggedPitchType))+ geom_point()+geom_line()

install.packages("ggploty")
library(ggploty)
