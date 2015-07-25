library(dplyr)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

baltimore <- filter(NEIds,fips=="24510")
baltimore.emission <- aggregate(baltimore$Emissions ~ baltimore$year, data = baltimore, FUN = sum)
baltimore.emission$`baltimore$year` <- as.numeric(levels(baltimore.emission$`baltimore$year`))
plot(x = baltimore.emission$`baltimore$year`,y = baltimore.emission$`baltimore$Emissions`, type = "b", pch=20, xlab = "Year", ylab = "Emissions",main = "Total emissions by year in Baltimore City", xaxp=c(1999,2008,9))

dev.copy(device = png, file="plot2.png", width=1366, height=768, units="px")
dev.off()
