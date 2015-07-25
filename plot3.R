library(dplyr)
library(ggplot2)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

baltimore <- filter(NEIds,fips=="24510")

baltimore.emission <- aggregate(baltimore$Emissions ~ baltimore$year + baltimore$type, data = baltimore, FUN = sum)
baltimore.emission$`baltimore$year` <- as.numeric(levels(baltimore.emission$`baltimore$year`))
names(baltimore.emission) <- c("Year", "Type", "Emission")
ggplot(data = baltimore.emission, aes(x = Year,y = Emission, color=Type, group=Type)) + geom_point() + geom_line() + labs(x="Year", y="Emissions", title="Total emissions in Baltimore City by Pollutant Type")

dev.copy(device = png, file="plot3.png", width=1366, height=768, units="px")
dev.off()
