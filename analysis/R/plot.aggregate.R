# plot.aggregate.R
# Script to make several plots based on the aggregate data.

# libraries
require(dplyr, ggplot2)

# load data
df <- read.csv(file = "analyses/data-aggregate/moco-beh-child.csv", header = TRUE)

# Source functions
fn.list <- list("analyses/summarize.bysub.bycond.R", 
                "analyses/plot.p.corr.R", 
                "analyses/plot.rt.R",
                "analyses/plot.p.corr.by.age.yrs.R")
lapply(fn.list, source, echo = FALSE, print.eval = FALSE)

# summarize across participants, conditions
df.bysub.bycond <- summarize.bysub.bycond(df)

# summary table of age/gender dist
df.bysub.bycond %>% 
  group_by(Gender, AgeYrs, SubID) %>% 
  summarize(num = n()) -> df.gender.age
xtabs(formula = ~ AgeYrs + Gender, data = df.gender.age)

# Plot p(corr)
p1 <- plot.p.corr(df.bysub.bycond)
p1
ggsave(plot = p1, filename = "analyses/img/p.corr.png")

# Plot RTs
p2 <- plot.rt(df.bysub.bycond)
p2
ggsave(plot = p2, filename = "analyses/img/rt.png")

# Plot p(corr) by age
p3 <- plot.p.corr.by.age.yrs(df.bysub.bycond)
p3
ggsave(plot = p3, filename = "analyses/img/p.corr.by.age.yrs.png")


