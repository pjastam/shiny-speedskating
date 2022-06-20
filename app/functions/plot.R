f_plot_times <- function(db1,db2,title) {
#  db$skater <- as.factor(db$skater)

plot.title = title  
plot.subtitle = "Data source: speedskatingresults.com, adjusted for difference in birth dates"
  
#  library(grid)
#  my_grob = grobTree(textGrob("Piet Stam (c) 2017", x=0.1,  y=0.95, hjust=0,
#                              gp=gpar(col="grey", fontsize=10, fontface="italic")))
  
library(plotly)
pl <- plot_ly(
  type='scatter',
  mode='line',
  x=db1$times.date,
  y=strftime(db1$times.time, format="%M:%S"),
  name=skaters_id[skaters_id["id"] == db1$skater[1]][2]
)

pl <- pl %>% add_trace(
  type='scatter',
  mode='line',
  x=db2$times.date,
  y=strftime(db2$times.time, format="%M:%S"),
  name=skaters_id[skaters_id["id"] == db2$skater[1]][2]
  ) 

pl <- pl %>% 
  layout(title = paste0(plot.title,"<BR>",plot.subtitle),
         xaxis = list(title = ""),
         yaxis = list(title = "Best monthly track times"),
         legend=list(title=list(text='<b> Speed skaters </b>'), x = 0.8, y = 0.8)
  )

pl <- pl %>% 
  layout(
    updatemenus = list(
      list(
        y = 0.8,
        buttons = list(
        
          list(method = "restyle",
               args = list("line.color", "blue"),
               label = "Blue"),
        
          list(method = "restyle",
               args = list("line.color", "red"),
               label = "Red"))),
    
      list(
        y = 0.7,
        buttons = list(
          list(method = "restyle",
               args = list("visible", list(TRUE, FALSE)),
               label = "Sin"),
        
          list(method = "restyle",
               args = list("visible", list(FALSE, TRUE)),
               label = "Cos")))
    )
  )

  return(pl)
}
