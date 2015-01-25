#Plot 6
library(dplyr)
library(ggplot2)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group the data by Year and fips
dataframe<- group_by(NEI,year,fips)

#Filter only the Observations that are for Baltimore City or Los Angeles County that are of the Type ON-ROAD (using ON-ROAD to identify motor vechicles sources)
filtered_data<-filter(dataframe, type == 'ON-ROAD', fips == '24510' | fips == '06037')

summary<-summarize(filtered_data, Emissions=sum(Emissions))

#Plot the results including linear model trend line.
png(filename = "plot6.png", width = 600, height = 600, units = 'px')
g = ggplot(summary,aes(year,Emissions)) 
g + geom_point(size=4,aes(color = year)) + geom_smooth(method= "lm")  + facet_grid(. ~ fips) + ggtitle("Motor vehicle source Emissions in \n Baltimore City(24510) and Los Angeles County(06037)") + ylab("Emissions - PM2.5 tons")
dev.off()
