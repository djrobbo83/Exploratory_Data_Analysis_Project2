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
#               Q4. Across the United States, how have emissions from 
#                   coal combustion-related sources changed from 1999-2008?
#
#<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>
#install.packages("devtools")
library(devtools)
#devtools::install_github("tidyverse/ggplot2")
library(ggplot2)

#SUBSET DATA USING GREP TO PULL OUT 
coal_unique <- unique(SCC$EI.Sector) # FIND OUT WHAT TO GREP
#View(coal_unique)
#WANT TO GREP "FUEL COMB" = FUEL COMBUSTION & KEYWORD "COAL" FOLLOWING THIS
coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
coal_scc <- SCC[coal,]

#USE coal_scc LIST TO EXTRACT SOURCES FROM NEI DATASET
NEI_coal <- NEI[(NEI$SCC %in% coal_scc$SCC), ]
#NEI_coal_summ <- with(NEI_coal, tapply(Emissions, year, sum)) #tapply returns a vector, I wasnt df, so use Aggregate
NEI_coal_summ <- aggregate(Emissions ~ year, NEI_coal, sum)

png("plot4.png", width = 800, height = 600)
g <- ggplot(NEI_coal_summ, aes(factor(year), Emissions/1000, fill = year, label = round(Emissions/1000,2)))
g + geom_bar(stat = "identity", show.legend = F) +
  xlab("Year") + 
  ylab(expression("Total PM"[2.5]*" Emissions (kiltons)")) +
  ggtitle("Emissions From Coal Combustion Sources") +
  geom_label(aes(fill = year), colour = "white", fontface = "bold", show.legend = F)
dev.off()
