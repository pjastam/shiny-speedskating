#############################################################
### EXAMPLE CODE TO PROGRAMATICALLY 
### - CREATE A DIGITAL OCEAN (DO) CLOUD SERVER AND
### - DEPLOY YOUR DOCKER APP 
### USING THE ANALOGSEA PACKAGE
#############################################################
  
# Make connection to DO account -------------------------------------------

#install.packages("analogsea")
library(analogsea)

# Test your DO connection
analogsea::droplets()
# You are redirected to log into your DO account and authorize analoguesea
# If successful, you can now send the deployment commands to DO


# Create a Docker droplet -------------------------------------------------

# Do not forget to delete it with droplet_delete() when you're done
d <- docklet_create(name = "test1",
#                    size = "512mb",
                    region = "ams3")
d <- droplet(d$id)
d


# Put OpenSSH private key in local directory ------------------------------

# The public portion of the standard SSH key is automatically deployed
# on the new server upon creation. This holds under the assumption that
# you already have a public/private key pair stored in your DO account.
# Otherwise, you have to create such a key pair yet.

# Now you have to make sure that the private portion of this standard key is
# stored in your local folder. Next, set the location of this folder in the
# loc_keyfile variable below.

# Note that the analogsea package assumes OpenSHH private key files. Therefore,
# convert your private key file to the OpenSSH format if yours has a Putty
# Private Key (.ppk) format. Use PuTTYgen to do this conversion.

#install.packages("ssh")
#library(ssh)

# Download the image from Docker Hub --------------------------------------

# Spin up a Shiny server with an app (opens in default browser)
path <- system.file("examples", "widgets", package = "analogsea")
d %>% docklet_shinyapp(path)

## uploading more apps - use droplet_upload, then navigate in browser
### if you try to use docklet_shinyapp again on the same droplet, it will error
path2 <- system.file("examples", "mpg", package = "analogsea")
d %>% droplet_upload(path2, "/srv/shinyapps") # then go to browser

##Now, try uploading my own app
#path3 <- "C:/Users/pjast/OneDrive/Dev/GitHub/shiny-speedskating/app"
#d %>% droplet_upload(path3, "/srv/shinyapps/shiny-speedskating/")
path3 <- system.file("examples", "shiny-speedskating", package = "analogsea")
d %>% droplet_upload(path3, "/srv/shinyapps")

# Check the list of containers after escaping ------------------------------------

d %>% docklet_ps()

# Stop containers running -------------------------------------------------

d %>% docklet_stop(container = c(
  "34e304af9eda"
))


# Remove inactive containers ----------------------------------------------

d %>% docklet_rm(container = c(
  "34e304af9eda"
))


# Delete the droplet alltogether ----------------------------------------

d %>% droplet_delete()


# References --------------------------------------------------------------

# - Analogsea package: https://github.com/sckott/analogsea
# - Example guide for deploying Plumber API to a DO droplet: https://www.rplumber.io/articles/hosting.html#digitalocean-1
# - Quickstart to connect to DO droplets: https://www.digitalocean.com/docs/droplets/quickstart/
# - How to set up new SSH key pairs: https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
# - Which SSH keys are in your DO account: go to Settings > Security > SSH Keys
# - SSH client for R: https://cran.rstudio.com/web/packages/ssh/vignettes/intro.html
