# read in all packages

library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)

# install packages named rsconnect for shiny app

install.packages('rsconnect')

# authorizing account
rsconnect::setAccountInfo(name='rmoretti1',
                          token='78E06AD68FBF6CF7CE72FEC076EB3672',
                          secret='B/e7btLS8ViWpo71jWmNIayvRp8VsQEjVKYmAZGt')
# deploy app

library(rsconnect)
rsconnect::deployApp('path/to/your/app')