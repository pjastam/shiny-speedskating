f_plot_times <- function(db,title,set_of_breaks,set_of_labels) {
  db$skater <- as.factor(db$skater)

  plot.title = title  
  plot.subtitle = "Data source: speedskatingresults.com, adjusted for difference in birth dates"
  
  library(grid)
  my_grob = grobTree(textGrob("Piet Stam (c) 2017", x=0.1,  y=0.95, hjust=0,
                              gp=gpar(col="grey", fontsize=10, fontface="italic")))
  
  library(ggplot2)
  pl <- ggplot(data=db,aes(x=times.date, y=as.POSIXct(times.time), group=skater, colour=skater)) +
    ggtitle(bquote(atop(.(plot.title), atop(italic(.(plot.subtitle)), "")))) +
    labs(x = "", y = "Best monthly track times") +
    geom_step(size=.5) +
    scale_y_datetime(date_labels = "%M:%S") +
    theme(plot.title = element_text(size = 20, lineheight=.8, face="bold", color="black"),  
          axis.title.x = element_text(size = 12, colour = "black"),  
          axis.title.y = element_text(size = 12, colour = "black")) +
    theme(axis.text.x=element_text(colour="black")) +
    theme(axis.text.y=element_text(colour="black")) +
    theme(legend.position = c(.8, .8)) + 
    theme(legend.title = element_text(colour="grey", size=12, face="bold")) +
    theme(legend.text = element_text(colour="grey", size=12, face="bold")) +
    theme(plot.background=element_rect(fill="#FFFFFF")) +
    scale_colour_discrete(name="Speedskaters",
                          breaks=set_of_breaks,
                          labels=set_of_labels) +
    annotation_custom(my_grob)
  
  return(pl)
}
