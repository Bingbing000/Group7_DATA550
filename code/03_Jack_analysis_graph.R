# Here
here::i_am("code/03_Jack_analysis_graph.R")

# Load packages
library(tidyverse)
library(broom)

# Read in Data
data <- read_csv(file = here::here("raw_data/covid_sub.csv"))

# Conver DATE_DIED to binary Death Outcome
data$Death <- ifelse(is.na(data$DATE_DIED), 0, 1)

# Convert categorical variables to factors
data <- data %>%
  mutate_at(vars(USMER, SEX, PATIENT_TYPE, INTUBED, PNEUMONIA, PREGNANT, DIABETES, COPD, ASTHMA, INMSUPR, HIPERTENSION, OTHER_DISEASE, CARDIOVASCULAR, OBESITY, RENAL_CHRONIC, TOBACCO, ICU), factor)

model <- glm(Death ~ SEX + AGE + DIABETES + COPD + ASTHMA + INMSUPR + HIPERTENSION + CARDIOVASCULAR + OBESITY + RENAL_CHRONIC + TOBACCO,
             data = data, 
             family = "binomial")

summary(model)

# Get odds ratios and their confidence intervals
odds_ratios <- tidy(model, exponentiate = TRUE, conf.int = TRUE) %>% 
  filter(term != "(Intercept)",
         term != "AGE")

odds_ratios$term <- gsub("yes", "", odds_ratios$term, ignore.case = TRUE)
odds_ratios$term <- gsub("male", "", odds_ratios$term, ignore.case = TRUE)

# Plotting
ggplot(odds_ratios, aes(x = term, y = estimate)) +
  geom_point() +
  geom_errorbar(aes(ymin = conf.low, ymax = conf.high), width = 0.2) +
  coord_flip() + 
  geom_hline(yintercept = 1, linetype = "dashed", color = "red") + 
  xlab("Predictor") +
  ylab("Odds Ratio") +
  ggtitle("Odds Ratios of Risk Factors for Dying of COVID") +
  theme_minimal()
