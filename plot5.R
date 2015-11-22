library(ggplot2)
library(dplyr)

wd <- getwd()

setwd("2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


v <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vSCC <- SCC[v,]$SCC
vNEI <- NEI[NEI$SCC %in% vSCC,]
data <- filter(vNEI, vNEI$fips=="24510")

png("plot5.png", width=480, height=480, units="px")

print(ggplot(data,aes(factor(year),Emissions)) 
      + geom_bar(stat="identity",fill="red",width=0.9) 
      + theme_bw() 
      + guides(fill=FALSE) 
      + labs(x="year", y=expression("Total PM2,5 Emission (10^5 Tons)")) 
      + labs(title=expression("PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999-2008")))

dev.off()
setwd(wd)