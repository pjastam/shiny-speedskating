distance <- "500"
db <- rbind(skater_35474_500, skater_14920_500)
title <- paste0("Performance analysis ",skaters_id[skaters_id["id"] == 35474][2]," vs ",skaters_id[skaters_id["id"] == 14920][2]," (", distance," meter)")
subtitle = "Data source: speedskatingresults.com, adjusted for difference in birth dates"
set_of_breaks <- as.numeric(c(35474, 14920))
set_of_labels <- as.character(c("Jesse Stam", "Patrick Roest"))

library(plotly)

fig <- plot_ly(
  type='scatter',
  mode='line',
  x=skater_35474_500$times.date,
  y=strftime(skater_35474_500$times.time, format="%M:%S"),
  name=skaters_id[skaters_id["id"] == 35474][2]
)

fig <- fig %>% add_trace(
  type='scatter',
  mode='line',
  x=skater_14920_500$times.date,
  y=strftime(skater_14920_500$times.time, format="%M:%S"),
  name=skaters_id[skaters_id["id"] == 14920][2]
) 

font_yaxis <- list(
  family = "Old Standard TT, serif",
  size = 12,
  color = "lightgrey"
)
layout_xaxis <- list(
  title = ""
)
layout_yaxis <- list(
  title = "Best monthly track times",
  titlefont = font_yaxis
)

fig <- fig %>% 
  layout(title = paste0(title,"<BR>",subtitle),
         xaxis = layout_xaxis,
         yaxis = layout_yaxis,
         showlegend = TRUE,
         legend=list(title=list(text='<b> Trend </b>'), x = 0.9, y = 0.9),
         annotations=list(title=list(text='<b> Trend </b>'), x = 0.1, y = 0.9),
         font=list(
           family = "Old Standard TT, serif",
           size = 14,
           color = "RebeccaPurple"
         ))

fig
