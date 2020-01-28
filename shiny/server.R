#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

colnames(data)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$pickPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        pick <- input$pick
        outletType <- input$outletType
        tier <- input$tier
        type <- input$type
        
        
        
        sample <- sample_n(data, pick)
        
        if (outletType=="All") {

        } else {
            sample <- sample %>%
                filter(Outlet_Type==outletType)
        }
        
        if (tier=="All") {
            
        } else {
            sample <- sample %>%
                filter(Outlet_Location_Type==tier)
        }
        
        if(type=="Price") {
            x_val = sample$Item_MRP
        } else{
            x_val = sample$Item_Visibility
        }
        
        ggplot(sample) +
            aes(x = x_val,y = Item_Outlet_Sales,shape=Outlet_Location_Type,size=Item_Weight) +
            geom_point(aes(col=Outlet_Type))+
            ggtitle(paste("Item ",type," vs Item Sales of BMData"),subtitle = paste0("N = ",nrow(sample))) +
            guides(col="legend") +
            scale_color_discrete(name="Outlet Type") +
            scale_shape(name="Outlet Location Type") +
            scale_fill_brewer(type = "qual",palette=6)

    })

})
