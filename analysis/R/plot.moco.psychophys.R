plot.moco.psychophys <- function(df, resp_var='p.corr', show_title=TRUE) {
# plot.moco.psychophys <- function(df, resp_var='p.corr', show_title=TRUE)
#   creates summary plots for adult MOCO psychophysics data

  theme.adamiak <- theme(plot.title = element_text(size=18, face="bold"),
                         axis.title.x = element_text(size=18),
                         axis.title.y = element_text(size=18),
                         strip.text = element_text(size=16),
                         axis.text = element_text(size=14)
  )
  
  if (resp_var == 'p.corr') {
    y_lbl <- 'p(corr)'
    title_text <- 'p(corr) by Coherence, Pattern, and Speed'
    p <- ggplot(data=df, aes(x=as.factor(Coh), y=corr/nsamples)) 
  } else if (resp_var == 'rt') {
    y_lbl <- 'RT (s)'
    title_text <- 'RT by Coherence, Pattern, and Speed'
    p <- ggplot(data=df, aes(x=as.factor(Coh), y=rt.mean))
  } else {
    warning('resp_var invalid; using default.')
    y_lbl <- 'p(corr)'
    title_text <- 'p(corr) by Coherence, Pattern, and Speed'
    p <- ggplot(data=df, aes(x=as.factor(Coh), y=corr/nsamples))
  }
  
  # Plot for all subs
  p <- p + 
    geom_point(aes(color=as.factor(ParticipantID))) + 
    geom_smooth(aes(color=as.factor(ParticipantID), 
                    group=ParticipantID), 
                linetype="dashed", 
                method="lm", 
                formula=y~poly(x,2), se=F) +
    geom_smooth(aes(group=1), 
                method="lm", 
                size=2, 
                color="white", 
                formula = y ~ poly(x,2)) +
    facet_grid(facets = DegPSec ~ PatternType) +
    labs(x="Coherence", y=y_lbl) +
    guides(color = FALSE) + # suppress legend
    theme.adamiak
  
  if (show_title) {
    p + ggtitle(title_text)
  } else {
    p    
  }
}