library(shiny)
library(ggplot2)


ui <- fluidPage(
  titlePanel("Attrition"),
  sidebarLayout(
    sidebarPanel(
      selectInput("Info","This is it:", choices=c("Age","Education"))
    ),
    mainPanel(
      plotOutput("histogram"),
      plotOutput("bar"),
      br(), br(),
      tableOutput("results")
  ))
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  attrition <- read.csv("~/Desktop/PROJECT-ADM-master/ADM/WA_Fn-UseC_-HR-Employee-Attrition.csv")
  library(ggplot2)
  output$histogram <- renderPlot({
    attrition %>% filter(Age=input$Info)
    ggplot(attrition, aes(x=Age)) +
      geom_histogram()
  })
  output$bar <- renderPlot({
    attrition %>% filter(Education=input$Info)
    ggplot(attrition, aes(x=DailyRate))+
      geom_point()
  })
}

  
# Run the application 
shinyApp(ui = ui, server = server)

