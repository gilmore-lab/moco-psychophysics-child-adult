# convert.sessions.R
#
# Script to convert session-level data
#
# Assumes current working directory is .../adult-laminar-radial/analyses
# Assumes data are in ../data

# History
# 2014-11-17 rogilmore wrote

# Which session? Change to suit
session.to.convert = "2014-11-11-004" # Change as needed

# Is current working directory the right one?
desired.wd = "adult-laminar-radial/analyses"
current.wd = getwd()
current.tail = substring(current.wd, 
                          nchar(current.wd)-nchar(desired.wd)+1, nchar(current.wd))
if ( current.tail == desired.wd ) {
  # Source conversion functions
  source("import.convert.R")
  source("import.convert.session.R")
  
  # for each session to import, run the following
  # folder session is in YYYY-MM-DD-NNN, e.g. 2014-10-13-001
  import.convert.session( session.to.convert ) 
} else {
  sprintf("Not in correct working directory; should be ..%s", desired.wd)
}