library(shiny)

# Define the UI
ui <- fluidPage(
  titlePanel("Roll a Six-Sided Die"),
  sidebarLayout(
    sidebarPanel(
      actionButton("roll_button", "Roll the Die")
    ),
    mainPanel(
      h3("Result:"),
      textOutput("roll_result")
    )
  )
)

# Define the server logic
server <- function(input, output, session) {
  # Reactive value to store the die roll result
  result <- reactiveVal("")

  # Roll the die when the button is clicked
  observeEvent(input$roll_button, {
    result(sample(1:6, size = 1)) # Random number between 1 and 6
  })

  # Display the result
  output$roll_result <- renderText({
    result()
  })
}

# Run the application
shinyApp(ui = ui, server = server)
