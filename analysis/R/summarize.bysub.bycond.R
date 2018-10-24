summarize.bysub.bycond <- function(df){
  # Create summary data frame across participants and conditions
  
  # Convert age in days to years
  df$AgeYrs <- cut(df$AgeDays/365.25, 
                   breaks = c(0,5,6,7,8,9), 
                   labels = c("<5yo", "5yo", "6yo", "7yo", "8yo"))
  
  df %>% 
    group_by(AgeYrs, Gender, SubID, PatternType, Speed, Coh) %>% 
    summarize(N.corr = sum(Acc), 
              N.tot = n(), 
              Pct.Corr = N.corr/N.tot,
              RT.mean=mean(RT),
              RT.sd=sd(RT)) -> d.summ
  d.summ
}