library(tidyverse)

here::i_am("code/02_Bingbing_graph.R")

data <- readRDS(file = here::here("data_custom/data_custom.rds"))

# Convert categorical columns to factors
data <- data %>%
  mutate(across(c(USMER, SEX, PATIENT_TYPE, INTUBED, PNEUMONIA, PREGNANT, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, TOBACCO, ICU), factor))

# Handling missing values: For simplicity, we'll convert NAs in binary columns to "Unknown"
binary_columns <- c("INTUBED", "PNEUMONIA", "PREGNANT", "DIABETES", "COPD", "ASTHMA", "INMSUPR", "HIPERTENSION", "OTHER_DISEASE", "CARDIOVASCULAR", "OBESITY", "RENAL_CHRONIC", "TOBACCO", "ICU")
data[binary_columns] <- lapply(data[binary_columns], function(x) forcats::fct_explicit_na(x, na_level = "Unknown"))

# Assuming 'DATE_DIED' is NA for patients who didn't die, and creating a binary outcome variable for mortality
data$DIED <- ifelse(is.na(data$DATE_DIED), "No", "Yes")

# Add Filter on where AGE is NA
data <- data %>% 
  filter(!is.na(AGE))

# Create a subset of data focusing on patient outcomes and conditions
analysis_data <- data %>%
  select(SEX, AGE, PATIENT_TYPE, DIED, INTUBED, PNEUMONIA, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, TOBACCO, ICU)

# Use quantiles as breaks for age groups
quantile_breaks <- quantile(analysis_data$AGE, probs = seq(0, 1, by = 0.2), na.rm = TRUE)
analysis_data$AGE_GROUP <- cut(analysis_data$AGE, breaks = quantile_breaks, include.lowest = TRUE, labels = FALSE)

# Ensure that AGE_GROUP is a factor and has labels
age_group_labels <- sapply(1:(length(quantile_breaks)-1), function(i) paste0("[", quantile_breaks[i], "-", quantile_breaks[i+1], ")"))
analysis_data$AGE_GROUP <- factor(analysis_data$AGE_GROUP, labels = age_group_labels)

# Calculating mortality rate by age group and any pre-existing condition
mortality_rate <- analysis_data %>%
  mutate(ANY_CONDITION = ifelse(DIABETES == "Yes" | COPD == "Yes" | ASTHMA == "Yes" | INMSUPR == "Yes" | HIPERTENSION == "Yes" | OTHER_DISEASE == "Yes" | CARDIOVASCULAR == "Yes" | OBESITY == "Yes" | RENAL_CHRONIC == "Yes" | TOBACCO == "Yes", "Yes", "No")) %>%
  group_by(AGE_GROUP, ANY_CONDITION, .drop = FALSE) %>%
  summarise(Mortality_Rate = mean(DIED == "Yes", na.rm = TRUE), .groups = 'drop')

# Plotting
bar_graph <- ggplot(mortality_rate, aes(x = AGE_GROUP, y = Mortality_Rate, fill = ANY_CONDITION)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "COVID-19 Mortality Rate by Age Group and Pre-existing Condition",
       x = "Age Group",
       y = "Mortality Rate",
       fill = "Pre-existing Condition")

# Save the plot
saveRDS(
  bar_graph, 
  file = here::here("output/Bingbing_graph.rds")
)
