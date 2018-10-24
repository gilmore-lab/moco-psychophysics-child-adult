# Imports and converts files given session directory
# Assumes sessions are in YYYY-MM-DD form
# Assumes sessions are in ../data relative to analyses/
# Returns data frame
# Writes YYYY-MM-DD-combined.csv to ../data/YYYY-MM-DD/
import.convert.session <- function( session ){
  session.list = list.files("../data")
  if ( session %in% session.list ){
    source("import.convert.R")
    files.in.session = list.files(paste("../data", session, sep="/"),
                                  pattern="\\.csv$" )
    cat("Files in this session include: ", files.in.session, "\n\n")
    datalist = lapply( files.in.session, import.convert, session=session )
    
    df.combined = Reduce( function(x,y) {merge(x,y, all=TRUE, sort=FALSE)}, datalist )
        
    # Write combined data frame to file
    fn.combined = paste(session, "-combined.csv", sep="")
    cat("Writing", fn.combined, "\n")
    fn.combined.full = paste("../data/", session, "/", fn.combined, sep="")
    write.csv( df.combined, fn.combined.full, row.names = FALSE  )
    return( df.combined )
    } else {
    cat("Session ", session, "not found.\n")
  }
}