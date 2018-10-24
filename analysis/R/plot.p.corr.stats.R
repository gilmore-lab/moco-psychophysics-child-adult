# Script fragment to run lme analyses on p(corr) and RT
# and then interpret effects

require(nlme)
require(dplyr)
require(ggplot2)

# load data
df <- read.csv(file = "analyses/data-aggregate/moco-beh-child.csv", header = TRUE)

# Source functions
fn.list <- list("analyses/summarize.bysub.bycond.R", 
                "analyses/plot.p.corr.R", 
                "analyses/plot.rt.R",
                "analyses/plot.p.corr.by.age.yrs.R")
lapply(fn.list, source, echo = FALSE, print.eval = FALSE)

# Summary data table to compute p(corr)
df.bysub.bycond <- summarize.bysub.bycond(df)

# Simple mixed linear modeling
lme.p.corr <- lme( Pct.Corr ~ ordered(Coh)*PatternType*Speed, 
                   random = ~ 1 | SubID, 
                   data=df.bysub.bycond )
anova(lme.p.corr)

# Evaluate Speed by Coherence interaction
spd.by.coh <- df.bysub.bycond %>%
  group_by(Speed, Coh) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))

limits = aes( ymax = Pct.Corr.mean + Pct.Corr.sem , ymin = Pct.Corr.mean - Pct.Corr.sem )

#qplot(data = spd.by.coh, Coh, Pct.Corr.mean, facets = ~ Speed)
p1 <- 
  ggplot( data=spd.by.coh, aes(x=Coh, y=Pct.Corr.mean) ) +
  facet_grid( facets = ~ Speed ) +
  geom_line() +
  geom_pointrange( limits ) +
  xlim(0,.8) +
  ylim(.3,1.1) +
  ylab("p(corr)") +
  xlab("p(coherence)")
p1

# Evaluate PatternType x Coherence interaction
patt.by.coh <- df.bysub.bycond %>%
  group_by(PatternType, Coh) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))

#qplot(data = patt.by.coh, Coh, Pct.Corr.mean, facets = ~ PatternType)
p2 <- 
  ggplot( data=patt.by.coh, aes(x=Coh, y=Pct.Corr.mean) ) +
  facet_grid( facets = ~ PatternType ) +
  geom_line() +
  geom_smooth(color="white") +
  geom_pointrange( limits ) +
  xlim(0, 1) +
  ylim(.5, 1.1) +
  ylab("p(corr)") +
  xlab("p(coherence)")
p2