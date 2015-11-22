library(ggplot2)
library(dplyr)

wd <- getwd()

setwd("2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


data <- filter(NEI, fips == "24510")

png(filename = "plot3.png", width = 480, height = 480, units = "px")

g <- ggplot(data, aes(year, Emissions, color = type))
print(g + geom_line(stat = "Summary", fun.y = "sum") 
        + ylab(expression('Total PM2.5 Emissions')) 
        + ggtitle("Total Emissions in Baltimore City from 1999 to 2008"))
dev.off()

setwd(wd)