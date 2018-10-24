standardize.date <- function(yymmdd){
  # Make YYMMDD date into YYYY-MM-DD
  yyyy <- paste("20", substr(yymmdd, 1, 2), sep="")
  mm <- substr(yymmdd, 3, 4)
  dd <- substr(yymmdd, 5, 6)
  return(paste(yyyy, mm, dd, sep="-"))
}