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

## Emissions from coal combustion-related sources changed from 1999-2008
## Generate the graph

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEISCC, sum)

png("plot4.png")
g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal combustion from 1999 to 2008')
print(g)
dev.off()