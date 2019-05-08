#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shinydashboard)
library(DT)

shinyUI(
    dashboardPage(
        # header ####
        dashboardHeader(title = "App finder"),
        
        # Sidebar ####
        dashboardSidebar(
            sidebarUserPanel("Leonardo Quintero", 
                             subtitle = 'NYC Data Science Academy', image = "https://pbs.twimg.com/profile_images/548550402832998401/PDz9C7S7_400x400.png"),
            sidebarMenu(
                menuItem("Home", tabName = "Home", icon = icon("home")),
                menuItem("Dashboard", tabName = "Dashboard", icon = icon("dashboard")),
                menuItem('charts', tabName = "charts", icon = icon("chart-bar")),
                menuItem("Data", tabName = "Data", icon = icon("database")),
                menuItem("LM", tabName = "tab", icon = icon("table"))
            )),
            
        # boddy ####
        dashboardBody(
            tabItems(
                
                # Home and project description
                tabItem(tabName = "Home",
                        fluidPage(
                             
                                   column(width = 12, box(
                                    h1("Find out what apps already exist"),
                                   
                                    h3("Introduction:"),
                                    p("People constantly have new app ideas.
                                      Whether it's an idea that will help everyday 
                                      life or an idea that will benefit a specific
                                      niche, app ideas seem to pop up all over the
                                      place. The problem is that people will start
                                      to brainstorm or work through a concept that
                                      might already exist -- or worse, five or six 
                                      successful versions of the idea already exist.
                                      This project's goal is to help figure out which
                                      app ideas are already taken in the Google Play 
                                      store. Users can then determine whether or not 
                                      their concept is worth pursuing."),
                                    
                                    h3("How it works:"),
                                    p("Select a category from the list. Users will
                                       see a list of all apps in the Google Play 
                                       store that fall under that category. 
                                    Additionally, users will see the average rating, 
                                       average number of reviews, number of installs,
                                       and average size of all apps in that category."),

                                     p("Next, type in a keyword and press submit. 
                                       The webapp will show users a list of apps 
                                       with in that categories that contain those 
                                       specified keywords. The webapp also displays 
                                       each app's total number of reviews, average 
                                       rating, size, number of installs, type (free
                                       or paid), price, and content rating.
                                       In the charts section, users can view a series 
                                        of bar plots and scatterplots. Compare elements 
                                        such as category, reviews, installations, 
                                        size, and rating to find patterns."), 

                                     p("Finally, in the data section, users can view all of 
                                       the apps in the Google Play store and search
                                       by keyword. After submitting a keyword, the 
                                       results will display all apps with that 
                                       specified keyword and the corresponding 
                                       category, rating, number of reviews, size,
                                       number of installs, type (free or paid), 
                                       price, and content rating."),
                                    
                                    h3("Data:"),
                                    a(href = "https://www.kaggle.com/lava18/google-play-store-apps"
                                      , "This Dataset was obtained from Kaggle"),
                                    
                                    h3("Code"),
                                    a(href = "https://github.com/leosquintero/App-finder-project.git", "Find the code
                                     to this project here"), width = 12)))),
                
                
                
                
                # Dashboard with functionalities 
                tabItem(tabName = "Dashboard", 
                        fluidPage( titlePanel("Search your app by category or keyword") ,
                                box(selectInput("Categories", "Select a category",
                                               choices = unique(categories)), width = 4)),
                                
                                DT::dataTableOutput(outputId = "hpo2"), width = 12,
                                DT::dataTableOutput(outputId = "hpo"), width = 12),
                      
                        
                # charts section        
                tabItem(tabName = "charts", 
                        fluidPage(mainPanel(width = 12,
                                  tabsetPanel(
                                        tabPanel("Count", titlePanel("Count of apps per Category"), plotOutput("count")),
                                        tabPanel("Ratings vs Reviews", titlePanel("AVG Ratings vs AVG Reviews"), plotOutput("avgrev")),
                                        tabPanel("Scatterplots", fluidRow(titlePanel("Scatterplots"), 
                                                                          selectInput("select", "Select input",choices = c("Reviews", "Installs", "Rating", "Size")),
                                                                          selectInput("select2", "Select input",choices = c("Reviews", "Installs", "Rating", "Size")),
                                           fluidPage(plotOutput("Plots")))),
                                        tabPanel("Categories bar plots", fluidRow(titlePanel("Barplots grouperd by Category")), 
                                                                                  selectInput("select4", "Select input", choices = c("Reviews", "Installs", "Rating", "Size")),
                                                 fluidRow(plotOutput("barplot"))),
                                          tabPanel("Areas", fluidRow(titlePanel("Barplots grouperd by Category"), 
                                                   selectInput("select5", "Select input", choices = c("Reviews", "Installs", "Rating", "Size")),
                                                   fluidRow(plotOutput("barplot3")))))))),
                tabItem(tabName = "tab", 
                        fluidPage(mainPanel(width = 12, 
                                            box(selectInput("selectin", "Select dependent Variable", choices = c("Reviews", "Installs", "Rating", "Size")), 
                                                selectInput("selectin2", "Select Independent variable", choices = c("Installs", "Reviews", "Rating", "Size"))), 
                                                box(verbatimTextOutput("table2"), width = 12))
                                                )),
                
                                        
            
                            
                                
            
                # Data table with all elements
                tabItem(tabName = "Data",  
                        fluidPage(DT::dataTableOutput("table"))))
            
                )
        
        )
)
