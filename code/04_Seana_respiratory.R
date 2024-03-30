here::i_am("code/04_Seana_respiratory.R")

data <- readRDS(
  file=here::here("data_custom/data_custom.rds")
)

pacman::p_load(dplyr,sjPlot,sjlabelled,sjmisc,ggplot2)

data <- data %>% 
  filter(!is.na(ICU)) %>%
  mutate(ICU=case_when(ICU=="No"~0,
                       TRUE~1)) %>%
  mutate(PRE=case_when(DIABETES=="Yes" | INMSUPR=="Yes" | HIPERTENSION=="Yes" |
                         OTHER_DISEASE=="Yes" | CARDIOVASCULAR=="Yes" |
                         OBESITY=="Yes" | RENAL_CHRONIC=="Yes"~1,
                       TRUE~0)) %>%
  mutate(SEX=case_when(SEX=="male"~0,
                       SEX=="female"~1,
                       TRUE~NA)) %>%
  mutate(TOBACCO=case_when(TOBACCO=="No"~0,
                           TOBACCO=="Yes"~1,
                           TRUE~NA)) %>%
  mutate(resp_cond=case_when(PNEUMONIA=="Yes"~1,
                             COPD=="Yes"~2,
                             ASTHMA=="Yes"~3,
                             TRUE~0)) %>%
  select(SEX,AGE,resp_cond,TOBACCO,ICU,PRE)

set_label(data$ICU) <- "ICU Admission"
set_label(data$SEX) <- "Female"
set_label(data$AGE) <- "Age"
set_label(data$TOBACCO) <- "Tobacco User"
set_label(data$PRE) <- "Pre-Existing Conditions"

data$resp_cond <- factor(data$resp_cond, labels=c("None","Pneumonia","COPD","Asthma"))

log_reg_resp <- glm(ICU ~ resp_cond + SEX + AGE + TOBACCO + PRE,
                family = binomial (link = 'logit'),
                data = data)

resp_or <- plot_model(log_reg_resp, rm.terms = c("SEX", "AGE", "TOBACCO", "PRE")) +
  theme_bw() +
  labs(title="Odds of ICU Admission by Respiratory Condition",
       subtitle = "After Controlling for Sex, Age, Tobacco Use, and Pre-Existing Conditions")

ggsave(
  here::here("output/resp_or.png"),
  plot=resp_or,
  device="png",
  width = 6, 
  height = 4
)