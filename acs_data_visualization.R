# Load necessary libraries
library(tidyverse)
library(ggpubr)

# Set options
options(scipen = 999)

# Create a new variable for age squared
acs <- mutate(acs, age2 = age * age)

# Define the regression model
model <- lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = acs, weights = perwt)

# Subset data for specific occupations
financial_managers <- subset(acs, occd == 120)
sales_agents <- subset(acs, occd == 4820)
postsec_teachers <- subset(acs, occd == 2205)
civil_engineers <- subset(acs, occd == 1360)

# Define regression models for each occupation
model_fm <- lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = financial_managers, weights = perwt)
model_sa <- lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = sales_agents, weights = perwt)
model_pt <- lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = postsec_teachers, weights = perwt)
model_ce <- lm(log(earn) ~ female + log(hours) + age + age2 + foreignborn + raceeth + edcat, data = civil_engineers, weights = perwt)

# Create plots for each regression
plot_fm <- ggplot(financial_managers, aes(x = age, y = log(earn), color = raceeth)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Financial Managers")

plot_sa <- ggplot(sales_agents, aes(x = age, y = log(earn), color = raceeth)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Sales Agents")

plot_pt <- ggplot(postsec_teachers, aes(x = age, y = log(earn), color = raceeth)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Post-secondary Teachers")

plot_ce <- ggplot(civil_engineers, aes(x = age, y = log(earn), color = raceeth)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Civil Engineers")

# Combine plots into one figure
combined_plot <- ggarrange(plot_fm, plot_sa, plot_pt, plot_ce, ncol = 2, nrow = 2)

# Display the combined plot
print(combined_plot)
