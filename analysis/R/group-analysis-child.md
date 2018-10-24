group-analysis-children
================
Rick O. Gilmore
2017-03-28

Background
----------

This document describes the workflow involved in analyzing the motion coherence psychophysics study carried out with child participants.

Import data
-----------

Here we import the aggregate data file found in `analyses/data-aggregate/moco-beh-child.csv`, convert `AgeDays` to a categorical factor, `AgeYrs`, and compute some summary statistics across trial and block. These summary values are saved to the `df.bysub.bycond` data frame.

``` r
# Import child data, normalize

df <- read.csv(file = "analyses/data-aggregate/moco-beh-child.csv", header = TRUE)

# Convert age in days to years
df$AgeYrs <- ordered(cut(df$AgeDays/365.25, 
                 breaks = c(0,5,6,7,8,9), 
                 labels = c("<5yo", "5yo", "6yo", "7yo", "8yo")))

df %>% 
  group_by(AgeYrs, Gender, SubID, PatternType, Speed, Coh) %>% 
  summarize(N.corr = sum(Acc), 
            N.tot = n(), 
            Pct.Corr = N.corr/N.tot,
            RT.mean=mean(RT),
            RT.sd=sd(RT)) -> 
  df.bysub.bycond
```

Tabular summary of participant ages by gender
---------------------------------------------

``` r
# Summary table of age/gender dist
df.bysub.bycond %>% 
  group_by(Gender, AgeYrs, SubID) %>% 
  summarize(num = n()) -> df.gender.age
xt <- xtabs(formula = ~ AgeYrs + Gender, data = df.gender.age)
kable(xt)
```

|     |  Female|  Male|
|-----|-------:|-----:|
| 5yo |       7|     2|
| 6yo |       6|     2|
| 7yo |       5|     4|
| 8yo |       1|     2|

We tested *n*=29 children overall, (19 female) between 5 and 8 years of age.

Histogram of age
----------------

``` r
df %>%
  group_by(AgeYrs, SubID, AgeDays) %>%
  summarize(SubAgeDays = mean(AgeDays)) %>%
  ggplot() +
  aes(x=SubAgeDays/365.25, fill = AgeYrs) + # By years?
  geom_histogram() +
  xlab("Age in Years")
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](group-analysis-child_files/figure-markdown_github/age-histogram-1.png)

Violin plot of age by sex
-------------------------

``` r
theme.custom <- theme(plot.title = element_text(size=16, face="bold"),
                      axis.title.x = element_text(size=14),
                      axis.title.y = element_text(size=14),
                      strip.text = element_text(size=14),
                      axis.text = element_text(size=12),
                      legend.position="bottom", 
                      legend.title=element_blank())

df %>%
  group_by(AgeYrs, Gender, SubID, AgeDays) %>%
  summarize(SubAgeDays = mean(AgeDays)) %>%
  ggplot() +
  aes(x=Gender, y=SubAgeDays/365.25) + # By years?
  # geom_boxplot() +
  geom_violin() +
  geom_point(aes(color=AgeYrs)) +
  ylab("Age in Years") +
  theme_bw() +
  theme.custom
```

![](group-analysis-child_files/figure-markdown_github/age-sex-violin-1.png)

Plot of *p*(corr) by condition
------------------------------

``` r
  # Plot theme, customizations

y_lbl <- 'p(corr)'
title_text <- 'p(corr) by Coherence, Pattern, and Speed'
df.bysub.bycond$Speed <- factor(df.bysub.bycond$Speed, labels = c("2 deg/s", "8 deg/s"))

# Plot for all subs
p <- ggplot(data=df.bysub.bycond, aes(x=Coh, y=Pct.Corr)) 
p <- p + 
  geom_line(aes(group=SubID, color=AgeYrs)) +
  facet_grid(facets = Speed ~ PatternType) +
  labs(x="Coherence", y=y_lbl) +
  #ggtitle(title_text) +
  theme_bw() +
  theme.custom +
  xlim(0, 1) +
  geom_hline(yintercept=0.5, linetype="dashed")
p
```

![](group-analysis-child_files/figure-markdown_github/p-corr-plot-1.png)

The proportion correct responses generally increase with increasing coherence. There is a hint that younger children are less accurate.

Plot of reaction time
---------------------

``` r
# Plot RTs
y_lbl <- 'RT (s)'
title_text <- 'RT by Coherence, Pattern, and Speed'

# Plot for all subs
p <- ggplot(data=df.bysub.bycond, aes(x=Coh, y=RT.mean))
p <- p + 
  geom_line(aes(group=SubID, color=AgeYrs)) +
  facet_grid(facets = Speed ~ PatternType) +
  labs(x="Coherence", y=y_lbl) +
  # ggtitle(title_text) +
  theme_bw() +
  theme.custom +
  xlim(0, 1)
p 
```

![](group-analysis-child_files/figure-markdown_github/rt-plot-1.png)

Reaction times generally decrease with increasing coherence. There is evidence that younger children are slower.

Plot of speed across patterns
-----------------------------

``` r
# Evaluate Speed by Coherence interaction
spd.by.coh <- df.bysub.bycond %>%
  group_by(Speed, Coh) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))

limits = aes( ymax = Pct.Corr.mean + Pct.Corr.sem , ymin = Pct.Corr.mean - Pct.Corr.sem )

p4 <- 
  ggplot( data=spd.by.coh, aes(x=Coh, y=Pct.Corr.mean) ) +
  facet_grid( facets = . ~ Speed ) +
  geom_line() +
  geom_pointrange( limits ) +
  xlim(0,1) +
  ylim(.4, 1) +
  ylab("p(corr)") +
  xlab("Coherence)") +
  theme_bw() +
  theme.custom +
  geom_hline(yintercept=0.5, linetype="dashed")
p4
```

![](group-analysis-child_files/figure-markdown_github/coh-by-speed-aross-pattern-plot-1.png)

Plot of pattern across speeds
-----------------------------

``` r
patt.by.coh <- df.bysub.bycond %>%
  group_by(PatternType, Coh) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))
p5 <- 
  ggplot( data=patt.by.coh, aes(x=Coh, y=Pct.Corr.mean) ) +
  facet_grid( facets = ~ PatternType ) +
  geom_line() +
  geom_pointrange( limits ) +
  xlim(0, 1) +
  ylim(.4, 1) +
  ylab("p(corr)") +
  xlab("Coherence)") +
  theme_bw() +
  theme.custom +
  geom_hline(yintercept=0.5, linetype="dashed")
p5
```

![](group-analysis-child_files/figure-markdown_github/coh-by-pattern-across-speeds-plot-1.png)

Plot of speed across patterns by age
------------------------------------

``` r
# Evaluate Speed by Coherence interaction
spd.by.coh <- df.bysub.bycond %>%
  group_by(Speed, Coh, AgeYrs) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))

limits = aes( ymax = Pct.Corr.mean + Pct.Corr.sem , ymin = Pct.Corr.mean - Pct.Corr.sem )

p6 <- 
  ggplot( data=spd.by.coh, aes(x=Coh, y=Pct.Corr.mean, color = AgeYrs) ) +
  facet_grid( facets = . ~ Speed ) +
  geom_line() +
  geom_pointrange( limits ) +
  xlim(0,1) +
  ylim(.4, 1) +
  ylab("p(corr)") +
  xlab("p(coherence)") +
  theme_bw() +
  theme.custom +
  geom_hline(yintercept=0.5, linetype="dashed")
p6
```

![](group-analysis-child_files/figure-markdown_github/coh-by-speed-and-age-plot-1.png)

Plot of coherence by pattern across age
---------------------------------------

``` r
patt.by.coh <- df.bysub.bycond %>%
  group_by(PatternType, Coh, AgeYrs) %>%
  summarize(Pct.Corr.mean = mean(Pct.Corr, na.rm=TRUE),
            Pct.Corr.sem = sd(Pct.Corr, na.rm=TRUE)/sqrt( n() ))
p7 <- 
  ggplot( data=patt.by.coh, aes(x=Coh, y=Pct.Corr.mean, color = AgeYrs) ) +
  facet_grid( facets = ~ PatternType ) +
  geom_line() +
  geom_pointrange( limits ) +
  xlim(0, 1) +
  ylim(.4, 1) +
  ylab("p(corr)") +
  xlab("p(coherence)") +
  theme_bw() +
  theme.custom +
  geom_hline(yintercept=0.5, linetype="dashed")
p7
```

![](group-analysis-child_files/figure-markdown_github/coh-by-pattern-and-age-plot-1.png)

Probit analysis
---------------

### Full model

``` r
form.full <- Acc ~ AgeYrs * Coh * Speed * PatternType + (1|SubID)
mod.full <- glmer(formula = form.full, family=binomial(mafc.probit(2)), data = df)
```

``` r
summary(mod.full)
```

The full model fails to converge, so let's fit a model without `AgeYrs` than add back in those effects.

### Drop age

``` r
form.drop.age <- Acc ~ Coh * Speed * PatternType + (1|SubID)
mod.drop.age <- glmer(formula = form.drop.age, family=binomial(mafc.probit(2)), data = df)
```

This model also fails to converge, so let's choose specific effects that appear to characterize the fits.

### Drop high level interactions

``` r
form.drop.three.way <- Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + (1|SubID)
mod.drop.three.way <- glmer(formula = form.drop.three.way, family=binomial(mafc.probit(2)), data = df)
```

Model converges.

``` r
summary(mod.drop.three.way)
```

    ## Generalized linear mixed model fit by maximum likelihood (Laplace
    ##   Approximation) [glmerMod]
    ##  Family: binomial  ( mafc.probit(2) )
    ## Formula: Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType +  
    ##     (1 | SubID)
    ##    Data: df
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   5628.1   5678.0  -2807.0   5614.1     9273 
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -35.939   0.103   0.239   0.399   0.890 
    ## 
    ## Random effects:
    ##  Groups Name        Variance Std.Dev.
    ##  SubID  (Intercept) 0.2317   0.4813  
    ## Number of obs: 9280, groups:  SubID, 29
    ## 
    ## Fixed effects:
    ##                        Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)           -0.803185   0.158934  -5.054 4.34e-07 ***
    ## Coh                    2.979081   0.318422   9.356  < 2e-16 ***
    ## Speed                 -0.007001   0.019622  -0.357 0.721268    
    ## PatternTyperadial      0.795109   0.118030   6.736 1.62e-11 ***
    ## Coh:Speed              0.197364   0.051216   3.854 0.000116 ***
    ## Coh:PatternTyperadial -0.598986   0.302907  -1.977 0.047990 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) Coh    Speed  PttrnT Ch:Spd
    ## Coh         -0.748                            
    ## Speed       -0.618  0.692                     
    ## PttrnTyprdl -0.407  0.450  0.034              
    ## Coh:Speed    0.523 -0.733 -0.890 -0.023       
    ## Ch:PttrnTyp  0.340 -0.463 -0.029 -0.890  0.030

Can we drop main effect of `Speed`?

### Drop main effect of `Speed`

``` r
form.drop.speed <- Acc ~ Coh + PatternType + Coh:Speed + Coh:PatternType + (1|SubID)
mod.drop.speed <- update(mod.drop.three.way, formula = form.drop.speed)
```

Model converges.

``` r
summary(mod.drop.speed)
```

    ## Generalized linear mixed model fit by maximum likelihood (Laplace
    ##   Approximation) [glmerMod]
    ##  Family: binomial  ( mafc.probit(2) )
    ## Formula: 
    ## Acc ~ Coh + PatternType + (1 | SubID) + Coh:Speed + Coh:PatternType
    ##    Data: df
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   5626.2   5669.0  -2807.1   5614.2     9274 
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -34.836   0.103   0.238   0.400   0.893 
    ## 
    ## Random effects:
    ##  Groups Name        Variance Std.Dev.
    ##  SubID  (Intercept) 0.2315   0.4812  
    ## Number of obs: 9280, groups:  SubID, 29
    ## 
    ## Fixed effects:
    ##                       Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)           -0.83834    0.12495  -6.709 1.95e-11 ***
    ## Coh                    3.05793    0.22980  13.307  < 2e-16 ***
    ## PatternTyperadial      0.79661    0.11796   6.753 1.45e-11 ***
    ## Coh:Speed              0.18112    0.02336   7.753 8.96e-15 ***
    ## Coh:PatternTyperadial -0.60218    0.30271  -1.989   0.0467 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) Coh    PttrnT Ch:Spd
    ## Coh         -0.564                     
    ## PttrnTyprdl -0.491  0.590              
    ## Coh:Speed   -0.075 -0.355  0.018       
    ## Ch:PttrnTyp  0.411 -0.614 -0.890  0.008

``` r
anova(mod.drop.three.way, mod.drop.speed)
```

    ## Data: df
    ## Models:
    ## mod.drop.speed: Acc ~ Coh + PatternType + (1 | SubID) + Coh:Speed + Coh:PatternType
    ## mod.drop.three.way: Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + 
    ## mod.drop.three.way:     (1 | SubID)
    ##                    Df    AIC  BIC  logLik deviance  Chisq Chi Df
    ## mod.drop.speed      6 5626.2 5669 -2807.1   5614.2              
    ## mod.drop.three.way  7 5628.1 5678 -2807.0   5614.1 0.1274      1
    ##                    Pr(>Chisq)
    ## mod.drop.speed               
    ## mod.drop.three.way     0.7211

There is no significant difference between the full(er) and reduced model. Let's examine the effect of dropping the `Coh:Pattern` interaction.

### Drop `Coh:Pattern` interaction

``` r
drop.coh.patt.int <- Acc ~ Coh + PatternType + Coh:Speed + (1|SubID)
mod.drop.coh.patt.int <- update(mod.drop.three.way, formula=drop.coh.patt.int)
```

Model converges.

``` r
summary(mod.drop.coh.patt.int)
```

    ## Generalized linear mixed model fit by maximum likelihood (Laplace
    ##   Approximation) [glmerMod]
    ##  Family: binomial  ( mafc.probit(2) )
    ## Formula: Acc ~ Coh + PatternType + (1 | SubID) + Coh:Speed
    ##    Data: df
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   5628.1   5663.8  -2809.1   5618.1     9275 
    ## 
    ## Scaled residuals: 
    ##      Min       1Q   Median       3Q      Max 
    ## -29.1821   0.1025   0.2397   0.4006   0.8830 
    ## 
    ## Random effects:
    ##  Groups Name        Variance Std.Dev.
    ##  SubID  (Intercept) 0.2307   0.4803  
    ## Number of obs: 9280, groups:  SubID, 29
    ## 
    ## Fixed effects:
    ##                   Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)       -0.73978    0.11352  -6.517 7.19e-11 ***
    ## Coh                2.78520    0.18164  15.334  < 2e-16 ***
    ## PatternTyperadial  0.58912    0.05393  10.925  < 2e-16 ***
    ## Coh:Speed          0.18170    0.02341   7.762 8.39e-15 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) Coh    PttrnT
    ## Coh         -0.432              
    ## PttrnTyprdl -0.298  0.121       
    ## Coh:Speed   -0.087 -0.446  0.059

``` r
anova(mod.drop.three.way, mod.drop.coh.patt.int)
```

    ## Data: df
    ## Models:
    ## mod.drop.coh.patt.int: Acc ~ Coh + PatternType + (1 | SubID) + Coh:Speed
    ## mod.drop.three.way: Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + 
    ## mod.drop.three.way:     (1 | SubID)
    ##                       Df    AIC    BIC  logLik deviance  Chisq Chi Df
    ## mod.drop.coh.patt.int  5 5628.1 5663.8 -2809.1   5618.1              
    ## mod.drop.three.way     7 5628.1 5678.0 -2807.0   5614.1 4.0745      2
    ##                       Pr(>Chisq)
    ## mod.drop.coh.patt.int           
    ## mod.drop.three.way        0.1304

This also does not improve the fit. So, we keep the interaction term.

### Table for best-fitting model (without age)

``` r
# Neither pander nor xtable had appropriate methods to print the table

# pander(mod.drop.three.way)
# print(xtable(mod.drop.three.way), type = "html")
```

### Add age back in to best model

``` r
age.main <- Acc ~ AgeYrs + Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + (1|SubID)
mod.age.main <- update(mod.drop.three.way, formula=age.main)
```

``` r
summary(mod.age.main)
```

    ## Generalized linear mixed model fit by maximum likelihood (Laplace
    ##   Approximation) [glmerMod]
    ##  Family: binomial  ( mafc.probit(2) )
    ## Formula: 
    ## Acc ~ AgeYrs + Coh + Speed + PatternType + (1 | SubID) + Coh:Speed +  
    ##     Coh:PatternType
    ##    Data: df
    ## 
    ##      AIC      BIC   logLik deviance df.resid 
    ##   5609.3   5680.6  -2794.6   5589.3     9270 
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -33.036   0.106   0.241   0.393   0.887 
    ## 
    ## Random effects:
    ##  Groups Name        Variance Std.Dev.
    ##  SubID  (Intercept) 0.08689  0.2948  
    ## Number of obs: 9280, groups:  SubID, 29
    ## 
    ## Fixed effects:
    ##                        Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)           -0.696633   0.144634  -4.817 1.46e-06 ***
    ## AgeYrs.L               0.844057   0.154117   5.477 4.33e-08 ***
    ## AgeYrs.Q               0.010267   0.136638   0.075 0.940103    
    ## AgeYrs.C              -0.059775   0.117807  -0.507 0.611877    
    ## Coh                    2.982617   0.317610   9.391  < 2e-16 ***
    ## Speed                 -0.007037   0.019600  -0.359 0.719559    
    ## PatternTyperadial      0.794982   0.117886   6.744 1.54e-11 ***
    ## Coh:Speed              0.197045   0.051100   3.856 0.000115 ***
    ## Coh:PatternTyperadial -0.602073   0.302182  -1.992 0.046325 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) AgYr.L AgYr.Q AgYr.C Coh    Speed  PttrnT Ch:Spd
    ## AgeYrs.L     0.143                                                 
    ## AgeYrs.Q     0.157  0.418                                          
    ## AgeYrs.C     0.108  0.195  0.154                                   
    ## Coh         -0.814  0.050  0.000 -0.014                            
    ## Speed       -0.679 -0.006 -0.004  0.003  0.692                     
    ## PttrnTyprdl -0.443  0.033 -0.005 -0.010  0.449  0.033              
    ## Coh:Speed    0.576  0.014 -0.002 -0.004 -0.733 -0.890 -0.022       
    ## Ch:PttrnTyp  0.372 -0.011 -0.004  0.011 -0.463 -0.028 -0.890  0.028

Is age needed?

``` r
anova(mod.age.main, mod.drop.three.way)
```

    ## Data: df
    ## Models:
    ## mod.drop.three.way: Acc ~ Coh + Speed + PatternType + Coh:Speed + Coh:PatternType + 
    ## mod.drop.three.way:     (1 | SubID)
    ## mod.age.main: Acc ~ AgeYrs + Coh + Speed + PatternType + (1 | SubID) + Coh:Speed + 
    ## mod.age.main:     Coh:PatternType
    ##                    Df    AIC    BIC  logLik deviance  Chisq Chi Df
    ## mod.drop.three.way  7 5628.1 5678.0 -2807.0   5614.1              
    ## mod.age.main       10 5609.3 5680.6 -2794.6   5589.3 24.783      3
    ##                    Pr(>Chisq)    
    ## mod.drop.three.way               
    ## mod.age.main        1.714e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Yes, the goodness of fit dropped substantially $^2(3)=$24.783, *p*=1.7x10<sup>−5</sup> in comparing the model without `AgeYrs` to the model that includes it.

Copy figure files
-----------------
