# SHINY APP TEMPLATE
# Author: 
# Date: 

# The following is a template shiny app that is not complete, but gives you an outline from which to start! 
# You'll need to fill in the parts marked <FILL IN>

# Load shiny package and any other packages you'll need
library(shiny)


# USER INTERFACE -----------------------------------------------------

user_interface <- fluidPage(
  # App title ----
  titlePanel("<FILL IN>"),
  
  # Sidebar layout with input and output definitions ----
  # Inputs feed into the server panel to give your server code information
  # Outputs display the results of objects in the server code
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: ----
      # Here, you can create differen types of input (sliderInput, checkboxInput, radioButtons, etc)
      # Make sure each input has a unique inputId that you can reference in the server code
      #<FILL IN> 
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      # This would display the plot1 output created by the server functio
      plotOutput(outputId = "plot1")
    )
  )
)


# SERVER FUNCTION ---------------------------------------------------------

server_function <- function(input, output) {
  output$plot1 <- renderPlot({
    #<FILL IN>
    # R code goes here to create a graph to be displayed by Shiny
    # If you want it to take reactive input from the user, you can call these variables using input$<inputId>
  })
  
}


# SHINY APP CALL --------------------------------------------------------------

# This puts everything together: your user interface and backend server function, and binds together as a shiny app
shinyApp(ui = user_interface, server = server_function)
