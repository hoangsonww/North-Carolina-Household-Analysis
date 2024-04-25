library(tidyverse)

options(scipen = 999)

homework8_part4.1 = lm(earn ~ female, data = acs, weights = perwt)

homework8_part4.4 = lm(log(earn) ~ female, data = acs, weights = perwt)

summary(homework8_part4.1)

summary(homework8_part4.4)
