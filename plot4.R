library(ggplot2)
library(dplyr)

wd <- getwd()

setwd("2")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

combValues <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalValues <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
bothSCC <- SCC[combustionRelated & coalRelated,]$SCC
bothNEI <- NEI[NEI$SCC %in% bothSCC,]

png("plot4.png",width=480,height=480,units="px",bg="transparent")


print(ggplot(bothNEI,
  aes(factor(year),Emissions)) 
  +geom_bar(stat="identity",fill="red",width=0.9) 
  +theme_bw() +  guides(fill=FALSE) 
  +labs(x="year", y=expression("Total PM2.5 Emission")) 
  +labs(title=expression("PM2.5 Coal Combustion \n Source Emissions Across US from 1999-2008")))

dev.off()
setwd(wd)
