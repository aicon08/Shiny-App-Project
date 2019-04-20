library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Rock, Paper, Scissors"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            actionButton("action1",label = "Rock"),
            actionButton("action2",label = "Paper"),
            actionButton("action3", label="Scissors")
        ),

        # Show a plot of the generated distribution
        mainPanel(
        
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$value <- renderPrint({input$action1
        
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
