# Speed skating talent management app

> *Copyright 2017 [Piet Stam](http://www.pietstam.nl). Licensed under
> the GNU Lesser General Public License v3.0.*

## Table of contents

  - [What is this repository for?](#goal)
  - [Demo](#demo)
  - [Installation](#install)
  - [How to use](#usage)
  - [Ideas for improvement](#new-ideas)
  - [Who do you talk to?](#contact)

<h2 id="goal">What is this repository for?</h2>

### Quick summary
`shiny-speedskating` constitutes the front-end of an app for talent management by scouts, trainers and coaches of speed skating teams. [Speed skating](https://en.wikipedia.org/wiki/Speed_skating) is a popular winter sport in [the Netherlands](https://en.wikipedia.org/wiki/Netherlands).

### Version
1.0

### Motivation
The reason for building this app is that talent management of junior speed skaters with the potential to become a professional athlete may be hampered by a lack of strong(er) competition from their same age peers during their daily training routine. As a consequence, outperformance of these peers may not be a good indicator of the potential of a junior speed skater to become a professional. A better indicator might be the performance of professional speeds skaters during the days that they were of the same age as the junior speed skater.

### Explanation
There are two explanations why the probability of strong competition for high potential junior speed skaters is small:
1. The number of high potentials of a given age is small due to the small population size of the Netherlands.
2. The junior speed skaters are assigned to a number of training facilities which are distributed across the country. Thus, within each training facility, the number of junior speed skaters with the potential of a professional career is even smaller.

### How does this app help?
As explained above, the probability of strong competition heavily depends on the year of birth and place of residence (and therefore, assignment to a specific training district) of a high potential. Obviously, one step towards better talent management is to pool and monitor the results of junior speed skaters of a given age across all training districts. A further step would be to make comparisons across generations of high potential speed skaters. Although both kinds of comparison are facilitated by the 'shiny-speedskating' app, the true added value of this app derives from facilitating the across generations comparison.

More specifically, the 'shiny-speedskating' app graphs the best monthly track times of junior speed skaters and the best monthly track times of professional speed skaters, thereby adjusting for the difference in dates of birth. We chose to use best monthly track times in order to reduce the influence of statistical coincidence (alternatively, one might choose for average monthly track times). Note that as we adjust for date of birth instead of year of birth, we also take account of differences in development among speed skaters within the same year of birth.

The 'shiny-speedskating' app generates a benchmark for current track times of junior speed skaters. But in addition it can also be used as a reference career path in terms of future track times. The reason is that the track times of the professional speed skaters at later ages and during their professional career are also graphed with this app. In this way, more recent track times of professional speed skaters can be used for the career development of high potential junior speed skaters too.

### Data sources

  - The track times of the junior and professional speed skaters used in the demo of this app are provided by [SpeedskatingResults.com](http://speedskatingresults.com/) via their Public API.
  - For the demo app we made a selection of junior speed skaters from the population of junior speed skating champions in 2017 and before. This population can be found at [Wikipedia](https://nl.wikipedia.org/wiki/Nederlandse_kampioenschappen_schaatsen_junioren) (in Dutch).
  - For the demo app we selected three professional speed skaters, their dates of birth can be found at Wikipedia: [Patrick Roest](https://nl.wikipedia.org/wiki/Patrick_Roest), [Kay Verbij](https://nl.wikipedia.org/wiki/Kai_Verbij), and [Hein Otterspeer](https://nl.wikipedia.org/wiki/Hein_Otterspeer). Note that we chose relatively young speed skating professionals in this case, because the track times  of the elderly professionals in their younger years were not available as open data.

<h2 id="demo">Demo</h2>

[Click here](https://pjastam.shinyapps.io/speedskating/) to view an interactive demo of `shiny-speedskating`.

<h2 id="install">Installation</h2>

The `shiny-speedskating` demo app is available through [Bitbucket](http://bitbucket.org/). To install the latest development version from Bitbucket in your R or RStudio IDE:

``` r
install.packages("devtools")
devtools::install_bitbucket("stamonline/shiny-speedskating")
```

<h2 id="usage">How to use</h2>

Choose a junior speed skater in the first select box and a professional speed skater in the second select box.

The input checkbox is checked by default, in which case the difference in birth dates between these two speedskaters is adjusted for.

The graph is redrawn each time one of these three choices is altered.

<h2 id="new-ideas">Ideas for improvement</h2>

This app can be further developed in lots of different ways. To name a few:

  - Track times are adjusted for difference in birth dates, but they may be influenced by other factors too. Think of location of the speed skating event, the trainer/coach/team of the speed skater or personal traits of individual speed skaters (gender, length, etc.). The exact influence of each of these so-called confounders can be determined by the estimation of an econometric model. The resulting parameter estimates can then be used in the app and result in additional checkboxes which can be checked. Note that this kind of analysis would require much more data sources and a trained econometrician/statistician/epidemiologist to choose the right prediction model setup and apply the appropriate technique to estimate the model parameters.
  - The data are loaded into the app in a static way. To load more recent data interactively from the data sources into the app, a backend functionality to this Shiny app is needed. We developed a first version, but this one is not efficient enough and should be developed as a separate backend development project.
  
Please feel free to contact me if you would like to contribute in either of these ways.

<h2 id="contact">Who do you talk to?</h2>

You can contact me at my GitHub email address if you would like to share your thoughts on this app.
