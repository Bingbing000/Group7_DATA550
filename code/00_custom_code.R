here::i_am("code/00_custom_code.R")
absolute_path_to_data <- here::here("data_raw/covid_sub.csv")
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
if (config_list$whole_dataset==FALSE){
  data <- data[data$age_cat == 1, ]
}

#save data
saveRDS(
  data, file=here::here("data_custom/data_custom.rds")
)