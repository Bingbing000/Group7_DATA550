here::i_am("code/00_custom_code.R")
absolute_path_to_data <- here::here("raw_data/covid_sub.csv")
data <- read.csv(absolute_path_to_data, header = TRUE)

#make categorical age variable (below or above 55)
data$age_cat <- ifelse(is.na(data$AGE),NA,
                       ifelse(data$AGE>=55,1,0))


#filter based on config
WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config=WHICH_CONFIG
)

#filter based on age category
data <- data[data$age_cat == config_list$age_cat, ]

#save data
saveRDS(
  data, file=here::here("output/data_custom.rds")
)

