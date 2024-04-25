library(tidyverse)
statsByMetroArea <- acsnc %>%
  group_by(met2023) %>%
  summarize(
    mean_incwage = mean(incwage, na.rm = TRUE),
    sd_incwage = sd(incwage, na.rm = TRUE),
    mean_educ = mean(educ, na.rm = TRUE),
    educ_wage_cor = cor(incwage, educ)
  )