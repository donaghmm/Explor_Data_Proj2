#Plot 5
library(dplyr)
library(ggplot2)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group the data by Year
dataframe<- group_by(NEI,year)

#Filter only the Observations that are for Baltimore City and are of the Type ON-ROAD (using ON-ROAD to identify motor vechicles sources)
filtered_data<-filter(dataframe, type == 'ON-ROAD', fips == '24510')

# Summarize the data(grouped by year) Summing Emissions
summary<-summarize(filtered_data, Emissions=sum(Emissions))

#Plot the results including linear model trend line.
png(filename = "plot5.png", width = 600, height = 600, units = 'px')
g = ggplot(summary,aes(year,Emissions)) 
g + geom_point(size=4) + geom_smooth(method= "lm") + ggtitle("Change in emissions from motor vehicle sources in Baltimore City") + ylab("Emissions - PM2.5 tons")
dev.off()
