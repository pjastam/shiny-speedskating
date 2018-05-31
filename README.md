# Speed skating app for talent scouting & development

> *Copyright 2017 [Piet Stam](http://www.pietstam.nl). Licensed under the GNU
> Lesser General Public License v3.0. The README.md documentation is licensed
> under the Creative Commons [Attribution-ShareAlike 4.0 International-license](http://creativecommons.org/licenses/by-sa/4.0/).*

## Table of contents

  - [What is this repository for?](#goal)
  - [Demo](#demo)
  - [Installation](#install)
  - [Ideas for improvement](#new-ideas)
  - [Who do you talk to?](#contact)

<h2 id="goal">What is this repository for?</h2>

### Quick summary
`shiny-speedskating` constitutes the front-end of an app for talent scouting &development of junior speed skaters. [Speed skating](https://en.wikipedia.org/wiki/Speed_skating) is a popular winter sport in [the Netherlands](https://en.wikipedia.org/wiki/Netherlands).

### Version
1.0

### Motivation
The reason for building this app is that talent scouting & development of junior speed skaters with the potential to become a professional athlete may be hampered by a lack of strong(er) competition from their same age peers during their daily training routine. As a consequence, outperformance of these peers may not be a good indicator of the potential of a junior speed skater to become a professional. A better indicator might be the performance of professional speeds skaters during the days that they were of the same age as the junior speed skater.

### Explanation
There are two explanations why the probability of strong competition for high potential junior speed skaters is small:
1. The number of high potentials of a given age is small due to the small population size of the Netherlands.
2. The junior speed skaters are assigned to a number of training facilities which are distributed across the country. Thus, within each training facility, the number of junior speed skaters with the potential of a professional career is even smaller.

### How does this app help?
As explained above, the probability of strong competition heavily depends on the year of birth and place of residence (and therefore, assignment to a specific training district) of a high potential. Obviously, one step towards better talent development is to pool and monitor the results of junior speed skaters of a given age across all training districts. A further step would be to make comparisons across generations of high potential speed skaters by adjusting the track times for birth date differences. Although both kinds of comparison are facilitated by the 'shiny-speedskating' app, the true added value of this app derives from facilitating the across generations comparison.

More specifically, the 'shiny-speedskating' app graphs the best monthly track times of junior speed skaters and the best monthly track times of professional speed skaters, after adjusting for the difference in dates of birth. We chose to use best monthly track times (instead of daily track times) in order to reduce the influence of statistical coincidence (alternatively, one might choose for average monthly track times). Note that as we adjust for date of birth instead of year of birth, we also take account of differences in development among speed skaters within the same year of birth.

The 'shiny-speedskating' app generates a benchmark for observed track times of junior speed skaters. A junior speed skater performs well if these observed track times are equal to or better than that of the profession speed skater in his/her younger years. This kind of comparison is useful both for talent scouting. In addition, the graph of the professional speed skater may serve as a reference career path to the junior speed skater, as the graph also depicts the track times of the professional speed skater at later ages than that of the junior speed skater. In this way, the app can be used for future career development of high potential junior speed skaters too. Thus the app can be used both for talent scouting and talent development.

### Data sources

  - The track times of the junior and professional speed skaters used in the demo of this app are provided by [SpeedskatingResults.com](http://speedskatingresults.com/) via their Public API.
  - For the demo app we made a selection of junior speed skaters from the population of junior speed skating champions in 2017 and before. This population can be found at [Wikipedia](https://nl.wikipedia.org/wiki/Nederlandse_kampioenschappen_schaatsen_junioren) (in Dutch).
  - For the demo app we selected three professional speed skaters, their dates of birth can be found at Wikipedia: [Patrick Roest](https://nl.wikipedia.org/wiki/Patrick_Roest), [Kay Verbij](https://nl.wikipedia.org/wiki/Kai_Verbij), and [Hein Otterspeer](https://nl.wikipedia.org/wiki/Hein_Otterspeer). Note that we chose relatively young speed skating professionals in this case, because the track times  of the elderly professionals in their younger years were not available as open data.

<h2 id="demo">Demo</h2>

[Click here](https://pjastam.shinyapps.io/speedskating/) to view an interactive demo of `shiny-speedskating`. You can choose a junior speed skater in the first select box and a professional speed skater in the second select box. The input checkbox is checked by default, in which case the difference in birth dates between these two speedskaters is adjusted for. The graph is redrawn each time one of these three choices is altered.

We used a small sample of data to illustrate the workings of this app. Note that we chose relatively young professional speed skaters for this demo, because the track times of the elderly professionals in their younger years were not available as open data to the best of our knowledge.

<h2 id="install">Installation</h2>

<h3>R and RStudio IDE</h3>
The `shiny-speedskating` demo app is available through [GitHub](https://github.com/). To install the latest development version from my [GitHub](https://github.com/pjastam/shiny-speedskating) repository in your R or RStudio IDE:

``` r
install_github("pjastam/shiny-speedskating")
```

<h3>Shiny server</h3>
If you want to install the `shiny-speedskating` demo app at a Shiny server, you can retrieve the code from GitHub:

``` r
git clone https://github.com/pjastam/shiny-speedskating.git
```

<h3>Docker</h3>

If you want to build a Docker image yourself and run it in a container, just fire up your Linux terminal and enter the following commands:

``` r
cd /srv/shinyapps/
git clone https://github.com/pjastam/shiny-speedskating.git
cd /srv/shinyapps/shiny-speedskating
docker build -t pjastam/shiny-speedskating:latest .
docker run -d -p 80:3838 --name speedskating pjastam/shiny-speedskating:latest
```

Now go to your webbrowser and enter the IP address of your server to verify that the `shiny-speedskating` demo app is running. Note that a prerequisite to this workflow is that Docker must be installed at your server.

<h3>Docker Hub</h3>

You might prefer the easiest way to run the `shiny-speedskating` demo app in a Docker container. To this end, I pushed a ready-to-use image to [Docker Hub](https://hub.docker.com/) which you can find [here](https://hub.docker.com/r/pjastam/shiny-speedskating/). Enter the following commands in your Linux terminal and your done:

``` r
docker pull pjastam/shiny-speedskating
docker run -d -p 80:3838 --name speedskating pjastam/shiny-speedskating:latest
```

Now go to your webbrowser and enter the IP address of your server to verify that the `shiny-speedskating` demo app is running. Note that a prerequisite to this workflow is that Docker must be installed at your server.

<h2 id="new-ideas">Ideas for improvement</h2>

This app can be further developed in lots of different ways. To name a few:

  - Track times are adjusted for difference in birth dates, but they may be influenced by other factors too. Think of location of the speed skating event, the trainer/coach/team of the speed skater or personal traits of individual speed skaters (gender, length, etc.). The exact influence of each of these so-called confounders can be determined by the estimation of an econometric model. The resulting parameter estimates can then be used in the app and result in additional checkboxes which can be checked. Note that this kind of analysis would require much more data sources and a trained econometrician/statistician/epidemiologist to choose the right prediction model setup and apply the appropriate technique to estimate the model parameters.
  - The data are loaded into the app in a static way. To load more recent data interactively from the data sources into the app, a backend functionality to this Shiny app is needed. We developed a first version, but this one is not efficient enough and should be developed as a separate backend development project.
  
Please feel free to contact me if you would like to contribute in either of these ways.

<h2 id="contact">Who do you talk to?</h2>

You can contact me at my GitHub email address if you would like to share your thoughts on this app.