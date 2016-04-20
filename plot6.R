## Exploratory Data Analysis Assignment: Course Project 2
## Loading provided datasets

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# merge data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)

## Compare emissions from motor vehicle sources in 
## Baltimore City with Los Angeles County, California 
## Use fips == 06037 for Los Angeles County, California 
## Which city has seen greater changes over time in motor vehicle emissions?
## Generate graph

subsetNEI <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png")
g <- ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City vs Los Angeles')
print(g)
dev.off()