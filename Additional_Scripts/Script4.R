library(tidyverse)

homework7_part6.1 <- lm(educ ~ momeduc, data = subset(psid, female==1), weights = meanweight)

homework7_part6.2 <- lm(educ ~ dadeduc, data = subset(psid, female==1), weights = meanweight)

homework7_part6.3a <- lm(educ ~ momeduc, data = subset(psid, female==0), weights = meanweight)

homework7_part6.3b <- lm(educ ~ dadeduc, data = subset(psid, female==0), weights = meanweight)

homework7_part7.1 <- lm(salary ~ roe, data = ceo)

ceo <- mutate(ceo, roedec = roe/100)

homework7_part8.1 <- lm(salary ~ roedec, data = ceo)

summary(homework7_part6.1)

summary(homework7_part6.2)

summary(homework7_part6.3a)

summary(homework7_part6.3b)

summary(homework7_part7.1)

summary(homework7_part8.1)
