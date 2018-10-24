pct.corr.bysub.bycond <- function(df){
  # Create summary data frame across participants and conditions
  df %>% 
    group_by(SubID, PatternType, Speed, Coh) %>% 
    summarize(N.corr = sum(Acc), 
              N.tot = n(), 
              Pct.Corr = N.corr/N.tot,
              RT.mean=mean(RT),
              RT.sd=sd(RT)) -> d.summ
  d.summ
}