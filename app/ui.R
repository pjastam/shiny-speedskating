# ui.R

shinyUI(fluidPage(

  sidebarLayout(
    sidebarPanel(
      helpText("This graph compares the best monthly track times of speed skaters whose names are at the ", tags$a(href="https://www.pyeongchang2018.com/en/game-time/results/OWG2018/en/speed-skating/entries-by-event-men-s-1000m.htm", "Men's 1000m Entry List"), "of the ", tags$a(href="https://www.olympic.org/pyeongchang-2018", "Olympic Games in 2018"), ". As we want to help you find the speed skaters who have the potential to win this race, the graphed paths are unadjusted for the difference in dates of birth by default. However, if you would like to scout the youngest high potential for future wins in the scene, you should check the box below to adjust for age differences."),

      selectInput("junior", "Choose your first speed skater", with(skaters_id, split(id,name)), selected = "6588"),

      selectInput("senior", "Choose your second speed skater", with(skaters_id, split(id,name)), selected = "2096"),

      checkboxInput("adjust", 'Adjust for difference in birth dates', FALSE),

      selectInput("distance",
                  label = "Choose a distance",
                  choices = list(1000),
                  selected = 1000),

      tags$div(em('This app is derived from the original demo app which you can find', tags$a(href="https://pjastam.shinyapps.io/speedskating/", "here"), '. You can find the source code and further explanation on the use of this original demo app ',
      tags$a(href="https://github.com/pjastam/shiny-speedskating", "here!")))
    ),

    mainPanel(
      plotOutput("timesPlot")
    )

  )
))
