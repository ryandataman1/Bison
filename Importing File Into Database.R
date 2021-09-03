library(RMySQL)
name_of_your_file <- read_csv("")

test = dbConnect(MySQL(),user = 'Ryan',password = 'BisonData1',dbname = 'Lipscomb',host = "bison.cwaea81emev3.us-east-2.rds.amazonaws.com")

## return all tables in database
dbWriteTable(test,name = "trackmanv2",append = T,name_of_your_file)

# displays our tables in the database