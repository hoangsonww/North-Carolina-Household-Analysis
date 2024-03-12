# Advanced Data Visualization and Analysis for North Carolina ACS 2022

# Load necessary libraries
library(tidyverse)
library(ggplot2)
library(scales)
library(RColorBrewer)

# Load the dataset
load("acsnc2022.Rdata")

# Ensure the dataset is in the expected format
str(acsnc)

# 1. Income Distribution by Education Level
# Add a more granular education level variable
acsnc <- acsnc %>%
  mutate(education_level = case_when(
    educ <= 12 ~ "No High School Diploma",
    educ <= 15 & educ > 12 ~ "High School/Some College",
    educ == 16 ~ "Bachelor's Degree",
    educ > 16 ~ "Postgraduate"
  ))

# Income distribution by education level
ggplot(acsnc, aes(x = inctot, color = education_level)) +
  geom_density(alpha = 0.5) +
  scale_x_continuous(labels = scales::dollar_format()) +
  labs(title = "Income Distribution by Education Level in North Carolina, 2022",
       x = "Total Income",
       y = "Density",
       color = "Education Level") +
  theme_minimal()

# 2. Mean Income by City for College Educated vs. Non-College Educated
# Calculate mean income by city and college education status
mean_income_by_city <- acsnc %>%
  group_by(met2023, college) %>%
  summarize(mean_income = mean(inctot, na.rm = TRUE)) %>%
  spread(key = college, value = mean_income, fill = NA) %>%
  rename("College Educated" = `1`, "Non-College Educated" = `0`)

# Visualize mean income by city for college educated vs. non-college
ggplot(mean_income_by_city, aes(x = `College Educated`, y = `Non-College Educated`, label = met2023)) +
  geom_point(aes(color = met2023)) +
  geom_text(vjust = 1.5, hjust = 1.5, size = 3) +
  scale_x_continuous(labels = scales::dollar_format()) +
  scale_y_continuous(labels = scales::dollar_format()) +
  labs(title = "Mean Income by City for College Educated vs. Non-College Educated",
       x = "College Educated Mean Income",
       y = "Non-College Educated Mean Income") +
  theme_minimal() +
  theme(legend.position = "none")

# 3. Boxplot of Income by Metropolitan Area with Education Level Highlight
# Filter for top 5 metropolitan areas by number of observations
top_met_areas <- acsnc %>%
  count(met2023, sort = TRUE) %>%
  top_n(5) %>%
  pull(met2023)

# Boxplot of income by metropolitan area highlighting education level
acsnc %>%
  filter(met2023 %in% top_met_areas) %>%
  ggplot(aes(x = met2023, y = inctot, fill = education_level)) +
  geom_boxplot() +
  scale_y_continuous(labels = scales::dollar_format()) +
  labs(title = "Income by Metropolitan Area with Education Level Highlight in North Carolina, 2022",
       x = "Metropolitan Area",
       y = "Total Income",
       fill = "Education Level") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Save plots as images
ggsave("income_distribution_by_education_level.png")
ggsave("mean_income_by_city_college_vs_non_college.png")
ggsave("income_by_metropolitan_area_education_level_highlight.png")
