library(shiny)
library(ggplot2)

# Demand curve parameters
a_range <- 50:200
b_range <- 0.5:2
c_range <- 1:10

# User interface with sliders for `a` and `b` and numeric inputs for each group
ui <- fluidPage(
  titlePanel("Digital Advertising Production Dashboard"),

  sidebarLayout(
      sidebarPanel(
          # Randomize demand curve parameters
          sliderInput("a", "Demand Curve Intercept (a):", min = min(a_range), max = max(a_range), value = sample(a_range, 1)),
          sliderInput("b", "Demand Curve Slope (b):", min = min(b_range), max = max(b_range), value = sample(b_range, 1)),
          sliderInput("c", "Marginal Cost (c):", min = min(c_range), max = max(c_range), value = sample(c_range, 1)),
          
          # Input production quantities for each group (up to 12)
          numericInput("group1", "Group 1 Ad Quantity:", value = 0, min = 0),
          numericInput("group2", "Group 2 Ad Quantity:", value = 0, min = 0),
          numericInput("group3", "Group 3 Ad Quantity:", value = 0, min = 0),
          numericInput("group4", "Group 4 Ad Quantity:", value = 0, min = 0),
          numericInput("group5", "Group 5 Ad Quantity:", value = 0, min = 0),
          numericInput("group6", "Group 6 Ad Quantity:", value = 0, min = 0),
          numericInput("group7", "Group 7 Ad Quantity:", value = 0, min = 0),
          numericInput("group8", "Group 8 Ad Quantity:", value = 0, min = 0),
          numericInput("group9", "Group 9 Ad Quantity:", value = 0, min = 0),
          numericInput("group10", "Group 10 Ad Quantity:", value = 0, min = 0),
          numericInput("group11", "Group 11 Ad Quantity:", value = 0, min = 0),
          numericInput("group12", "Group 12 Ad Quantity:", value = 0, min = 0)
      ),
      
      mainPanel(
          plotOutput("demandPlot"),
          textOutput("marketPriceText"),
          tableOutput("profitTable")
      )
  )
)

# Server logic for calculating total quantity and plotting demand curve
server <- function(input, output) {
    # Reactive calculation of total quantity from all groups
    totalQuantity <- reactive({
        sum(input$group1, input$group2, input$group3, input$group4, input$group5,
            input$group6, input$group7, input$group8, input$group9, input$group10,
            input$group11, input$group12)
    })
    
    # Reactive calculation of market price based on total quantity and demand curve
    marketPrice <- reactive({
        input$a - input$b * totalQuantity()
    })
    
    # Plotting the demand curve with the intersection point for market price
    output$demandPlot <- renderPlot({
        ggplot(data = data.frame(Q = 0:(input$a/input$b)), aes(x = Q)) +
            geom_line(aes(y = input$a - input$b * Q), color = "blue") +
            geom_point(aes(x = totalQuantity(), y = marketPrice()), color = "red", size = 3) +
            labs(
                title = "Social Media Advertising Demand",
                x = "Total Quantity of Ad Space",
                y = "Price per Ad Slot"
            ) +
            theme_minimal()
    })
    
    # Displaying the market price as text
    output$marketPriceText <- renderText({
        paste("Market Price per Ad Slot: $", round(marketPrice(), 2))
    })

    # Table of profits for each group
    output$profitTable <- renderTable({
        group_quantities <- c(input$group1, input$group2, input$group3, input$group4, input$group5,
                              input$group6, input$group7, input$group8, input$group9, input$group10,
                              input$group11, input$group12)
        group_profits <- group_quantities * marketPrice() - input$c * group_quantities
        
        # Create a data frame for group profits
        data.frame(
            Group = paste("Group", 1:12),
            Quantity = group_quantities,
            Profit = round(group_profits, 2)
        )
    })
}

# Run the app
shinyApp(ui, server)
