distance <- "500"
db <- rbind(skater_35474_500, skater_14920_500)
title <- paste0("Performance analysis ",skaters_id[skaters_id["id"] == 35474][2]," vs ",skaters_id[skaters_id["id"] == 14920][2]," (", distance," meter)")
subtitle = "Data source: speedskatingresults.com, adjusted for difference in birth dates"
set_of_breaks <- as.numeric(c(35474, 14920))
set_of_labels <- as.character(c("Jesse Stam", "Patrick Roest"))

library(plotly)

fig <- plot_ly(
  x = db$times.date,
  y = strftime(db$times.time, format="%M:%S"),
  type = 'scatter',
  mode = 'lines',
  transforms = list(
    list(
      type = 'groupby',
      groups = db$skater,
      styles = list(
        list(target = 35474, value = list(line =list(color = 'black'))),
        list(target = 14920, value = list(line =list(color = 'red')))
      )
    )
  )
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
         legend = list(x = 0.1, y = 0.9),
         font=list(
           family = "Old Standard TT, serif",
           size = 14,
           color = "RebeccaPurple"
         ))

fig