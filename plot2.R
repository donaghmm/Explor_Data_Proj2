#PLot2
library(dplyr)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Group the data by Year and filter only the records for Baltimore City (fips=24510)
dataframe<-filter(group_by(NEI,year),fips=="24510")


# Summarize the data(grouped by year) Summing Emissions
summary<-summarize(dataframe, Emissions=sum(Emissions))

#Plot the results with linear model trend line
png(filename = "plot2.png", width = 600, height = 600, units = 'px')
with(summary,plot(year,Emissions,type="p",ylab ="Emissions - PM2.5 tons",xlab="Years", pch=20, main="PM2.5 Emissions in Baltimore City"))
model <- lm(Emissions ~ year,summary)
abline(model, lwd = 2)
dev.off()
