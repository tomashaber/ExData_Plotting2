library(ggplot2)
library(dplyr)

wd <- getwd()

setwd("2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vSCC <- SCC[v,]$SCC
vNEI <- NEI[NEI$SCC %in% vSCC,]

baltimore <- filter(vNEI, vNEI$fips=="24510")
baltimore$city <- "Baltimore City"
la <- filter(vNEI, vNEI$fips=="06037")
la$city <- "Los Angeles County"

data <- rbind(baltimore,la)

png("plot6.png", width=480, height=480, units="px")

print(ggplot(data, aes(x=factor(year), y=Emissions, fill=city)) 
      + geom_bar(aes(fill=year),stat="identity") 
      + facet_grid(scales="free", space="free", .~city) 
      + guides(fill=FALSE)
      + labs(x="year", y=expression("Total PM2.5 Emission")) 
      + labs(title=expression("PM2,5 Motor Vehicle Source Emissions \n in Baltimore and Los Angeles County, 1999-2008")))

dev.off()
setwd(wd)