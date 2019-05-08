#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)
library(googleVis)


shinyServer(function(input, output){
    
    
    
    
    # Interactive dashboar ####
    # dropdown with list of all categories to be slected
    output$Categories <- renderPrint({ input$Categories })
    
    # Data table with avgs by category selected 
    output$hpo2 <- renderTable({
        means %>%
        dplyr::filter(Category %in% input$Categories)
    
    })        
    
    # table with list of apps by category
    output$hpo <- renderDataTable({
        psa %>%
            dplyr::filter(Category %in% input$Categories)
        
    }) 
    
    # Charts page ####
    # plotting count of apps grouped by category
    output$count <- renderPlot({
        psa %>%
            group_by(Category) %>%
            summarise(count=n()) %>%
            top_n(30, count) %>% 
            ggplot( aes(x = reorder(Category, count), y = count)) +
            geom_col(fill = "skyblue") +
            ggtitle("Top 30 Apps by category") +
            labs(x='Category',
                 y= 'Count') +
            coord_flip(expand = TRUE) + 
            theme(plot.subtitle = element_text(vjust = 1), 
    plot.caption = element_text(vjust = 1), 
    axis.title = element_text(size = 14))
    })
    
    # Top 30 apps by Rating
    output$Plots <- renderPlot({
        means %>% 
            ggplot(aes_string(input$select, input$select2))+
            geom_point() +
            geom_smooth()
    })
    
    # Interactive plot showing avg number of reviews vs avg rating per category
    output$avgrev <- renderPlot({    
    p1 <- means %>% 
        ggplot(aes(Reviews, Rating, colour = Category))+
        geom_point() +
        geom_smooth()
        ggExtra::ggMarginal(
        p = p1,
        type = 'density',
        margins = 'both',
        size = 4,
        colour = '#303FADEC',
        fill = '#1D69CC'
    )
    })
    
    # Renderplot ploting avg reviews, rating, installs and app size by category
    output$barplot <- renderPlot({
    means %>%   
        ggplot(aes_string(x = 'Category', y = input$select4)) +
            geom_col(aes(Category), fill = "skyblue")+
            labs(x='Category',
                 y= 'Variable')+
            coord_flip(expand = TRUE)
            
    })
    
    output$barplot3 <- renderPlot({
        psa %>% 
        ggplot(aes_string(input$select5)) +
        geom_area(stat = "Bin", fill = "skyblue")
        
    })
    
    # Data page ####
    # table with all description of data set
    output$table <- DT::renderDataTable({
        datatable(psa, rownames=F) %>%
            formatStyle(input$selected,
                        background="blue", fontWeight='bold')
    
        
    })
    output$table2 <- renderPrint({
        summary(lm(as.formula(paste(input$selectin, "~", paste(input$selectin2,
                                "+", "Category"))), psa, na.action = na.exclude))
    })
})
    

        
        
