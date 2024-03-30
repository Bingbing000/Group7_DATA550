# create rule to render report
report.html: code/05_render_report.R report.Rmd \
  output/BIngbing_graph.rds output/table_YingXu.rds \
  output/resp_or.png output/Jack_graph.rds
	Rscript code/05_render_report.R

# data customization
output/data_custom.rds: code/00_custom_code.R raw_data/covid_sub.csv
	Rscript code/00_custom_code.R

# table 1
output/table_YingXu.rds: code/01_table_YingXu.R output/data_custom.rds
	Rscript code/01_table_YingXu.R

# mortality plot
output/Bingbing_graph.rds: code/02_BIngbing_graph.R output/data_custom.rds
	Rscript code/02_BIngbing_graph.R

# death plot
output/Jack_graph.rds: code/03_Jack_analysis_graph.R output/data_custom.rds
	Rscript code/03_Jack_analysis_graph.R

#icu plot
output/resp_or.png: code/04_respiratory.R output/data_custom.rds
	Rscript code/04_respiratory.R
	
# clean data
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f *.html