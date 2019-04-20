
library(shiny)
library(dplyr)

ui <- fluidPage(
    
    # Application title
    titlePanel("Starwars Calculator"),
    
     selectInput("Species", label = h3("Species Choice"), 
                choices = unique(starwars$species)),
    
    # Show a plot of the generated distribution
    mainPanel(tableOutput("sw"))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$sw<- renderTable(a<-starwars[,1:10]%>%
                                filter(species %in% input$Species== TRUE))
    
}

# Run the application 
shinyApp(ui = ui, server = server)
