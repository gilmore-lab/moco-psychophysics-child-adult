# fit glm using lme4's glmer (for binomial link)

# GLM model fit
require(psyphy) # for mafc
require(lme4)

# Full model
form.full <- Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + (1|SubID)
mod.full <- glmer(formula = form.full, family=binomial(mafc.probit(2)), data = df)
summary(mod.full)

# Drop Coh:PatternType (p<.047)
form.reduced1 <- Acc ~ Coh + Speed + PatternType + Coh:Speed + (1|SubID)
mod.red1 <- update(mod.full, formula = form.reduced1)
summary(mod.red1)

anova(mod.full, mod.red1)

# Test age in years effect
form.age <- Acc ~ Coh + Speed + PatternType + Coh:Speed + AgeYrs + (1|SubID)
mod.age <- update(mod.full, formula = form.age)
summary(mod.age)

anova(mod.red1, mod.age)
