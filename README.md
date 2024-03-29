# How to run the program
Please set the working directory to your local folder containing the program "~/Final_DATA550-master", use the following command: `setwd("~/Group7_DATA550-master")`.

All code files are located in the 'code' folder. Using __'make'__ simplifies the process of running all codes and generating the report file. However, if you're unfamiliar with 'make', you can __run the files individually starting with '00_read_data.Rmd', followed by '01_make_table1.R', '02_make_plots.R', and finally '03_render_report.R'__.

Tables and plots will be generated in the 'output' folder, while the final report will be found in the main folder.

# About the dataset
Feel free to skip this section if the scientific background doesn't interest you.

This is a dataset about information regarding covid-19 cases in Mexico (20% of the full data set).\
You could download the dataset from https://datos.gob.mx/busca/dataset/informacion-referente-a-casos-covid-19-en-mexico.

# Code Description

`code/01_table_YingXu.R`
- write here

`code/02_Bingbing_graph.R`
- write here

`code/03_Jack_analysis_graph.R`
- write here

`code/04_respiratory.R`
- read data from `raw_data/` folder
- clean code to perform logistic regression (exposure: respiratory conditions, outcome: ICU admission, covariates: age, sex, tobacco use, pre-existing conditions)
- create plot of odds ratios for pneuomia, COPD, and asthma from logistic regression
- save plot in `output/` folder

`code/05_render_report.R`
- write here

`code/report.Rmd`
- read data, tables, and figures from respective locations
- display results for production report

# Customization

- final report\
You have the option to include the code in the final report or not.\
To exclude the code and provide a cleaner view for collaborators, open the file '05_render_report.R' and set `params: production: TRUE` in the YAML title. This will generate a report without displaying the code.\
Conversely, to include the code for thorough inspection of the entire report, open the file '05_render_report.R' and set `params: production: FALSE` in the YAML title. This will generate a report with the code included.
