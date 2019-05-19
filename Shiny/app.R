library(shiny)
library(tidyverse)
library(ggplot2)
library(lattice)
library(mosaic)
library(MASS)
library(tree)
library(randomForest)
library(dplyr)
library(ggrepel)
library(graphics)
library(factoextra)
#runExample("01_hello")

attrition = read_csv("C:/Users/admin/Desktop/ADM/PROJECT-ADM/WA_Fn-UseC_-HR-Employee-Attrition.csv")

ui <- fluidPage(
  titlePanel("Attrition Data Set Exploration", "ADM Shingy App"), 
  br(),
  sidebarPanel("our inputs will go here"),
  sliderInput("incomeInput", "Income", 0, 10000, c(25,40), pre = "$"),
  selectInput("educInput", "Variable:",
              levels(factor(attrition$EducationField))),
  radioButtons("typeInput", "Product type",
               choices = c("BEER", "REFRESHMENT", "SPIRITS", "WINE"),
               selected = "WINE"),
  
  mainPanel(
    plotOutput("coolplot"),
    br(), br(),
    tableOutput("results"),
    br(), br(),
    plotOutput("anotherplot")
  )
)
server <-  function(input, output) {
  output$coolplot <- renderPlot({
    filtered <- 
      attrition %>%
      filter(MonthlyIncome >= input$incomeInput[1])
    ggplot(filtered, aes(MonthlyIncome)) +
      geom_histogram()
  })
  
  output$anotherplot <- renderPlot({
    filtered <- 
      attrition %>%
      filter(MonthlyIncome >= input$incomeInput[1],
             EducationField == input$educInput)
    ggplot(filtered, aes(MonthlyIncome, Attrition)) +
      geom_point()
  })
  
}

shinyApp(ui = ui, server = server)
