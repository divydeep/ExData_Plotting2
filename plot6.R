library(dplyr)
library(ggplot2)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

vehicle <- SCCds[grep(pattern = "Mobile Sources", x = SCCds$SCC.Level.One),]
vehicle.scc <- vehicle$SCC
vehicleDS <- NEIds[NEIds$SCC %in% vehicle.scc,]

BLvehicle <- filter(vehicleDS, fips == "24510")
LAvehicle <- filter(vehicleDS, fips == "06037")
totalVehicle <- rbind(BLvehicle, LAvehicle)

totalVehicle.emission <- aggregate(totalVehicle$Emissions ~ totalVehicle$year + totalVehicle$fips, data = totalVehicle, FUN = sum)

#ggplot(totalVehicle.emission, aes(Year, Emissions, color=FIPS, group=FIPS)) + geom_point() + geom_line() + facet_grid(scales="free", space="free", .~FIPS) + guides(color="none") + ggtitle("Motor Vehicle Emissions in Baltimore and Los Angeles")
ggplot(totalVehicle.emission, aes(Year, Emissions)) + geom_bar(aes(fill=Year),stat="identity") + facet_grid(scales="free", space="free", .~FIPS) + guides(fill=FALSE) + ggtitle("Motor Vehicle Emissions in Los Angeles and Baltimore")

dev.copy(device = png, file="plot6.png", width=1366, height=768, units="px")
dev.off()
