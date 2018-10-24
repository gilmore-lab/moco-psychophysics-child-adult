df.moco.child <- function(fn){
  # Creates a data frame for the moco-child psychophysics study from an individual file
  df <- read.csv(file = fn, header=TRUE)
  date.sub.cond <- extract.date.sub(fn)
  df$Speed <- as.numeric(date.sub.cond[4])
  df$Block <- as.numeric(date.sub.cond[3])
  df$SubID <- factor(as.character(date.sub.cond[2]))
  return(df)
}