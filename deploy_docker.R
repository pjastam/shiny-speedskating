#############################################################
### EXAMPLE CODE TO PROGRAMATICALLY 
### - CREATE A DIGITAL OCEAN (DO) CLOUD SERVER
### - GET THE IMAGE FROM DOCKER HUB AND
### - DEPLOY AND RUN YOUR DOCKER APP
### USING THE ANALOGSEA PACKAGE
#############################################################

# Initialize names -------------------------------------------------------

# Copy the image name from hub.docker.com

your_repo_name <- "pjastam/shiny-speedskating:latest"

# Set names stored at your client

your_client_username <- "test-username" # one of the subdirs of C:\Users at a Windows client 
your_client_keyname <- "test-keyname" # the name of the private key at your client

# Just choose some names that you like for stuff at the server

your_droplet_name <- "test-droplet" # this name will appear in your DO list of droplets
your_container_name <- "test-container"

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

# Note that the analogsea package assumes OpenSHH private key files. Therefore,
# convert your private key file to the OpenSSH format if yours has a Putty
# Private Key (.ppk) format. Use PuTTYgen to do this conversion.

loc_keyfile = paste0("C:/Users/", your_client_username, "/.ssh/", your_client_keyname)

# Download the image from Docker Hub --------------------------------------

d %>% docklet_pull(repo = your_repo_name,
                   ssh_user = "root",
                   keyfile = loc_keyfile)

d %>% docklet_images()

# Run the Docker image ----------------------------------------------------

d %>% docklet_run(
  name = your_container_name,
  repo = paste("-d -p 80:80", your_repo_name),
  rm = "TRUE",
  ssh_user = "root",
  keyfile = loc_keyfile
)

# Check the list of containers after escaping ------------------------------------

d %>% docklet_ps(all = TRUE)

# Stop containers running -------------------------------------------------

d %>% docklet_stop(container = your_container_name)

# Remove inactive containers ----------------------------------------------

#d %>% docklet_rm(container = your_container_name) # cmd not useful if rm = "TRUE" in docklet_run 

# Delete the droplet alltogether ----------------------------------------

d %>% droplet_delete()

# References --------------------------------------------------------------

# - Analogsea package: https://github.com/sckott/analogsea
# - Example guide for deploying Plumber API to a DO droplet: https://www.rplumber.io/articles/hosting.html#digitalocean-1
# - Quickstart to connect to DO droplets: https://www.digitalocean.com/docs/droplets/quickstart/
# - How to set up new SSH key pairs: https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
# - Which SSH keys are in your DO account: go to Settings > Security > SSH Keys
# - SSH client for R: https://cran.rstudio.com/web/packages/ssh/vignettes/intro.html
