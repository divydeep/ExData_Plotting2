library(dplyr)

NEIds <- readRDS(file = "summarySCC_PM25.rds")
SCCds <- readRDS(file = "Source_Classification_Code.rds")
NEIds$year <- factor(NEIds$year)

total.emission <- aggregate(NEIds$Emissions ~ NEIds$year,data = NEIds,FUN = sum)
total.emission$`NEIds$year` <- as.numeric(levels(total.emission$`NEIds$year`))
plot(x = total.emission$`NEIds$year`, y = total.emission$`NEIds$Emissions`, type="b",pch=20, xlab = "Year", ylab = "Emissions",main = "Total emissions by year", xaxp=c(1999,2008,9))

dev.copy(device = png, file="plot1.png", width=1366, height=768, units="px")
dev.off()