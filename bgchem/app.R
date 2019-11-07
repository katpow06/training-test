#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
# Load data from Arctic data sentere
data_url <- "https://arcticdata.io/metacat/d1/mn/v2/object/urn%3Auuid%3A35ad7624-b159-4e29-a700-0c0770419941"
bg_chem <- read.csv(url(data_url,method="libcurl"),stringsAsFactors = F)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("BioGeochem"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("depth",
                        "Depth:",
                        min = 1,
                        max = 500,
                        value = c(1,100))
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),
           plotOutput("Plot2")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        ggplot(bg_chem, aes(x=CTD_Depth, y=CTD_Salinity))+
            geom_point(size =3, color="purple")+
            xlim(input$depth[1], input$depth[2])+
            theme_bw()
    })
    output$Plot2 <- renderPlot({
        ggplot(bg_chem, aes(x=CTD_Depth, y=CTD_Salinity))+
            geom_point(size =3, color="purple")+
            xlim(input$depth[1], input$depth[2])+
            theme_bw()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
