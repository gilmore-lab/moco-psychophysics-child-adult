merge.with.databrary <- function(in.dir="../aggregate-data",
                                 in.fn="adult-laminar-radial-grouped.csv",
                                 out.fn="databrary-session-data.csv", 
                                 volume=73){
  # merge spreadsheet file from Databrary with aggregate
  
  dir.databrary.api <- "databrary-r-api"
  source( paste( dir.databrary.api, "databrary.login.R", sep="/" ) )
  source( paste( dir.databrary.api, "download.csv.R", sep="/" ) )
  source( paste( dir.databrary.api, "databrary.logout.R", sep="/" ) )
  
  # Download Databrary spreadsheet
  databrary.login()
  df.db <- download.csv(volume=73)
  databrary.logout()
  
  # Read data frames
  df.moco <- read.csv(paste(in.dir, in.fn, sep="/"))
  
  # Merge data frames
  df.merge <- merge( df.moco, df.db, by.x=c("ParticipantID","SessionDate"), by.y=c("participant.ident", "session.date"))
  
  # Calculate age at test
  df.merge$participant.birthdate <- as.Date( df.merge$participant.birthdate )
  df.merge$SessionDate <- as.Date( df.merge$SessionDate )
  age.days <- df.merge$SessionDate - df.merge$participant.birthdate
  df.merge$AgeYears <- as.numeric( age.days / 365.25 )
  
  # clean-up/remove unneeded variables
  drops = c("participant.birthdate", "task.ID", "task.description", "task.2.ID", "task.2.description", "X")
  df.merge <- df.merge[,!( names(df.merge) %in% drops ) ]
  rm( df.moco, df.db, age.days, drops )
  
  # export merged data
  write.csv(df.merge, file = paste(in.dir, out.fn, sep="/") )
  
  return( df.merge )
}