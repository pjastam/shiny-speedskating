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
                    size = "512mb",
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

loc_keyfile = "C:\\Users\\USERNAME\\.ssh\\private.key"

# Download the image from Docker Hub --------------------------------------

d %>% docklet_pull(repo = "pjastam/shiny-speedskating:latest",
                   ssh_user = "root",
                   keyfile = loc_keyfile)

d %>% docklet_images()


# Run the Docker image ----------------------------------------------------

d %>% docklet_run(
  repo = "-d -p 80:80 pjastam/shiny-speedskating",
  rm = "TRUE",
  ssh_user = "root",
  keyfile = loc_keyfile
)


# Check the list of containers after escaping ------------------------------------

d %>% docklet_ps(all = TRUE)

# Stop containers running -------------------------------------------------

d %>% docklet_stop(container = c(
  "6730ccbe8532"
))


# Remove inactive containers ----------------------------------------------

d %>% docklet_rm("6730ccbe8532")

# Delete the droplet alltogether ----------------------------------------

d %>% droplet_delete()


# References --------------------------------------------------------------

# - Analogsea package: https://github.com/sckott/analogsea
# - Example guide for deploying Plumber API to a DO droplet: https://www.rplumber.io/articles/hosting.html#digitalocean-1
# - Quickstart to connect to DO droplets: https://www.digitalocean.com/docs/droplets/quickstart/
# - How to set up new SSH key pairs: https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
# - Which SSH keys are in your DO account: go to Settings > Security > SSH Keys
# - SSH client for R: https://cran.rstudio.com/web/packages/ssh/vignettes/intro.html
