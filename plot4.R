#Plot 4
library(ggplot2)
library(dplyr)

# CHANGE this section based on your working directory and data files.
setwd("d:/github/exploratory_data/data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Grep any record that contains Coal in it Short.Name variable
rows <- c(grep("[cC]oal", SCC$Short.Name))
# Dataframe containing the SCC ids for the rows that contained Coal in the Short.Name variable
df_SCC<-SCC[rows,1]

# Group the data by Year
dataframe<- group_by(NEI,year)
# Filter only Observations that have a matching SCC id to those relating to Coal
filtered_by_SCC<-filter(dataframe, SCC %in% df_SCC)

# Summarize the data(grouped by year) Summing Emissions
summary<-summarize(filtered_by_SCC, Emissions=sum(Emissions))

#Plot the results including linear model trend line.
png(filename = "plot4.png", width = 600, height = 600, units = 'px')
g = ggplot(summary,aes(year,Emissions)) 
g + geom_point(size=4) + geom_smooth(method= "lm") + ggtitle("Changes in Emissions from coal combustion-related sources in US") + ylab("Emissions - PM2.5 tons")
dev.off()
