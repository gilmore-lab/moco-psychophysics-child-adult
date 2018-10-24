# Import adult data, normalize with child data
moco.beh.adult <- read.csv("~/github/gilmore-lab/moco-3-pattern-psychophysics/adult-laminar-radial/analysis/data/adult-laminar-radial-grouped.csv")

# Drop variables, normalize names
drop.vars <- c("SessionDate", "Race", "Ethnicity", "Language", "Setting", "State", "Run", "SpeedOrder")
moco.beh.adult <- moco.beh.adult[, !(names(moco.beh.adult) %in% drop.vars)]
names(moco.beh.adult)[1] <- "SubID"
names(moco.beh.adult)[11:13] <- c("Speed", "Gender", "AgeYears")

# Fix NA problem
moco.beh.adult$Acc <- as.logical(moco.beh.adult$Acc)
moco.beh.adult$Acc[is.na(moco.beh.adult$Acc)] <- FALSE

# Convert age in days to years
moco.beh.adult$AgeYrs <- cut(moco.beh.adult$AgeYears, 
                 breaks = c(0,18,19,20,21,22,23,24), 
                 labels = c("<18yo", "18yo", "19yo", "20yo", "21yo", "22yo", "23yo"))

moco.beh.adult %>%
  group_by(AgeYrs, Gender, SubID, PatternType, Speed, Coh) %>% 
  summarize(N.corr = sum(Acc), 
            N.tot = n(), 
            Pct.Corr = N.corr/N.tot,
            RT.mean=mean(RT),
            RT.sd=sd(RT)) -> 
  df.bysub.bycond

df <- moco.beh.adult