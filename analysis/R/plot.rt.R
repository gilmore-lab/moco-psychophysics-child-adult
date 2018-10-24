plot.rt <- function(df){
  # Plot theme, customizations
  theme.custom <- theme(plot.title = element_text(size=16, face="bold"),
                        axis.title.x = element_text(size=14),
                        axis.title.y = element_text(size=14),
                        strip.text = element_text(size=14),
                        axis.text = element_text(size=12),
                        legend.position="bottom", 
                        legend.title=element_blank())
  
  y_lbl <- 'RT (s)'
  title_text <- 'RT by Coherence, Pattern, and Speed'
  df$Speed <- factor(df$Speed, labels = c("2 deg/s", "8 deg/s"))
  
  # Plot for all subs
  p <- ggplot(data=df, aes(x=Coh, y=RT.mean))
  p <- p + 
    geom_line(aes(group=SubID, color=AgeYrs)) +
    facet_grid(facets = Speed ~ PatternType) +
    labs(x="Coherence", y=y_lbl) +
    ggtitle(title_text) +
    theme_bw() +
    theme.custom +
    xlim(0, 1)
  p    
}
