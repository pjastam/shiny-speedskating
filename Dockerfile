FROM rocker/shiny

MAINTAINER Piet Stam "pjastam@gmail.com"

# install R package dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
	ggplot2 \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Assume shiny app is in main dir of Github repository
COPY global.R /srv/shiny-server/shiny-speedskating/
COPY server.R /srv/shiny-server/shiny-speedskating/
COPY ui.R /srv/shiny-server/shiny-speedskating/
COPY ./data /srv/shiny-server/shiny-speedskating/data/
COPY ./functions /srv/shiny-server/shiny-speedskating/functions/

## updated config file
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf
