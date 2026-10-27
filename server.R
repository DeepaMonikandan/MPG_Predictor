library(shiny)

# Fit the model once, when the app starts
model <- lm(mpg ~ wt + cyl + am, data = mtcars)

shinyServer(function(input, output) {

  # Build a one-row data frame from the user's inputs and predict
  pred <- reactive({
    newcar <- data.frame(wt = input$wt,
                         cyl = as.numeric(input$cyl),
                         am = as.numeric(input$am))
    predict(model, newcar, interval = "prediction")
  })

  output$prediction <- renderText({
    paste0(round(pred()[1, "fit"], 1), " miles per gallon")
  })

  output$interval <- renderText({
    paste0("95% prediction range: ",
           round(pred()[1, "lwr"], 1), " to ",
           round(pred()[1, "upr"], 1), " MPG")
  })

  output$plot <- renderPlot({
    plot(mtcars$wt, mtcars$mpg, pch = 19, col = "grey60",
         xlab = "Weight (1000 lbs)", ylab = "Miles per gallon",
         main = "Your car vs. the mtcars dataset")
    if (input$show_fit) {
      abline(lm(mpg ~ wt, data = mtcars), col = "steelblue", lwd = 2)
    }
    points(input$wt, pred()[1, "fit"], pch = 19, col = "red", cex = 2.5)
    legend("topright", legend = c("Dataset cars", "Your car"),
           pch = 19, col = c("grey60", "red"))
  })
})
