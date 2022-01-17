#############################################################
### EXAMPLE CODE TO PROGRAMATICALLY 
### - CREATE A DIGITAL OCEAN (DO) CLOUD SERVER AND
### - DEPLOY YOUR DOCKER APP 
### USING THE ANALOGSEA PACKAGE
#############################################################
  
# Initialize names -------------------------------------------------------

# Set the path to your app

your_path <- paste0(dirname(rstudioapi::getSourceEditorContext()$path), "/app")

# Just choose some names that you like for stuff at the server

your_droplet_name <- "test-droplet" # this name will appear in your DO list of droplets

# Make connection to DO account -------------------------------------------

#install.packages("ssh")
#install.packages("analogsea")
library(ssh)
library(analogsea)

# Test your DO connection
analogsea::droplets()
# You are redirected to log into your DO account and authorize analoguesea
# If successful, you can now send the deployment commands to DO


# Create a Docker droplet -------------------------------------------------

# Do not forget to delete it with droplet_delete() when you're done
d <- docklet_create(name = your_droplet_name,
                    size = "s-1vcpu-1gb",
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

# Note that the analogsea package assumes OpenSHH private key files. 
# This is detailed in the help menu of ssh_connect (package: ssh).  
# If you open your private key file in a text editor, the first line 
# must be: -----BEGIN RSA PRIVATE KEY-----.
#
# To convert a Putty key (.ppk format), open it in the PuttyGen utility
# and go to Conversions -> Export OpenSSH.

#loc_keyfile = "C:\\Users\\USERNAME\\.ssh\\private.key"

# Spin up a Shiny server with an app (opens in default browser) -----------

##########################################################################
### SSH ISSUES: 
### - https://github.com/ropensci/ssh/issues/24 ###
### - https://github.com/pachadotdev/analogsea/blob/master/R/docklet.R
##########################################################################

d %>% docklet_shinyapp(your_path)

# Install the necessary R packages on the Docker droplet ------------------
# First, get the container ID

d %>% docklet_ps()

#Insert the container ID in the droplet_ssh commands below
droplet_ssh(d, paste0("docker exec 34e304af9eda R -e 'install.packages(\"shinycssloaders\")'"))
droplet_ssh(d, paste0("docker exec 34e304af9eda R -e 'install.packages(\"ggplot2\")'"))

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
