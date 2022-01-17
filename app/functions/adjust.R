adjust <- function(data, adjustment) {
  data["times.date"] <- data["times.date"] + as.numeric(adjustment)
  data
}