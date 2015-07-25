library(dplyr)
library(ggplot2)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

baltimore <- filter(NEIds,fips=="24510")
vehicle <- SCCds[grep(pattern = "Mobile Sources", x = SCCds$SCC.Level.One),]
vehicle.scc <- vehicle$SCC
baltimore.emission <- baltimore[baltimore$SCC %in% vehicle.scc,]
baltimore.emission2 <- aggregate(baltimore.emission$Emissions ~ baltimore.emission$year, data = baltimore.emission, FUN = sum)
names(baltimore.emission2) <- c("Year", "Emissions")
baltimore.emission2$Year <- as.numeric(levels(baltimore.emission2$Year))

ggplot(data = baltimore.emission2, aes(x = Year,y = Emissions)) + geom_point() + geom_line() + ggtitle("Motor Vehicle Emissions in Baltimore City")

dev.copy(device = png, file="plot5.png", width=1366, height=768, units="px")
dev.off()
