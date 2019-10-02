# Coverage Detector: a quick way to understand the time coverage for each unit

Working with panel datasets requires researchers to understand the time coverage for each variable for each unit. For instance, if you want to run some regressions with a couple of control variables, you have to understand how the data coverage for each variable look like. At the same time, it might also be reasonable to exclude units completely when their data coverage is too weak across multiple variables. The function enables you to understand the data coverage by unit and time in an intuitive way. 

	source('src/CoverageDetector.R')
	example <- read_dta("data/example.dta")
	coverage_df <- TimeCoverageDetector(df = example, unit_var = 'country', time_var = 'year')

The output might also be a good visualization for your descriptive part in your paper.