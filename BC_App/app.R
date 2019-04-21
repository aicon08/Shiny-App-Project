library(shiny)
library(dplyr)
library(htmltools)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel(title = h4("Exploration of the Iris Dataset--Learning to Use Shiny",align="center")),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
            sidebarPanel(
                selectInput("species","Select the Species",
                            choices = list("setosa","versicolor","virginica"),selected = "virginica"),
                selectInput("var","Select the data Input",
                            choices = list("Sepal.Length" = 1,"Sepal.Width" = 2,"Petal.Length" = 3,"Petal.Width" = 4),
                            selected=""),
                radioButtons("color", "Choose a display color for the plot",
                             choices = c("Green","Blue","Purple"),selected="Purple"),
                h6("Powered by"),
                tags$img(src="RStudio-Ball.png",height=50,width=50)
                
                        ),

        # Show a plot of the generated distribution
            mainPanel(
                tabsetPanel(type = "tab",
                tabPanel("Summary Data",verbatimTextOutput("sum")),
                tabPanel("Species Input Demo",textOutput("specname")),
                tabPanel("Species Type",tags$ul(tags$img(src="setosa.jpg",height=400,width=400),tags$img(src="versicolor.jpg",height=400,width=400),tags$img(src="virginica.jpg",height=400,width=400))),
                tabPanel("Basic Plot",plotOutput("var")),
                tabPanel("Complex Plot",plotOutput("var2"))
                )
                            
                    )
                )
)

# Define server logic required to draw a histogram
server <- function(input, output) 
{

    colm<-reactive(
        {
        as.numeric(input$var)
        })
    
 
    output$specname<-renderText(paste("You have selected the species: ",input$species))
    
    output$sum<-renderPrint(summary(iris))
    output$var<-renderPlot(hist(iris[,colm()],col=input$color,main=paste("Histogram of Iris Dataset, All Species by",names(iris[colm()])),xlab=names(iris[colm()])))
    
    
    a<-reactive({
        iris%>%
            filter(Species%in%input$species==TRUE)})
    
    output$var2<- renderPlot(hist(a()[,colm()],col = input$color,main = paste("Histogram of Iris Dataset by",input$species),xlab = names(a()[colm()])))
       
    # b<-reactive(
    #     {
    #         as.character(paste(input$species,".jpg",sep = ""))
    #     }
    # )
    # output$img<-renderText(dQuote(b()))
}

# Run the application 
shinyApp(ui = ui, server = server)
