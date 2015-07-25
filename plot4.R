library(dplyr)
library(ggplot2)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

coal <- SCCds[grep(pattern = "coal",x = SCCds$SCC.Level.Three, ignore.case = T),]
coal.scc <- coal$SCC
coal.emission <- NEIds[NEIds$SCC %in% coal.scc,]
coal.emission2 <- aggregate(coal.emission$Emissions ~ coal.emission$year, data = coal.emission, FUN = sum)
names(coal.emission2) <- c("Year", "Emissions")
coal.emission2$Year <- as.numeric(levels(coal.emission2$Year))

ggplot(data = coal.emission2, aes(x = Year, y = Emissions)) + geom_point() + geom_line() + ggtitle("Emissions from Coal Combustion")

dev.copy(device = png, file="plot4.png", width=1366, height=768, units="px")
dev.off()