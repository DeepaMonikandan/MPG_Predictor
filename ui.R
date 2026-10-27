library(shiny)

shinyUI(fluidPage(
  titlePanel("MPG Predictor: How Thirsty Is Your Car?"),

  sidebarLayout(
    sidebarPanel(
      h4("Describe your car"),
      sliderInput("wt", "Weight (1000 lbs):",
                  min = 1.5, max = 5.5, value = 3, step = 0.1),
      radioButtons("cyl", "Number of cylinders:",
                   choices = c("4" = 4, "6" = 6, "8" = 8), selected = 4,
                   inline = TRUE),
      checkboxInput("am", "Manual transmission", value = FALSE),
      checkboxInput("show_fit", "Show regression line on plot", value = TRUE),
      helpText("Change any input and the prediction updates instantly.")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel("App",
          br(),
          h3("Predicted fuel efficiency"),
          h2(textOutput("prediction")),
          textOutput("interval"),
          br(),
          plotOutput("plot")
        ),
        tabPanel("Documentation",
          br(),
          h3("How to use this app"),
          tags$ol(
            tags$li("Open the sidebar on the left of the 'App' tab."),
            tags$li("Move the slider to set the weight of your car in thousands of pounds (for example, 3.0 means 3,000 lbs)."),
            tags$li("Pick the number of cylinders (4, 6 or 8)."),
            tags$li("Tick the box if the car has a manual transmission."),
            tags$li("Read the predicted miles per gallon (MPG) at the top of the page. A 95% prediction range is shown below it."),
            tags$li("In the plot, the red point is your car and the grey points are real cars from the dataset. Tick 'Show regression line' to see the overall trend.")
          ),
          h3("How it works"),
          p("The app fits a linear regression model on R's built-in",
            code("mtcars"), "dataset (32 cars from a 1974 magazine):",
            code("mpg ~ wt + cyl + am"),
            ". Your inputs are used as the new data point and the model predicts MPG."),
          h3("Notes"),
          tags$ul(
            tags$li("The data is old (1974), so predictions are for demonstration only."),
            tags$li("The model is only reliable for weights between about 1.5 and 5.5 thousand lbs.")
          )
        )
      )
    )
  )
))
