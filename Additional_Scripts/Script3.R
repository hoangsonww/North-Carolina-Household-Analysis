library(tidyverse)

acsnc <- mutate(acsnc, college = if_else(educ>=16, 1, 0))

statsbycity <- acsnc %>%
  group_by(met2023) %>%
  summarize(incmean = mean(inctot, na.rm = TRUE),
            incsd = sd(inctot, na.rm = TRUE),
            collshare = mean(college, na.rm = TRUE),
            n = n())

