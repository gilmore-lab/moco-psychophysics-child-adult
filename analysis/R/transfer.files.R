transfer.files <- function(fn, in.dir="~/Documents/MATLAB/src/local/exec/RDK/exp/child_2_degPs_output/", out.dir="~/Desktop/moco-child/"){
  # Given file directory, extract subject number and test date for each file
  source(paste(out.dir,"extract.date.sub.R", sep=""))
  
  setwd(in.dir)
  l <- extract.date.sub(fn)
  
  # Then, create new file directory for that subject and test date
  setwd(paste(out.dir, "session-data", sep=""))
  data.fn <- paste(l[[2]], "-", l[[1]], sep="")
  
  # Is there an existing directory for this subject and test date?
  files <- list.files(pattern=data.fn)
  
  # If files == empty, then create new folder with data.fn
  
  # Move data files for that subject and test date to the new folder
  
  return(data.fn)
}

