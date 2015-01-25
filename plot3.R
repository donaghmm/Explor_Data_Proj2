#Plot 3
library(ggplot2)
library(dplyr)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group the data by Year and Type and filter only the records for Baltimore City (fips=24510)
dataframe<-filter(group_by(NEI,year,type),fips=="24510")


# Summarize the data(grouped by year and type) Summing Emissions
summary<-summarize(dataframe, Emissions=sum(Emissions))

#Plot the results - plots a separate grid for each Type. Inlcudes a linear model trend line
png(filename = "plot3.png", width = 600, height = 600, units = 'px')
g = ggplot(summary,aes(year,Emissions)) 
g + geom_point() + geom_smooth(method= "lm") + facet_grid(. ~ type) + ggtitle("Emissions in Baltimore City by Type and Year") + ylab("Emissions - PM2.5 tons")
dev.off()
