library(tidyverse)
statsbystate <- mobility %>%
  group_by(statefips) %>%
  summarize(mobility_mean = mean(am, na.rm = TRUE),
            mobility_median = median(am, na.rm = TRUE),
            mobility_sd = sd(am, na.rm = TRUE))