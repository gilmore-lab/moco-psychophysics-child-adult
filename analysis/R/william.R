# william.R
#
# William's analysis commands

# History
# 2014-11-17 initial version
# 2015-03-19 rogilmore modified

# Clear workspace to begin
rm( list=ls() )

# Source external functions
source("create.william.datafile.R")
create.william.datafile()

# Merge Databrary and aggregate files, clean-up
df.merge <- read.csv(file="../aggregate-data/databrary-session-data.csv")

# load plotting library 
library( ggplot2 )
library( dplyr )

df1 <- df.merge %>%
  group_by( ParticipantID, PatternType, DegPSec, Coh ) %>%
  summarise( p.corr=sum( Acc == TRUE )/n() ) 

qplot( data=df1, x=Coh, 
       y=p.corr, 
       facets = PatternType ~ DegPSec, 
       group=ParticipantID, 
       geom=c("point", "smooth"), 
       color=as.factor(ParticipantID) )

# plot RTs
qplot( x=as.factor(Coh), y=RT, facets = DegPSec ~ PatternType,geom="boxplot", data=sess )

# Source p.corr... commmand
source('~/Box Sync/gilmore-lab/projects/optic-flow/optic-flow-psychophysics/projects/moco-3-pattern-psychophysics/adult-laminar-radial/analyses/calculate.p.corr.R')

# calculate and plot p correct
sess.p.corr.df = calculate.p.corr( sess )

# plot
qplot( x=as.factor(Coh), y=Pcorr, data=sess.p.corr.df, facets = DegPSec ~ PatternType, shape=as.factor(Run) )

# Print summary of RTs -- mean, sd, n, median -- by Pattern, Speed, Block..

df.merge %>%
  group_by( PatternType, DegPSec, Coh, ParticipantID ) %>%
  summarise( mean.RT = mean( RT ),
             sem.RT = sd(RT)/sqrt( n() ),
             nsubs = n(),
             median.RT = median( RT )
)

df.merge %>%
  group_by( PatternType, Coh ) %>%
  summarise( mean.RT = mean( RT ),
             sem.RT = sd(RT)/sqrt( n() ),
             nsubs = n(),
             median.RT = median( RT )
  )

df.merge %>%
  group_by( PatternType, ParticipantID ) %>%
  summarise( mean.RT = mean( RT ),
             sd.RT = sd(RT),
             n = n(),
             median.RT = median( RT )
  ) 


# Print summary of Pct Corr -- 

df1 %>%
  group_by( PatternType, ParticipantID ) %>%
  summarise( mean.p.corr = mean( p.corr ),
             sd.p.corr = sd(p.corr),
             n = n(),
             median.p.corr = median( p.corr )
  ) 

df1 %>%
  group_by( DegPSec, ParticipantID ) %>%
  summarise( mean.p.corr = mean( p.corr ),
             sd.p.corr = sd(p.corr),
             n = n(),
             median.p.corr = median( p.corr )
  ) 

# ANOVA on RT

aov.rt <- aov( formula=RT ~ DegPSec*PatternType*Coh + Error(ParticipantID), data = df.merge )
summary( aov.rt )
df.merge %>%
  group_by( PatternType, Coh ) %>%
  summarise( mean.RT = mean( RT ),
             sd.RT = sd(RT),
             n = n(),
             median.RT = median( RT )
  ) 

aov.p.corr <- aov( formula=p.corr ~ DegPSec*PatternType*Coh + Error(ParticipantID), data = df1 )
summary( aov.p.corr )
df1 %>%
  group_by( PatternType, Coh ) %>%
  summarise( mean.p.corr = mean( p.corr ),
             sd.p.corr = sd(p.corr),
             n = n(),
             median.p.corr = median( p.corr )
  ) 


