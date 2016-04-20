## Exploratory Data Analysis Assignment: Course Project 2
## Loading provided datasets

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Use the ggplot2 plotting system to make a plot
library(ggplot2)

## Types of sources indicated by the type (point,nonpoint,onroad,nonroad)variable,
## which sources have seen decreases in emissions from 1999-2008 for Baltimore? 
## Which have seen increases in emissions from 1999-2008?
## Generate the Graph

subsetNEI  <- NEI[NEI$fips=="24510", ]

aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)

png("plot3.png")
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("Years") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City from 1999 to 2008')
print(g)
dev.off()

