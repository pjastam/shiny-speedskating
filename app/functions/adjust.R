adjust <- function(data, adjustment) {
  data["times.date"] <- data["times.date"] + adjustment
  data
}