f_plot_times <- function(db,title,set_of_breaks,set_of_labels) {
  db$skater <- as.factor(db$skater)

  plot.title = title  
  plot.subtitle = "Data source: speedskatingresults.com, adjusted for difference in birth dates"
  
  library(grid)
  my_grob = grobTree(textGrob("Piet Stam (c) 2017", x=0.1,  y=0.95, hjust=0,
                              gp=gpar(col="grey", fontsize=10, fontface="italic")))
  
  library(plotly)
  pl <- plot_ly(
    x = db$times.date,
    y = strftime(db$times.time, format="%M:%S"),
    type = 'scatter',
    mode = 'lines',
    transforms = list(
      list(
        type = 'groupby',
        groups = db$skater,
        styles = list(
          list(target = set_of_breaks[1], value = list(line =list(color = 'black'))),
          list(target = set_of_breaks[2], value = list(line =list(color = 'red')))
        )
      )
    )
  )
  
  pl <- pl %>% 
    layout(title = paste0(plot.title,"<BR>",plot.subtitle),
           xaxis = list(title = ""),
           yaxis = list(title = "Best monthly track times"))
  
  return(pl)
}
