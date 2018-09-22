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
#               Q5. How have emissions from motor vehicle sources changed from 1999-2008
#                   in Baltimore City?
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#install.packages("devtools")
#library(devtools)
#devtools::install_github("tidyverse/ggplot2")
library(ggplot2)
#TO PULL OUT BALTIMORE FIPS == 24510
#MOTOR VEHICLE SOURCES CAN BE FOUND FROM SOURCE "ON-ROAD"
baltimore_vehicles <- NEI[(NEI$fips == "24510" & NEI$type == "ON-ROAD"),]
balt_veh_summ <- aggregate(Emissions ~ year, baltimore_vehicles, sum)

png("plot5.png", width = 800, height = 600)
g <- ggplot(balt_veh_summ, aes(factor(year), Emissions, fill = year, label = round(Emissions, 2)))
g + geom_bar(stat = "identity", show.legend = F) +
  xlab("Year") + 
  ylab(expression("Total PM"[2.5]*" Emissions (ton)")) +
  ggtitle("Emissions From Motor Vehicle Sources", subtitle = "Baltimore, Maryland") +
  geom_label(aes(fill = year), colour = "white", fontface = "bold", show.legend = F)
dev.off()