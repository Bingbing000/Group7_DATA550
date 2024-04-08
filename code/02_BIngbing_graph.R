library(tidyverse)

here::i_am("code/02_Bingbing_graph.R")

data <- readRDS(
  data, file=here::here("data_custom/data_custom.rds")
)

# Convert categorical columns to factors
data <- data %>%
  mutate_at(vars(USMER, SEX, PATIENT_TYPE, INTUBED, PNEUMONIA, PREGNANT, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, TOBACCO, ICU), factor)

# Handling missing values: For simplicity, we'll convert NAs in binary columns to "Unknown"
binary_columns <- c("INTUBED", "PNEUMONIA", "PREGNANT", "DIABETES", "COPD", "ASTHMA", "INMSUPR", "HIPERTENSION", "OTHER_DISEASE", "CARDIOVASCULAR", "OBESITY", "RENAL_CHRONIC", "TOBACCO", "ICU")
data[binary_columns] <- lapply(data[binary_columns], function(x) addNA(x, ifany = TRUE))

# Assuming 'DATE_DIED' is NA for patients who didn't die, creating a binary outcome variable for mortality
data$DIED <- ifelse(is.na(data$DATE_DIED), "No", "Yes")

# Filter out rows where AGE is NA
data <- data %>% 
  filter(!is.na(AGE))

# Create a subset of data focusing on patient outcomes and conditions
analysis_data <- data %>%
  select(SEX, AGE, PATIENT_TYPE, DIED, INTUBED, PNEUMONIA, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, TOBACCO, ICU)

# Creating a graph to analyze treatment outcomes and healthcare utilization
# Grouping age into categories
analysis_data$AGE_GROUP <- cut(analysis_data$AGE, breaks = c(0, 18, 40, 60, 80, Inf), labels = c("0-18", "19-40", "41-60", "61-80", "81+"), right = FALSE)

# Calculating mortality rate by age group and any pre-existing condition
mortality_rate <- analysis_data %>%
  mutate(ANY_CONDITION = ifelse(DIABETES == "Yes" | COPD == "Yes" | ASTHMA == "Yes" | INMSUPR == "Yes" | HIPERTENSION == "Yes" | OTHER_DISEASE == "Yes" | CARDIOVASCULAR == "Yes" | OBESITY == "Yes" | RENAL_CHRONIC == "Yes" | TOBACCO == "Yes", "Yes", "No")) %>%
  group_by(AGE_GROUP, ANY_CONDITION) %>%
  summarise(Mortality_Rate = mean(DIED == "Yes"), .groups = 'drop')

# Plotting
bar_graph <- ggplot(mortality_rate, aes(x = AGE_GROUP, y = Mortality_Rate, fill = ANY_CONDITION)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "COVID-19 Mortality Rate by Age Group and Pre-existing Condition",
       x = "Age Group",
       y = "Mortality Rate",
       fill = "Pre-existing Condition")

saveRDS(
  bar_graph, 
  file = here::here("output/Bingbing_graph.rds")
)