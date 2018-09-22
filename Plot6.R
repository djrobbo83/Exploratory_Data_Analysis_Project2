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
#               Q6. Compare emissions from motor vehicle sources in Baltimore City with emissions
#                   from motor vehicle sources in Los Angeles County, California fips == "06037"
#                   Which city has seen greater changes over time in motor vehicle emissions?
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#GGPLOT & GGREPEL USED
#install.packages("devtools")
#library(devtools)
#devtools::install_github("tidyverse/ggplot2")
library(ggplot2)
#install.packages("ggrepel") #FOR LABELS
library(ggrepel)
#EXTRACT BALTIMORE AND LOS ANGELES ON ROAD DATA
balt_LA <- subset(NEI, fips %in% c("24510","06037") & type == "ON-ROAD")
#ADD COUNTY LABEL
balt_LA$county <- ifelse(balt_LA$fips == "24510", "Baltimore City, MD", "Los Angeles County, CA")
#SUMMARISE DATA
balt_LA_summ <- aggregate(Emissions ~ year + county, balt_LA, sum) 
#PLOT
png("plot6.png", width = 800, height = 600)
g <- ggplot(balt_LA_summ, aes(factor(year), Emissions, group = county, color = county, label = round(Emissions,2)))
g + geom_line() +
  geom_point(aes(color = county), pch = 15, show.legend = T) +
  #geom_text(aes(label = round(Emissions,0), hjust = 0, vjust = -1)) +
  geom_label_repel(aes(label=round(Emissions,2)), box.padding = 0.35, point.padding = 0.5, label.size = 0.1, show.legend = F) +
  #theme_classic() + 
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emissions (ton)")) +
  ggtitle("Comparison of Emissions From Motor Vehicle Sources", subtitle = "Baltimore, Maryland vs Los Angeles County, CA")

dev.off()
