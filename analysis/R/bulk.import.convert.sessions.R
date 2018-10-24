# bulk.import.convert.sessions.R
# Imports and converts files given session directory
# Assumes sessions are in YYYY-MM-DD form
# Assumes sessions are in ../data relative to analyses/
# Returns data frame
# Writes YYYY-MM-DD-combined.csv to ../data/YYYY-MM-DD/
bulk.import.convert.sessions <- function( data.dir="../data", 
                                          desired.wd = "adult-laminar-radial/analyses",
                                          aggregate.data.dir = "../aggregate-data",
                                          verbose=FALSE ){
  # Check directory structure
  desired.wd = "adult-laminar-radial/analyses"
  current.wd = getwd()
  current.tail = substring(current.wd, 
                           nchar(current.wd)-nchar(desired.wd)+1, nchar(current.wd))
  
  if ( current.tail == desired.wd ) {
    session.list = list.files(data.dir)
    if (verbose) {
      cat("Sessions to convert include:\n", session.list, "\n")      
    }
    sessions.df.list = lapply( session.list, import.convert.session, data.dir=data.dir, verbose=verbose )
    
    aggregate.df <- create.aggregate.dataset(out.dir=aggregate.data.dir, data.dir=data.dir, verbose=verbose)
    return( aggregate.df )
  } else {
    cat("Current working directory %s is incorrect.", current.tail)
    return( NULL )
  }
}

# import.convert.session
#
# Imports and converts all runs from a single session
# Assumes sessions are in ../data/
# Assumes each session is formatted YYYY-MM-DD-NNN, where NNN is SubjectID
# 
# Calls:      import.convert.run
# Called by:  bulk.import.convert.sessions
import.convert.session <- function( session, data.dir="../data", verbose=TRUE ){
  files.in.session = list.files(paste(data.dir, session, sep="/"),
                                pattern="deg\\-[1-4]\\.csv$" )
  
  if (verbose) {
    cat("\nValid files in", paste( session, "/", sep=""), "include:\n", files.in.session, "\n\n")
  }
  
  run.list = lapply( files.in.session, import.convert.run, session=session, data.dir=data.dir, verbose=verbose )
  df.combined = Reduce( function(x,y) {merge(x,y, all=TRUE, sort=FALSE)}, run.list )
  
  # Write combined data frame to file
  fn.combined = paste(session, "-combined.csv", sep="")
  
  if (verbose) {
    cat("Writing", fn.combined, "\n") 
  }
  
  fn.combined.full = paste( data.dir, "/", session, "/", fn.combined, sep="")
  write.csv( df.combined, fn.combined.full, row.names = FALSE  )
  
  return( df.combined ) 
}


# import.convert.run
# 
# Imports and converts a file from a single run
# Assumes sessions are in ../data/
# Assumes each session is formatted YYYY-MM-DD-NNN, where NNN is SubjectID
# Assumes each run file is YYYY-MM-DD-NNN-[28]deg-[1-4].csv
import.convert.run <- function( run, session, data.dir, verbose=TRUE ){
  f.path = normalizePath( paste( data.dir, session, sep="/") )
  fn.full = paste(f.path, run, sep="/")
  if (verbose) {
    cat("Reading ", run, "\n" )    
  }
  run.df = read.csv( fn.full )
  
  if (verbose) {
    cat("Adding new variables.\n")
  }
  # SessionDate matches session.date from Databrary export
  # ParticipantID matches participant.ID from Databrary export
  # merge( this.aggregate, databrary.export, 
  #        by.x=c("SessionDate","ParticipantID), 
  #        by.y=c("session.date", "participant.id"))
  SessionDate = as.Date( substring(run, 1, 10) ) # YYYY-MM-DD
  ParticipantID = as.numeric( substring( run, 12, 14 ) ) #NNN
  DegPSec = as.numeric( substring( run, nchar(run)-9, nchar(run)-9 ) )
  Run = as.numeric( substring( run, nchar(run)-4, nchar(run)-4 ) )
  
  # Add to dataframe
  run.df$SessionDate = SessionDate
  run.df$ParticipantID = ParticipantID
  run.df$Coh = run.df$LeftCoh + run.df$RightCoh
  run.df$Run = rep( Run, length( run.df$Coh) )
  run.df$DegPSec = rep( DegPSec, length( run.df$Coh) )
  
  fn.noext = substring( run, 1, 21 )
  fn.out = paste(fn.noext, "-ext.csv", sep="")
  fn.fullpath = paste( f.path, "/", fn.out, sep="/")
  if (verbose) {
    cat("Writing ", fn.out, "\n\n")
  }
  write.csv( run.df, fn.fullpath, row.names = FALSE  )
  return( run.df )
}


# create.aggregate.dataset
#
# Assumes current working directory is .../adult-laminar-radial/analyses
# Assumes data are in data.dir
# Assumes converted data have *combined.csv pattern at the tail
create.aggregate.dataset <- function(out.dir, data.dir, out.fn="adult-laminar-radial-grouped.csv", verbose=TRUE) {  
  session.list = list.files( path=data.dir, recursive=TRUE, pattern="combined\\.csv$", full.names=TRUE)
  session.df.list = lapply( session.list, read.csv )
  sessions.df = Reduce( function(x,y) {merge(x,y, all=TRUE, sort=FALSE)}, session.df.list )
  
  fn.combined = paste(out.dir, out.fn, sep="/")
  if (verbose) {
    cat("\nWriting aggregate file to", fn.combined, "\n")    
  }
  write.csv( sessions.df, fn.combined, row.names = FALSE  )
  return( sessions.df )
}
