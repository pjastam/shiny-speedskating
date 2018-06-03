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
COPY global.R /srv/shiny-server/
COPY server.R /srv/shiny-server/
COPY ui.R /srv/shiny-server/
COPY data/ /srv/shiny-server/
COPY functions/ /srv/shiny-server/

## updated config file
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf

EXPOSE 80

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]