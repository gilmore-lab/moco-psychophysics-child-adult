# plot.aggregate.data.R
#
# Load and plot P.corr and RT data
#
# Libraries: ggplot2, dplyr, nlme

# History
# 2014-11-18 rogilmore wrote
# 2014-12-02 rogilmore modified

# load libraries
library(ggplot2)
library(dplyr)
library(nlme)

# load dataset
moco <- read.csv("../aggregate-data/adult-laminar-radial-grouped.csv")

# fix dataframe
moco$SessionDate = as.Date( moco$SessionDate )
moco$DegPSec = ordered( moco$DegPSec )
moco$Acc = as.logical( moco$Acc )
moco$ParticipantID = as.factor( moco$ParticipantID )

# convert to dplyr table
tbl.moco <- tbl_df( moco )

# Compute and plot proportion correct by pattern and speed
tbl.p.corr <- tbl.moco %>%
  group_by( ParticipantID, DegPSec, PatternType, Coh ) %>%
  summarise( P.Corr=mean( Acc ) ) %>%
  filter( !is.na(P.Corr) )

pl <- ggplot(data=tbl.p.corr) + 
  facet_grid( facets = DegPSec ~ PatternType )

pl.p.corr <- pl +
  geom_boxplot( aes(x=ordered(Coh), y=P.Corr) )

# Compute and plot RT for correct responses
tbl.rt <- tbl.moco %>%
  filter( Acc==TRUE ) %>%
  group_by( ParticipantID, DegPSec, PatternType, Coh ) 

pl.rt <- pl %+% tbl.rt +
  geom_boxplot( aes(x=ordered(Coh), y=RT) )

# Simple mixed linear modeling
lme.p.corr <- lme( P.Corr ~ ordered(Coh)*PatternType*DegPSec, 
                   random = ~ 1 | ParticipantID, 
                   data=tbl.p.corr )

anova( lme.p.corr )

# Investigate PatternType x Coh Interaction
tbl.p.corr.by.spd.pattern.coh <- tbl.p.corr %>%
  group_by(DegPSec, PatternType, Coh, ParticipantID) %>%
  summarise( P.Corr.mean=mean(P.Corr, na.rm=TRUE) )

qplot( data=tbl.p.corr.by.spd.pattern.coh, 
       x=Coh, y=P.Corr.mean, 
       group=ParticipantID, 
       facets = DegPSec ~ PatternType, 
       geom=c("point", "line"), 
       color=ParticipantID )

# RT model
lme.rt <- lme( RT ~ Coh*PatternType*DegPSec, 
              random = ~ 1 | ParticipantID, 
              data=tbl.rt )

anova( lme.rt )

# Investigate Speed X Coh interaction
tbl.rt.by.spd.pattern.coh <- tbl.rt %>% 
  group_by(DegPSec, PatternType, Coh, ParticipantID ) %>%
  summarise( RT.mean=mean(RT, na.rm=TRUE), 
             RT.sem=sd(RT, na.rm=TRUE)/sqrt( n() ) )

# qplot( data=tbl.rt.by.spd.pattern.coh, 
#        x=Coh, y=RT.mean, 
#        group=ParticipantID, 
#        facets = DegPSec ~ PatternType, 
#        geom=c("point", "line"), 
#        color=as.factor(ParticipantID) )

limits = aes( ymax = RT.mean + RT.sem, ymin = RT.mean - RT.sem, group=ParticipantID )

pl.rt.bysub.pointrange <- 
  ggplot( data=tbl.rt.by.spd.pattern.coh, aes(x=Coh, y=RT.mean, group=ParticipantID, color=ParticipantID) ) +
  facet_grid( facets = DegPSec ~ PatternType ) +
  geom_line() +
  geom_pointrange( limits )

# Tables to investigate main effects and interactions
tbl.rt %>%
  group_by( DegPSec, ParticipantID ) %>%
  summarise( Part.mean = mean(RT, na.rm=TRUE), ct=n() ) %>%
  group_by( DegPSec ) %>%
  summarise( Spd.mean = mean( Part.mean ), Spd.sem=sd( Part.mean )/sqrt( n() ) )

# Plot RT differences by pattern across speeds by participant
tbl.rt.patt.bysub <- tbl.rt %>%
  group_by( PatternType, ParticipantID ) %>%
  summarise( Part.mean = mean(RT, na.rm=TRUE), Part.sem = sd( RT )/sqrt(n()) ) %>%
  group_by( PatternType )

ggplot( data=tbl.rt.patt.bysub ) +
  aes( x=ParticipantID, y=Part.mean, color=PatternType ) +
  geom_point()

# Plot RT differences by speed across patterns by participant
tbl.rt.spd.bysub <- tbl.rt %>%
  group_by( DegPSec, ParticipantID ) %>%
  summarise( Part.mean = mean(RT, na.rm=TRUE), Part.sem = sd( RT )/sqrt(n()) ) %>%
  group_by( DegPSec )

ggplot( data=tbl.rt.spd.bysub ) +
  aes( x=ParticipantID, y=Part.mean, color=DegPSec ) +
  geom_point()
