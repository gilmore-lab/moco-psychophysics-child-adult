# import.clean.export.R
#
# Imports session-specific data files. Creates aggregate data file. Imports participant-level metadata.
# Drops unneeded or duplicate variables. Exports csv file.
#
# Assumes working directory is child-laminar-radial, home of the .Rproj file
#
# To run, source("analyses/import.clean.export.R") from the project home

# Paths

analyses.dir <- "analyses"
session.dir <- "data-study-bysession"
data.dir <- paste(analyses.dir, session.dir, sep="/")
metadata.dir <- paste(analyses.dir, "data-participant-metadata", sep = "/")
metadata.fn <- paste(metadata.dir, "moco_child_participant_metadata.csv", sep="/")
aggregate.dir <- paste(analyses.dir, "data-aggregate", sep="/")
aggregate.fn <- paste(aggregate.dir, "moco-beh-child.csv", sep = "/")

# Source dependent functions

r.list <- list("analyses/extract.date.sub.R", "analyses/standardize.date.R", "analyses/df.moco.child.R")
lapply(r.list, source, echo = FALSE, print.eval = FALSE)

# Load datafiles
df.list <- lapply(list.files(path=data.dir, pattern = ".csv$", full.names = TRUE), df.moco.child)

msg <- sprintf("Creating aggregate data file from sessions in:\n\t%s\n", data.dir)
cat(msg)
df.all <- Reduce(function(x,y) merge(x,y, all=TRUE), df.list)

sub.data <- read.csv(file = metadata.fn, header=TRUE)
moco.beh.child <- merge(df.all, sub.data, by.x = "SubID", by.y = "participant.ID")

# Drop variables, normalize names
drop.vars <- c("session.date", "participant.birthdate")
moco.beh.child <- moco.beh.child[, !(names(moco.beh.child) %in% drop.vars)]
names(moco.beh.child)[11:14] <- c("AgeDays", "Gender", "Condition", "Group")

# Load libraries
library(dplyr)
library(ggplot2)

# Add Coh
moco.beh.child %>% mutate(Coh = LeftCoh + RightCoh) -> moco.beh.child

# Fix NA problem
moco.beh.child$Acc <- as.logical(moco.beh.child$Acc)
moco.beh.child$Acc[is.na(moco.beh.child$Acc)] <- FALSE

# Write summary stats
moco.beh.child %>% group_by(SubID, PatternType, Speed, Coh) %>% 
  summarize(N.corr = sum(Acc), N.tot = n(), Pct.Corr = N.corr/N.tot) -> d.summ

# Write data file to csv
write.csv(x = moco.beh.child, file = aggregate.fn, row.names = FALSE)
msg <- sprintf("Wrote aggregate data file to: \n\t%s\n", aggregate.fn)
cat(msg)

# Clean-up
rm(d.summ, df.all, moco.beh.child, sub.data, 
   aggregate.dir, aggregate.fn, analyses.dir, data.dir, df.list,
   drop.vars, metadata.fn, metadata.dir, r.list, session.dir)

rm(df.moco.child, extract.date.sub, standardize.date)