create.william.datafile <- function(volume=73){
  # Clear workspace to begin
  rm( list=ls() )
  
  # Source external functions
  source('bulk.import.convert.sessions.R')
  source("merge.with.databrary.R")
  
  dir.databrary.api <- "databrary-r-api"
  source( paste( dir.databrary.api, "databrary.login.R", sep="/" ) )
  source( paste( dir.databrary.api, "download.csv.R", sep="/" ) )
  source( paste( dir.databrary.api, "databrary.logout.R", sep="/" ) )
  
  # Create new aggregate file
  bulk.import.convert.sessions()
  
  # Merge Databrary and aggregate files, clean-up
  df.merge <- merge.with.databrary(volume=volume)
  return( df.merge ) 
}