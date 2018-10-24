plot.p.corr.by.age.yrs <- function(df){
  theme.moco.plot <- theme(plot.title = element_text(size=18, face="bold"),
                           axis.title.x = element_text(size=18),
                           axis.title.y = element_text(size=18),
                           strip.text = element_text(size=16),
                           axis.text = element_text(size=12)
  )
  
  y_lbl <- 'p(corr)'
  title_text <- 'p(corr) by Coherence, Pattern, and Speed'
  p <- ggplot(data=df, aes(x=Coh, y=Pct.Corr)) 
  
  # Plot for all subs
  p <- p + 
    geom_line() + 
    # geom_smooth(aes(color=as.factor(AgeYrs), 
    #                 group=as.factor(AgeYrs)), se=FALSE) +
    # geom_smooth(aes(group=1), 
    #             method="lm", 
    #             size=2, 
    #             color="white", 
    #             formula = y ~ poly(x,2), se=T) +
    facet_grid(facets = Speed ~ PatternType) +
    labs(x="Coherence", y=y_lbl) +
    #guides(color = FALSE) + # suppress legend
    theme.moco.plot + 
    ggtitle(title_text) +
    theme(legend.position="bottom", legend.title=element_blank()) +
    xlim(0, .8) +
    ylim(.5, 1.1)
  p
}
