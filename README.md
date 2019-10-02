# Coverage Detector: a quick way to understand the time coverage for each unit

Working with panel datasets requires researchers to understand the time coverage for each variable for each unit. Usually, scholars only want to include variables in their regressions that show fairly good time and unit coverage, so that the sample does not loose its representative power. Thus, one might want to check which variables (and which units) have enough data points before they run any inference. The function enables you to understand this in an intuitive way. 

	source('src/CoverageDetector.R')
	example <- read_dta("data/example.dta")
	coverage_df <- TimeCoverageDetector(df = example, unit_var = 'country', time_var = 'year')

The output might also be a good visualization for your descriptive part in your paper.