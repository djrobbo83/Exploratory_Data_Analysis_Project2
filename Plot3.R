#EXPLORATORY DATA ANALYSIS: COURSE PROJECT 2

#Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health.
#In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for 
#fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its 
#database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). 
#You can read more information about the NEI at the EPA National Emissions Inventory web site.

#For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course
#of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#
#               1. INSTALL REQUIRED PACKAGES & CALL LIBRARIES
#                  SET WORKING DIRECTORY
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>

#SET YOUR WORKING DIRECTORY HERE; THIS IS WHERE THE .RDS FILES SHOULD BE DOWNLOADED TO FROM
# DOWNLOAD DATA FROM LINK
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
# UNZIP AND PLACE summarySCC_PM25.rds & Source_Classification_Code.rds IN THE WORKING DIRECTORY
setwd("C:\\Data Science Specialization JHU\\C4_Exploratory_Data_Analysis\\Project2")


#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#
#               2. READ IN DATA USING readRDS() FUNCTION
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#head(NEI)
#head(SCC)

#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#
#               Q3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
#                   variable, which of these four sources have seen decreases in emissions from 1999-2008 
#                   for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the 
#                   ggplot2 plotting system to make a plot answer this question.
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#GGPLOT & GGREPEL USED
#install.packages("devtools")
library(devtools)
devtools::install_github("tidyverse/ggplot2")
library(ggplot2)
#install.packages("ggrepel") #FOR LABELS
library(ggrepel)

#SUBSET DATA - STEAL CODE FROM Q2
baltimore_MD <- subset(NEI, NEI$fips == "24510")
emissions_type <- aggregate(Emissions ~ year + type, baltimore_MD, sum) 
#View(emissions_type)

#PLOT
png("plot3.png", width = 800, height = 600)
g <- ggplot(emissions_type, aes(year, Emissions, color = type, label = round(Emissions,2)))
g + geom_line() +
  geom_point(aes(color = type), show.legend = TRUE) +
  geom_label_repel(aes(label=round(Emissions,0)), box.padding = unit(0.35, "lines"), point.padding = unit(0.5, "lines"),show.legend = FALSE) +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions (ton)")) +
  ggtitle("Total Emissions by Type", subtitle = "Baltimore, Maryland")
dev.off()
