# calculate.p.corr( df )
# 
# Calculates proportion correct responses
#

# History 
# 2014-11-17 rogilmore modified with help from wadamiak
calculate.p.corr = function( df ) {
  # Select correct trials
  corr.trials = df$Acc == TRUE
  
  # Tabulate # of correct results
  acc.by.coh.by.patt.by.spd = table( df$Coh[corr.trials], df$PatternType[corr.trials], df$DegPSec[corr.trials], df$Run[corr.trials])
  
  # Calculate total n per condition
  n.per.cond = table( df$Coh, df$PatternType, df$DegPSec, df$Run )
  
  # Calculate p correct
  p.corr.by.coh.by.patt = acc.by.coh.by.patt.by.spd / n.per.cond
  
  p.corr.df = data.frame( p.corr.by.coh.by.patt )
  names( p.corr.df ) = c("Coh", "PatternType", "DegPSec", "Run", "Pcorr")
  
  return( p.corr.df )
}
