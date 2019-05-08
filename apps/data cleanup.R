library(tidyverse)
library(shiny)
library(ggplot2)
library(RColorBrewer)

#uploading Play Store Apps data set
psa <- read.csv('./googleplaystore.csv')
str(psa)

head(psa)


# Category ####
# cleaning non character elements from category column
psa['Category'] <- gsub(pattern = "_", replacement = " ", x = psa$Category)
# Deleting row with error
psa <- psa[-c(10473),] 


# Ratings ####
# Changing NANs for 0s
psa$Rating[is.nan(psa$Rating)] <- 0
psa$Rating[is.na(psa$Rating)] <- 0

# Reviews ####
# converting reviews column into numeric
psa['Reviews'] <- round(as.numeric(psa$Reviews))



# Installs ####
# Erasing non numerical elements from Installs column
psa['Installs'] <- gsub(pattern = "\\+", replacement = "", x = psa$Installs)
psa['Installs'] <- gsub(pattern = "\\,", replacement = "", x = psa$Installs)
psa['Installs'] <- gsub(pattern = " ", replacement = "", x = psa$Installs)

# converting installs column into numeric
options("scipen"=100, "digits"=2)
psa['Installs'] <- as.numeric(psa$Installs)
psa['Installs'] <- as.integer(round(psa$Installs))

# Applying jitter to Installs column
psa['Installs'] <- abs(round(jitter(psa$Installs, amount = 10000)))


# size ####
# Cleaning up Zise
psa['Size'] <- gsub(pattern = "M", replacement = "", x = psa$Size)
psa['Size'] <- round(as.numeric(psa$Size))

psa$Size[is.na(psa$Size)] <- 0



# Droping repeated and unused columns ####
#droping 
psa = subset(psa, select = -c(Current.Ver, Android.Ver, Genres, Last.Updated))

# downloading

psa <- write.csv(psa, 'psa.csv', row.names = F)

 