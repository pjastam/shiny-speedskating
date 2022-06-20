FROM rocker/shiny

LABEL org.opencontainers.image.authors="Piet Stam <pjastam@gmail.com>"

# install R package dependencies
RUN apt-get update && apt-get install -y \
    libssl-dev \
    ## clean up
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/* \ 
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
## Install packages from CRAN
RUN install2.r --error \ 
    -r 'http://cran.rstudio.com' \
	ggplot2 \
	shinycssloaders \
    ## clean up
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

## Assume shiny app is in *sub* folder of Github repository
COPY app /srv/shiny-server

## updated config file
COPY shiny-server.conf  /etc/shiny-server/shiny-server.conf

EXPOSE 80

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
