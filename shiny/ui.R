#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(ggplot2)
data <- read_delim("bigmart_train.csv", delim = ",")
data$Item_Fat_Content <- as.factor(data$Item_Fat_Content)
data$Item_Type <- as.factor(data$Item_Type)
data$Outlet_Size <- as.factor(data$Outlet_Size)
data$Outlet_Location_Type <- as.factor(data$Outlet_Location_Type)
data$Outlet_Type <- as.factor(data$Outlet_Type)


# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("bmdataset"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("pick",
                        "Number of elements:",
                        min = 100,
                        max = nrow(data),
                        value = 1000),
            selectInput("outletType","Outlet Type:",
                        choices=c("All",levels(data$Outlet_Type))),
            selectInput("tier","Location Type:",
                        choices=c("All",levels(data$Outlet_Location_Type))),
            selectInput("type","Price or Visibility:",
                        choices=c("Price","Visibility"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("pickPlot")
        )
    )
))
