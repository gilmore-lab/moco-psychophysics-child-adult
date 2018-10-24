# merge.sessions.R
#
# Script to merge session-level data files
#
# Assumes current working directory is .../adult-laminar-radial/analyses
# Assumes data are in ../data
# Assumes converted data have *combined.csv pattern at the tail

# History
# 2014-11-17 rogilmore wrote

aggregate.data.dir = "../aggregate-data"

session.list = list.files( path="../data/", recursive=TRUE, pattern="combined\\.csv$", full.names=TRUE)
session.df.list = lapply( session.list, read.csv )
sessions.df = Reduce( function(x,y) {merge(x,y, all=TRUE, sort=FALSE)}, session.df.list )

fn.combined = paste(aggregate.data.dir, "adult-laminar-radial-grouped.csv", sep="/")
cat("Writing", fn.combined, "\n")
write.csv( sessions.df, fn.combined, row.names = FALSE  )