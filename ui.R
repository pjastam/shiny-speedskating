# ui.R

shinyUI(fluidPage(
  
  sidebarLayout(
    sidebarPanel(
      helpText("The graph shows the best monthly track times of junior speed skaters compared to those of professional speed skaters, adjusted for the difference in dates of birth."),
      
      selectInput("junior", "Choose your junior ice skater", with(skaters_id, split(id,name)), selected = "35474"),
      
      selectInput("senior", "Choose your senior ice skater", with(skaters_id, split(id,name)), selected = "14920"),
      
      checkboxInput("adjust", 'Adjust for difference in birth dates', TRUE),
      
      selectInput("distance", 
                  label = "Choose a distance",
                  choices = list(500, 1000, 1500, 3000),
                  selected = 500),
      
      tags$div(em('You can find the source code of this demo app',
      tags$a(href="https://github.com/pjastam/shiny-speedskating", "here!")))
    ),
    
    mainPanel(
      withSpinner(plotOutput("timesPlot"),5, color="#c0c0c0")
    )

  )
))