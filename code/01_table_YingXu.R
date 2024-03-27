#Here
here::i_am("code/table_YingXu.R")

#Read data
library(tidyverse)
covid_sub <- read_csv(file = here::here("raw_data/covid_sub.csv"))

#Construct table
library(gtsummary)
library(labelled)

var_label(covid_sub) <- list(
  AGE = "Patient Age",
  PATIENT_TYPE = "Patient Type",
  PNEUMONIA = "Pneumonia",
  DIABETES = "Diabetes",
  ASTHMA = "Asthma",
  INMSUPR = "Immunosuppressed",
  HIPERTENSION = "Hypertension",
  CARDIOVASCULAR = "Heart/blood vessels related disease",
  RENAL_CHRONIC = "Chronic renal disease",
  OTHER_DISEASE = "Other disease",
  OBESITY = "Obese",
  TOBACCO = "Tobacco user"
)

table_one <- covid_sub %>%
  select("SEX", "AGE", "PATIENT_TYPE", "PNEUMONIA", "DIABETES", "COPD", 
         "ASTHMA", "INMSUPR", "HIPERTENSION", "CARDIOVASCULAR", 
         "RENAL_CHRONIC", "OTHER_DISEASE", "OBESITY", "TOBACCO") %>%
  filter(AGE != "Unknown", 
         PNEUMONIA != "Unknown", 
         DIABETES != "Unknown", 
         COPD != "Unknown", 
         ASTHMA != "Unknown",
         INMSUPR != "Unknown",
         HIPERTENSION != "Unknown",
         CARDIOVASCULAR != "Unknown",
         RENAL_CHRONIC != "Unknown",
         OTHER_DISEASE != "Unknown",
         OBESITY != "Unknown",
         TOBACCO != "Unknown") %>%
  tbl_summary(by = SEX) %>%
  add_overall() %>%
  add_p()

#Save output
saveRDS(
  table_one,
  file = here::here("output/table_YingXu.rds")
)
