library(tidyverse)
library(shiny)
library(ggplot2)
library(RColorBrewer)
library(microbenchmark)
library(DT)

psa <- read.csv("./psa.csv", stringsAsFactors = )



# Displays ####
# defining list of categories to be displayed in the dropdown bar
categories <- psa %>% 
    group_by(Category) %>% 
    transmute()


# Defining DF means whit the avg of every numerical column
means <- psa %>% 
    group_by(Category) %>% 
    summarise(Rating = mean(Rating), Reviews = round(mean(Reviews)), Installs = round(mean(Installs)), Size = mean(Size))





