# Set repo used for docklet_pull
repo = "pjastam/shiny-speedskating"

# Remove current analogsea package -----------------------------------
detach("package:analogsea", unload = TRUE)
remove.packages("analogsea", lib="~/R/win-library/3.6")

# Install return-data branch in analogsea
remotes::install_github("sckott/analogsea@return-data")

# Restart R
# Note: exit Rstudio and be sure to close all sessions

# Use library
library(analogsea)

analogsea::droplets()

# Create a Docker droplet -------------------------------------------------

d <- docklet_create(name = "test1",
                    size = "512mb",
                    region = "ams3")
d <- droplet(d$id)

#loc_keyfile = "C:\\Users\\USERNAME\\.ssh\\private.key"

d %>% docklet_run(
  repo = "-d -p 80:80 pjastam/shiny-speedskating",
  rm = "TRUE",
  ssh_user = "root",
  keyfile = loc_keyfile
)

# Check the list of containers after escaping ------------------------------------

d %>% docklet_ps(all = TRUE)

# COde to get the container_id ---------------------------------------

container_id <- d %>% droplet_ssh_data("docker ps --format 'table{{.ID}},{{.Image}},{{.Names}}'")

# Convert to dataframe
# Source: https://stackoverflow.com/questions/2391364/converting-multiple-lines-of-text-into-a-data-frame

#tmp2<-read.delim(textConnection(tmp),header=TRUE,sep=" ",strip.white=TRUE)

# TEST

#tmp3 <- "CONTAINER ID, IMAGE\n12345678, pjastam/speedskating\n"
#tmp4<-read.table(text = tmp3,header=TRUE,sep=",",strip.white=TRUE)

container_id <- read.table(text = container_id, header = TRUE, sep = ",", stringsAsFactors = FALSE) %>%
  dplyr::filter(IMAGE == repo) %>%
  dplyr::pull(CONTAINER.ID)

# Voorbeeld van toepassing
d %>% docklet_stop(container_id)

# Add the colnames
#colnames(df) <- c("ID", "Image", "Names")
# And take a look at the result
#df

# Convert to dataframe, take care of multiple spaces
# Source: https://stackoverflow.com/questions/16979858/reading-text-file-with-multiple-space-as-delimiter-in-r

#data <- read.table(textConnection(tmp), sep = "" , header = F , nrows = 100,
#                   na.strings ="", stringsAsFactors= F)
#data <- read.table(file, sep = "" , header = F , nrows = 100,
#                   na.strings ="", stringsAsFactors= F)

# Delete the droplet alltogether ----------------------------------------

d %>% droplet_delete()
