library(shiny)

# ==== Define UI ====
ui <- fluidPage(

  # time_line, Mu, lambda, initial_capital,
  # sample_size = 30, avg_premium_rate = 1

  titlePanel("Surplus function !"),
  sidebarLayout(
    sidebarPanel(
      numericInput("from", "start point", value = 0, min = 0),
      numericInput("to", "end point", value = 10, min = 0),
      numericInput("by", "increase by", value = 0.001, min = 0.00001),
      numericInput("Mu", "Mu", value = 4),
      numericInput("lambda", "lambda", value = 3),
      numericInput("initial_capital", "initial_capital", value = 30, min = 1),
      numericInput("sample_size", "sample_size", value = 30, min = 1),
      numericInput("avg_premium_rate", "avg_premium_rate", value = 1, min = 0)),

    mainPanel(plotOutput(outputId = "plot")))
)

# ==== Define server ====

server <- function(input, output) {

  output$plot <- renderPlot({

    x <- seq(input$from, input$to, by = input$by)
    s <- surplus(x, input$Mu, input$lambda, input$initial_capital,
                 input$sample_size, input$avg_premium_rate)
    plot(s)
  })
}

# ==== run app ====
shinyApp(ui = ui, server = server)
