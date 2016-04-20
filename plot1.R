## Exploratory Data Analysis Assignment: Course Project 2
## Loading provided datasets

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

## Aggregate
Emissions <- aggregate(NEI[, 'Emissions'], by=list(NEI$year), FUN=sum)
Emissions$PM <- round(Emissions[,2]/1000,2)

## Total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Make a plot showing the total PM2.5 emission from all sources 
## for each of the years 1999, 2002, 2005, and 2008.
## Generate the graph 

png('plot1.png')
barplot(Emissions$PM, 
        names.arg=Emissions$Year,, 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions for years'))
dev.off()