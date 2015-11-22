library(dplyr)

wd <- getwd()

setwd("2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data <- NEI %>% select(Emissions,year) %>% filter(!is.na(Emissions)) %>% group_by(year) %>% summarize(sum = sum(Emissions))

png(filename='plot1.png', width=480, height=480, units='px')
plot(data, type="l", xlab="year", ylab="Total PM2.5 Emmision From All Sources Between 1999-2008", 
     col="dark red", xaxt="n", main="Total Emissions (tons)")
axis(1, at=as.integer(data$year), las=1)
dev.off()


setwd(wd)