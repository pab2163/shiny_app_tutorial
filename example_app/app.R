# Iris plotting shiny app demo
# Author: Paul A. Bloom
# Date: April 9, 2020

library(shiny)
library(ggplot2)


# USER INTERFACE -----------------------------------------------------

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  # App title ----
  titlePanel("Iris Shiny App!"),
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    # Sidebar panel for inputs ----
    sidebarPanel(
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins_choice",
                  label = "Number of bins:",
                  min = 1,
                  max = 30,
                  value = 10),
      checkboxGroupInput(inputId = 'flowers_choice', label = 'Species', 
                         choices = c('setosa', 'virginica', 'versicolor'),
                         selected = c('setosa', 'virginica', 'versicolor')),
      radioButtons(inputId = 'facet_choice', label = 'Facet by species', choices = c('Yes', 'No')),
      
      # Make an 'action button' that does something when clicked
      actionButton("do", "Click Me")
    ),
    # Main panel for displaying outputs ----
    mainPanel(
      
      # To make panel with tabs
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput(outputId = "my_plot")),
                  tabPanel("Info", h6('Here is some text')),
                  tabPanel("Links", a("Iris Dataset", href="https://gist.github.com/curran/a08a1080b88344b0c8a7"))
                  
      ),
    )
  )
)


# SERVER FUNCTION ---------------------------------------------------------

server_function <- function(input, output) {
  # Histogram of the Iris Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$my_plot <- renderPlot({
    
    # Filter the iri data according to the input -- the user is choosing which species to display
    df = dplyr::filter(iris, Species %in% input$flowers_choice)
    
    # Set the histogram bins based on user input for number of bins
    hist_bins <- seq(min(df$Sepal.Length), max(df$Sepal.Length), length.out = input$bins_choice + 1)
    
    # create the plot
    iris_plot = ggplot(df, aes(Sepal.Length)) +
      geom_histogram(breaks = hist_bins, fill = 'blue', alpha = .7) +
      theme_bw() +
      labs(x = "Sepal Length", 
           y = 'Count',
           title = 'Histogram of sepal lengths from the iris dataset') +
      theme(text = element_text(face = 'bold'))
    
    # if faceting by species, make the facets
    if (input$facet_choice == 'Yes'){
      iris_plot = iris_plot + facet_grid(~Species)
    }
    
    # Display the plot (whether it has facets or not)
    iris_plot
    
  })
  
  # observeEvent for the button press
  # This waits to run this code (displaying a dialogue box, until the button is pressed)
  observeEvent(input$do, {
    showModal(modalDialog(
      title = "Button pressed", "You pressed the button! Nice job!"))
    }
  )
  
}


# SHINY APP CALL --------------------------------------------------------------

shinyApp(ui = ui, server = server_function)
