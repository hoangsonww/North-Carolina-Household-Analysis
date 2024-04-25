## Install R packages
## You only have to do this once for each package
## Use the shortcut Ctrl+Enter to run selected code (or lines)
## The pound key means "Comment" (not executed)
install.packages("tidyverse")
install.packages("openintro")
## You can also install at the same time
## Using c() to concatenate
install.packages(c("tidyverse", "openintro"))

## Load libraries
## You have to do this each time you open RStudio
library(tidyverse)
library(openintro)

## Load smoking data from the openintro package
## Note that it appears in the Environment panel once loaded
## You can click the item in the environment panel to see details
data(smoking)

## Q1. How many observations are there?
## 1691 obs and 12 variables
## We can also use the function dim()
dim(smoking)
dimension <- dim(smoking)
dimension = dim(smoking)    # It is the same to use <- and =

## Q2. Which variables are numerical? Which variables are categorical?
## Note some variables are "factors", stored as numbers with names for each level.
## You can also click on "smoking" in the Environment panel to browse the data.
## In R, missing values are represented as "NA"
glimpse(smoking)
smoking$gender
str(smoking$gender) # What does str() mean? Try Help!

## Q3. What is the average age of the survey respondents?
mean(smoking$age)

## We can do more than average
var(smoking$age)
sd(smoking$age)
median(smoking$age)
str(smoking$age)

## Q4. How many smokers and non-smokers are in this data?
table(smoking$smoke) # smoke is binary, only yes or no
# What if we apply table() to a numerical variable
table(smoking$age)

## Q5. Create a histogram of cigarettes per day on weekends
## Note this variable is missing (NA) for non-smokers
ggplot(data = smoking, aes(x = amt_weekends)) + # Like a canvas
  geom_histogram() # the plot style we used

## You can set a different bin width if desired
ggplot(data = smoking, aes(x = amt_weekends)) +
  geom_histogram(binwidth = 5)

## You can also set a different fill-in color for different gender
ggplot(data = smoking, aes(x = amt_weekends, fill = gender)) +
  geom_histogram()

## You can also try different plots, e.g.: a scatter plot among regions
ggplot(data = smoking, aes(x = amt_weekends, y = amt_weekdays, color = region)) + 
    geom_point()

ggplot(data = smoking, aes(x = age, color = smoke)) + geom_histogram()

## Q6. Among smokers, do men or women smoke more?
## Take data frame "smoking", group by variable "gender",
## create summary statistics to be reported in data frame "stats_by_sex"
## %>% is a "pipe" operator for connecting a sequence of operations (from tidyverse)
## Note that R is very picky about removing ("rm") missing values
smoking %>%
    group_by(gender) %>%
    summarize(mean_weekends = mean(amt_weekends, na.rm = TRUE),
              mean_weekdays = mean(amt_weekdays, na.rm = TRUE))

## A complicated but natural way to do this 
smoking_male = smoking[smoking$gender == "Male",]
smoking_female = smoking[smoking$gender == "Female",]
mean_weekends_male = mean(smoking_male$amt_weekends, na.rm = TRUE)
mean_weekends_female = mean(smoking_female$amt_weekends, na.rm = TRUE)
mean_weekdays_male = mean(smoking_male$amt_weekdays, na.rm = TRUE)
mean_weekdays_female = mean(smoking_female$amt_weekdays, na.rm = TRUE)
print(c("Female", mean_weekends_female, mean_weekdays_female))
print(c("Male", mean_weekends_male, mean_weekdays_male))

## Store the result in "stats_by_sex"
stats_by_sex <- smoking %>%
  group_by(gender) %>%
  summarize(mean_weekends = mean(amt_weekends, na.rm = TRUE),
            mean_weekdays = mean(amt_weekdays, na.rm = TRUE))

## You can view the help file for a function by typing "?" before it
?summarize

## To prepare for doing Assignment 1, open the mobility.Rdata file
## Download the file from Canvas
## In RStudio, go to the Files pane, navigate to your downloads folder, and select the file
## In Posit Cloud, go to the Files pane, select Upload, then find the file on your computer
