library(tidyverse)

options(scipen = 999)

acs <- mutate(acs, age2 = age*age)

homework9_part3 = lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = acs, weights = perwt)

financial_managers <- subset(acs, occd == 120)

homework9_part4.2 = lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = financial_managers, weights = perwt)

sales_agents <- subset(acs, occd == 4820)

homework9_part4.4 = lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = sales_agents, weights = perwt)

postsec_teachers <- subset(acs, occd == 2205)

homework9_part4.7 = lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = postsec_teachers, weights = perwt)

civil_engineers <- subset(acs, occd == 1360)

homework9_part4.9 = lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = civil_engineers, weights = perwt)

summary(homework9_part3)

summary(homework9_part4.2)

summary(homework9_part4.4)

summary(homework9_part4.7)

summary(homework9_part4.9)
