# Customization

- Final report\
You have the option to include the code in the final report or not.\
To exclude the code and provide a cleaner view for collaborators, open the file '05_render_report.R' and set `params: production: TRUE` in the YAML title. This will generate a report without displaying the code.\
Conversely, to include the code for thorough inspection of the entire report, open the file '05_render_report.R' and set `params: production: FALSE` in the YAML title. This will generate a report with the code included.

- Analysis on the whole dataset or only 55+ years population:
There is a config.yml that has been set up to run two versions of the analyses: one for all subjects and one for subjects 55+. To run the analysis for all subjects, type `export WHICH_CONFIG="default"` into the terminal. To run the analysis for subjects 55+, type `export WHICH_CONFIG="old_age"` into the terminal.

# How to create the final report

- First, download project files from https://github.com/ruth-ma/Group7_DATA550 onto a local computer and save to desired location

### Final report using git bash terminal

- Set the Group7_DATA550 folder as the project directory in the bash terminal using the cd command
- Type `make` into the terminal to generate the report.html product

### Final report using the RStudio console

- Set the working directory to your local folder using the `setwd()` command
- You can run the files individually starting with '00_custom_code.R', followed by '01_table_YingXu.R', '02_Bingbing_graph.R', '03_Jack_analysis_graph.R', '04_Seana_respiratory.R' and finally '05_render_report.R'.
- Tables and plots will be generated in the 'output' folder, while the final report will be found in the main folder.

# About the dataset

- This is a dataset about information regarding COVID-19 cases in Mexico (20% of the full data set).
- Information about the variables included in the dataset can be found in the `covid_readme.txt` file in the `raw_data/` folder
-You could download the dataset from https://datos.gob.mx/busca/dataset/informacion-referente-a-casos-covid-19-en-mexico.

# Code Description
`code/00_custom_code.R`
- read data from `data_raw/` folder
- add the age group variable
- save data to `data_custom/` folder

`code/01_table_YingXu.R`
- write here

`code/02_Bingbing_graph.R`
- write here

`code/03_Jack_analysis_graph.R`
- write here

`code/04_Seana_respiratory.R`
- clean code to perform logistic regression (exposure: respiratory conditions, outcome: ICU admission, covariates: age, sex, tobacco use, pre-existing conditions)
- create plot of odds ratios for pneumonia, COPD, and asthma from logistic regression
- save plot in `output/` folder

`code/05_render_report.R`
- renders `report.Rmd` R Markdown file

`report.Rmd`
- read data, tables, and figures from respective locations
- display results for production report
