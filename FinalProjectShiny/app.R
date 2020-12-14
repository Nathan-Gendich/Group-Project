#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
FinalProjData <- read.csv("fulldata.csv",stringsAsFactors = FALSE)

ui <- fluidPage(
    titlePanel("Speed of CitiBike Riders"),
    sidebarLayout(
        sidebarPanel(
            radioButtons("type", "User type",
                         choices = c("Customer", "Subscriber"),
                         selected = "Customer"),
            selectInput("genders", "Gender",
                        choices = c("Male", "Female", "Unknown"))
        ),
        mainPanel(
            plotOutput("coolplot"),
            br(), br(),
            tableOutput("results")
         )
    )
)

server <- function(input, output) {
    output$coolplot <- renderPlot({
        filtered <-
            fulldata %>%
            filter(
                   usertype == input$type,
                   gender == input$genders
            )
        ggplot(filtered, aes(avgspeed)) +
            geom_histogram()
    })
}

shinyApp(ui = ui, server = server)