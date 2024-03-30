here::i_am(
  "code/05_render_report.R"
)

WHICH_CONFIG <- Sys.getenv("WHICH_CONFIG")
config_list <- config::get(
  config=WHICH_CONFIG
)

report_filename <- paste0(
  "report_config_",
  WHICH_CONFIG,
  ".html"
)

# render report
rmarkdown::render(
  here::here("report.Rmd"),
  output_file = report_filename
)