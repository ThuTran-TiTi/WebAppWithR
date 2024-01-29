# Install and load the shiny library if not already installed
# install.packages("shiny")
library(shiny)

# Define the UI components
ui <- fluidPage(
  theme= shinytheme("yeti"),
  titlePanel("BMI Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("age_group", "Select age group:", c("Children", "Adults")),
      numericInput("height", "Enter your height:", value = 1.5, min = 0),
      selectInput("height_unit", "Height unit:", c("m", "feet")),
      numericInput("weight", "Enter your weight:", value = 50, min = 0),
      selectInput("weight_unit", "Weight unit:", c("kg", "lb")),
      br(),
      actionButton("calculate", "Calculate BMI")
    ),
    
    mainPanel(
      h4("BMI Category:"),
      textOutput("bmi_category")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  observeEvent(input$calculate, {
    age_group <- input$age_group
    height <- input$height
    weight <- input$weight
    height_unit <- input$height_unit
    weight_unit <- input$weight_unit
    
    # Convert height and weight to metric units if necessary
    if (height_unit == "feet") {
      height <- height * 0.3048  # Convert feet to meters
    }
    
    if (weight_unit == "lb") {
      weight <- weight * 0.453592  # Convert pounds to kilograms
    }
    
    bmi <- weight / (height^2)
    
    bmi_category <- if (age_group == "Children") {
      if (bmi < 5) {
        "Very severely underweight"
      } else if (bmi >= 5 && bmi < 12) {
        "Underweight"
      } else if (bmi >= 12 && bmi < 18.5) {
        "Normal weight"
      } else if (bmi >= 18.5 && bmi < 25) {
        "Overweight"
      } else {
        "Obesity"
      }
    } else {
      if (bmi < 18.5) {
        "Underweight"
      } else if (bmi >= 18.5 && bmi <= 24.9) {
        "Normal weight"
      } else if (bmi >= 25 && bmi <= 29.9) {
        "Overweight"
      } else {
        "Obesity"
      }
    }
    
    output$bmi_category <- renderText({
      paste("BMI:",round(bmi,1),". You're", bmi_category)
    })
  })
}

# Run the Shiny app
shinyApp(ui, server)
