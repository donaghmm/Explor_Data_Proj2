# Plot1
library(dplyr)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group the data by Year
dataframe<-group_by(NEI,year)

# Summarize the data(grouped by year) Summing Emissions
summary<-summarize(dataframe, Emissions=sum(Emissions))


#Plot the results
png(filename = "plot1.png",  width = 600, height = 600, units = 'px')
with(summary,plot(year,Emissions,type="l",ylab ="Emissions - PM2.5 tons",xlab="Years", main="PM2.5 Emissions in the US"))
dev.off()
