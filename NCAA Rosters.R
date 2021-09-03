# Read in all package

library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

# Installing baseballr

install.packages("devtools")
devtools::install_github("BillPetti/baseballr")

# Reading from baseballr

library(baseballr)
baseballr::ncaa_season_id_lu

# Reading in NCAA data from baseballr package

baseballr::master_ncaa_team_lu

# Reading 2021 and ASUN NCAA information to get player ID's

baseballr::master_ncaa_team_lu %>% filter(year==2021 & conference=="ASUN")

# Putting all ASUN conference ID's into one chart

ASUN <- baseballr::master_ncaa_team_lu %>% filter(year==2021 & conference=="ASUN")

write.csv(ASUN,"ASUN Conference ID's 2021.csv")

# Getting Lipscomb baseball 2021 roster from baseballr

baseballr::get_ncaa_baseball_roster(teamid='28600', team_year=2021)

# Getting all of Lipscomb batting data from 2021

baseballr::ncaa_scrape(28600, year = 2021, type = 'batting')

# Getting all of Lipscomb pitching data from 2021

baseballr::ncaa_scrape(28600, year = 2021, type = 'pitching')

# 

ncaa_scrape(28600, year = 2021, type = 'pitching')

# Writing Lipscomb 2021 ID's to a .csv

Lipscomb_2021_IDs <- baseballr::get_ncaa_baseball_roster(teamid='28600', team_year=2021)

write.csv(Lipscomb_2021_IDs, "Lipscomb NCAA Roster ID's 2021.csv")


ncaa_scrape(28600, year = 2021, type = 'pitching')

