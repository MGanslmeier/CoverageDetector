setwd("~/Desktop/R_projects/CoverageDetector")
pacman::p_load(dplyr, plyr, haven, readxl, tidyr, foreign, stringr)
rm(list = ls())

# create dataframe with unit-year coverage
TimeCoverageDetector <- function(df, unit_var, time_var, coverage_vars = 'all'){
  
  # initialize objects, rename variables, define objects
  df <- df %>% dplyr::rename('UNIT' = unit_var, 'TIME' = time_var)
  if(coverage_vars == 'all'){
    coverage_vars <- colnames(df) %>% subset(., !. %in% c('UNIT', 'TIME'))
  }
  temp <- list()
  
  # calculate time period per variable
  for(i in 1:length(coverage_vars)){
    
    # define objects
    var <- coverage_vars[i]
    fake <- df %>% select(UNIT) %>% unique(.)
    
    # construct coverage per variable
    temp[[i]] <- df %>% 
      dplyr::rename('VARIABLE' = var) %>%
      select(UNIT, TIME, VARIABLE) %>%
      subset(.,!is.na(VARIABLE)) %>% 
      group_by(UNIT) %>% 
      dplyr::summarise(min_time = min(TIME), max_time = max(TIME)) %>% 
      ungroup(.) %>%
      mutate(COVERAGE = paste(min_time, max_time, sep='-')) %>% 
      select(UNIT, COVERAGE) %>%
      merge(fake, ., by = 'UNIT', all.x = T) %>%
      mutate(COVERAGE = replace_na(COVERAGE, 'all missing')) %>%
      `colnames<-`(c("UNIT", paste("TIMECOVERAGE_", var, sep = '')))
    
  }
  
  #merge together
  res <- temp[[1]]
  if(length(coverage_vars)>1){
    for(i in 2:length(temp)){
      res <- merge(res, temp[[i]], by = 'UNIT', all = T)
    }
  }
  
  # return results
  return(res)
}
