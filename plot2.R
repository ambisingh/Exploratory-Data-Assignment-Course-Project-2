## Exploratory Data Analysis Assignment: Course Project 2
## Loading provided datasets

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## From 1999 to 2008
## Use fips == 24510  
## Use the base plotting system to make a plot
## Generate the graph 

subsetNEI  <- NEI[NEI$fips=="24510", ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)

png('plot2.png')
barplot(height=aggregatedTotalByYear$Emissions, 
        names.arg=aggregatedTotalByYear$year, 
        xlab="Years", 
        ylab=expression('TotalPM'[2.5]*' emission'),
        main=expression('TotalPM'[2.5]*' in the Baltimore City, MD emissions'))
dev.off()