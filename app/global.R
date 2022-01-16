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
myfiles <- tools::file_path_sans_ext(list.files(path="data/", pattern="skater_*.*", full.names=FALSE))
for (i in seq_along(myfiles)) {
  assign(myfiles[i],readRDS(file = paste0("data/", myfiles[i], ".rds")))
}
