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

## Emissions from motor vehicle sources changed from 1999-2008 in Baltimore City
## Generate graph

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png("plot5.png")
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle in Baltimore City from 1999 to 2008')
print(g)
dev.off()