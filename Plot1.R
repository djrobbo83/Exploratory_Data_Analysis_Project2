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
#               Q1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#                   Using the base plotting system, make a plot showing the total PM2.5 emission from all
#                   sources for each of the years 1999, 2002, 2005, and 2008.
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
names(NEI)
colours()
#SUMMARISE FOR PLOT
Annual_emissions <- with(NEI, tapply(Emissions, year, sum))
#NICE COLOURS
rb <- colorRampPalette(c("Light Blue", "Blue"))
dat_rb <- rb(4)[cut(Annual_emissions, breaks = 4)]
#PLOT
png("plot1.png", width = 480, height = 480)
barplot(Annual_emissions / 1000000, 
        xlab = "year", 
        ylab = expression("Total PM"[2.5]*" Emitted (million tonnes)"), 
        main = "Total Emissions By Year: United States",
        col  = dat_rb)
dev.off()

