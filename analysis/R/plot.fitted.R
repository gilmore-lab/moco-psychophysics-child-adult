# script fragment to illustrate plotting fitted model

df.moco$P.Corr.fit <- NA
df.moco$P.Corr.fit[ !is.na( df.moco$Acc ) ] <- fitted( glm3.moco )
tbl.moco <- tbl_df( df.moco )
tbl.p.corr <- tbl.moco %>%
  group_by( PatternType, Coh, ParticipantID, P.Corr.fit ) %>%
  filter( !is.na(Acc) ) %>%
  summarise( P.Corr=mean( Acc, na.rm=TRUE ) )

pl <- ggplot( data=tbl.p.corr, aes( x=Coh, y=P.Corr, color=ParticipantID ) )
