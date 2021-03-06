library(tidyverse)
library(shiny)
library(ggplot2)
library(RColorBrewer)
library(microbenchmark)
library(DT)
library(googleVis)

psa <- read.csv("./psa.csv", stringsAsFactors = FALSE )



# Displays ####
# defining list of categories to be displayed in the dropdown bar
categories <- psa %>% 
    group_by(Category) %>% 
    transmute()


# Defining DF means whit the avg of every numerical column
means <- psa %>% 
    group_by(Category) %>% 
    summarise(Rating = mean(Rating), Reviews = mean(Reviews), Installs = mean(Installs), Size = mean(Size))













 