# read in all packages
library(ggplot2)
library(dplyr)
library(DBI)
library(RMySQL)
library(nycflights13)
library(tidyverse)
library(lahman)

# Installed packages called tidyverse and nycflights13

install.packages("tidyverse")
install.packages("nycflights13")
install.packages("lahman")

# Created a data frame that shows all the flights that departed from NYC in 2013

nycflights13::flights

# Variables for the column names

# int stands for integer

# dbl stands for doubles, or real numbers

# chr stands for character vectors, or strings

# dttm stands for date-times (a date + a time)

# lgl stands for logical, vectors that contain only TRUE or FALSE

# fctr stands for factors, which R uses to represent categorical variables with fixed possible values

# date stands for dates

# Five important dpylr functions to use

# Pick observations by their values (filter())

# Reorder the rows (arrange())

# Pick variables by their names (select())

# Create new variables with functions of existing variables (mutate())

# Collapse many values down to a single summary (summarise())

# These can all be used in conjunction with group_by() which changes the scope of each function from operating the entire dataset to operating on it group by group.

# The first argument is the name of the data frame. The second and subsequent arguments are the expressions that filter the data frame. For example, we can select all flights on January 1st with

filter(flights, month == 1, day == 1)

# Assigning a variable to the flight data we want to save

Jan1 <- filter(flights, month == 1, day == 1)

# R either prints out the results, or saves them to a variable. IF you want to do both, you can wrap the assignment in parentheses.

(dec25 <- filter(flights, month == 12, day == 25))

# To use filtering effectively, you have to know how to select the observations that you want using the comparison operators. R provides the standard suite: >, >=, <, <=, != (not equal), and == (equal).

filter(flights, month == 1)

# Floating numbers

sqrt(2) ^ 2 == 2

1/49 * 49 == 1 

# Logical operators

# Multiple arguments to filter() are combined with "and": every expression must be true in order for a row to be included in the output. For other types of combinations, you'll need to use Boolean operators yourself: & is "and", | is "or", and ! is "not".

filter(flights, month == 11 | month == 12)

# A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values in y.

nov_dec <- filter(flights, month %in% c (11,12))

# Sometimes you can simplify complicated subsetting by remembering De Morgan's law: !(x & y) is the same as !x | !y, and !(x | y) is the same as !x & !y. For example, if you wanted to find flights that weren't delayed (on arrival or departure) by more than two hours, you could use either of the following two filters

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights,arr_delay <= 120, dep_delay <= 120)

# Missing values

NA > 5

10 == NA

NA + 10

NA/2

NA == NA

x <- NA

y <- NA

x == y

is.na(x)

df <- tibble(x = c (1, NA, 3))

filter(df, x > 1)

filter (df, is.na(x) | x > 1 )

# Arrange rows with arrange ()

arrange(flights, year, month, day)

arrange(flights, desc(dep_delay))

df <- tibble(x = c(5,2,NA))

arrange (df, x)

arrange (df, desc(x))

# select columns wih select()

select(flights, year, month, day)

select(flights, year: day)

select(flights, -(year:day))

# here are a number of helper functions you can use within select():
  
# starts_with("abc"): matches names that begin with "abc".

# ends_with("xyz"): matches names that end with "xyz".

# contains("ijk"): matches names that contain "ijk".

# matches("(.)\\1"): selects variables that match a regular expression. This one matches any variables that contain repeated characters. You'll learn more about regular expressions in strings.

# num_range("x", 1:3): matches x1, x2 and x3.

rename(flights, tail_num = tailnum)

select(flights, time_hour, air_time, everything())

Vars <- c("year", "month", "day", "dep_delay", "arr_delay")

select(flights, contains("TIME"))

# Add new variables with mutate()

# Besides selecting sets of existing columns, it's often useful to add new columns that are functions of existing columns. That's the job of mutate().

# mutate() always adds new columns at the end of your dataset so we'll start by creating a narrower dataset so we can see the new variables. Remember that when you're in RStudio, the easiest way to see all the columns is View().

flights_sml <- select (flights, year: day, ends_with ("delay"), distance, air_time) 

mutate(flights_sml, gain = dep_delay - arr_delay, speed = distance / air_time * 60 )

mutate(flights_sml, gain = dep_delay - arr_delay, hours = air_time / 60, gain_per_hour = gain / hours)

transmute(flights, gain = dep_delay - arr_delay,hours = air_time / 60, gain_per_hour = gain / hours)

# Arithmetic operators: +, -, *, /, ^. These are all vectorised, using the so called "recycling rules". If one parameter is shorter than the other, it will be automatically extended to be the same length. This is most useful when one of the arguments is a single number: air_time / 60, hours * 60 + minute, etc.

# Arithmetic operators are also useful in conjunction with the aggregate functions you'll learn about later. For example, x / sum(x) calculates the proportion of a total, and y - mean(y) computes the difference from the mean.

# Modular arithmetic: %/% (integer division) and %% (remainder), where x == y * (x %/% y) + (x %% y). Modular arithmetic is a handy tool because it allows you to break integers up into pieces. For example, in the flights dataset, you can compute hour and minute from dep_time with

transmute(flights, dep_time, hour = dep_time %/% 100, minute = dep_time %% 100)

# Logs: log(), log2(), log10(). Logarithms are an incredibly useful transformation for dealing with data that ranges across multiple orders of magnitude. They also convert multiplicative relationships to additive, a feature we'll come back to in modelling.

# All else being equal, I recommend using log2() because it's easy to interpret: a difference of 1 on the log scale corresponds to doubling on the original scale and a difference of -1 corresponds to halving.

# Offsets: lead() and lag() allow you to refer to leading or lagging values. This allows you to compute running differences (e.g. x - lag(x)) or find when values change (x != lag(x)). They are most useful in conjunction with group_by(), which you'll learn about shortly.

(x <- 1:10)

lag(x)

lead(x)

y <- c(1, 2, 2, NA, 3, 4)

min_rank(y)

min_rank(desc(y))

row_number(y)

dense_rank(y)

percent_rank(y)

cume_dist(y)

# Grouped summaries with summarise ()

summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day) 

summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

by_dest <- group_by(flights, dest)

delay <- summarise(by_dest,count = n(), dist = mean(distance, na.rm = TRUE), delay = mean(arr_delay, na.rm = TRUE))

delay <- filter(delay, count > 20, dest != "HNL")

ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)                  

delays <- flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>% 
  filter(count > 20, dest != "HNL")

# Missing values

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

flights %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay, na.rm = TRUE))

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# Counts

delay <- not_cancelled %>% group_by(tailnum) %>% summarise(delay = mean(arr_delay))

ggplot(data = delay, mapping = aes(x = delay)) + geom_freqpoly(binwidth = 10)

delay <- not_cancelled %>% group_by(tailnum) %>% summarise( delay = mean(arr_delay, na.rm = TRUE), n = n())

ggplot(data = delay, mapping = aes(x = n, y = delay)) + geom_point(alpha = 1/10)

delays %>% filter(n > 25) %>% ggplot(mapping = aes(x = n, y = delay)) + geom_point(alpha = 1/10)

# Convert to a tibble so it prints nicely

install.packages("Lahman")

batting <- as_tibble(Lahman::Batting)

batters <- batting %>% 
  group_by(playerID) %>% 
  summarise(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE),
    ab = sum(AB, na.rm = TRUE)
  )

batters %>% 
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
  geom_point() + 
  geom_smooth(se = FALSE)

batters %>% 
  arrange(desc(ba))

# Useful summary functions

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),
    avg_delay2 = mean(arr_delay[arr_delay > 0]) # the average positive delay
  )

# Why is distance to some destinations more variable than to others?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))

# When do the first and last flights leave each day?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first = min(dep_time),
    last = max(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    first_dep = first(dep_time), 
    last_dep = last(dep_time)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r))

# Which destinations have the most carriers?
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier)) %>% 
  arrange(desc(carriers))

not_cancelled %>% 
  count(dest)

not_cancelled %>% 
  count(tailnum, wt = distance)

# How many flights left before 5am? (these usually indicate delayed
# flights from the previous day)
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(hour_prop = mean(arr_delay > 60))

# Grouping by multiple variables

daily <- group_by(flights, year, month, day) 
(per_day   <- summarise(daily, flights = n()))

(per_month <- summarise(per_day, flights = sum(flights)))

(per_year  <- summarise(per_month, flights = sum(flights)))

# Ungrouping

daily %>% 
  ungroup() %>%           
  summarise(flights = n())

# Grouped mutates (and filters)

flights_sml %>% 
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)

popular_dests %>% 
  filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)


