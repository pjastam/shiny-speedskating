#Load libraries
library(shiny)
library(shinycssloaders, quietly = TRUE, warn.conflicts = FALSE)

#Load subroutine to construct the graph
source("functions/plot.R")

#Load subroutine to adjust for difference in birth dates
source("functions/adjust.R")

#Load speed skaters personalia
assign("skaters_id",readRDS(file = ("data/skaters_id.rds")))

#Initialize the track distances
distance <- data.frame(distance = c(500,1000,1500,3000))

#Load the track times (for all speed skaters and all distances)
for (k in 1:nrow(distance)) {
  for (j in 1:nrow(skaters_id)) {
    assign(paste0("skater_",skaters_id[j,1], "_", distance[k,]),readRDS(file = paste0("data/", "skater_", skaters_id[j,1], "_", distance[k,], ".rds")))
  }
}
