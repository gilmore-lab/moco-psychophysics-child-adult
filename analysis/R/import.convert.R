# imports moco-3-pattern-adult data file
# adds DegPSec, Run, Coh variables
# writes new CSV file with -ext.csv extention
# returns extended/augmented data frame with new variables
# presumes file directories are in YYYY-MM-DD-NNN format
import.convert = function( fn, session ) {
  f.path = normalizePath( paste( "../data", session, sep="/") )
  fn.full = paste(f.path, fn, sep="/")
  file.df = read.csv( fn.full )
  cat("Reading ", fn, "\n" )
  
  cat("Adding new variables.\n")
  SessionDate = as.Date( substring(fn, 1, 10) ) # YYYY-MM-DD
  ParticipantID = as.numeric( substring( fn, 12, 14 ) )
  DegPSec = as.numeric( substring( fn, nchar(fn)-9, nchar(fn)-9 ) )
  Run = as.numeric( substring( fn, nchar(fn)-4, nchar(fn)-4 ) )
  
  # Add to dataframe
  file.df$SessionDate = SessionDate
  file.df$ParticipantID = ParticipantID
  file.df$Coh = file.df$LeftCoh + file.df$RightCoh
  file.df$Run = rep( Run, length( file.df$Coh) )
  file.df$DegPSec = rep( DegPSec, length( file.df$Coh) )
  
  fn.noext = substring( fn, 1, 21 )
  fn.out = paste(fn.noext, "-ext.csv", sep="")
  fn.fullpath = paste( f.path, "/", fn.out, sep="/")
  cat("Writing ", fn.out, "\n\n")
  write.csv( file.df, fn.fullpath, row.names = FALSE  )
  return( file.df )
}