#Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get SCC values for vehicles Look in SCC.Level.Two for the vehicle
SCC_vehicles <- as.character(SCC$SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)])

# Get vehicle emissions in baltmire
vehicle_emissions <- NEI[is.element(NEI$SCC, SCC_vehicles), ]
balt_vehicle_emissions <- vehicle_emissions[vehicle_emissions$fips == "24510", ]
la_vehicle_emissions <- vehicle_emissions[vehicle_emissions$fips == "06037", ]

# Get total PM2.5 by year
balt_totals <- aggregate(balt_vehicle_emissions$Emissions, by=list(balt_vehicle_emissions$year), FUN=sum)
colnames(balt_totals) <- c("Year", "Total")
la_totals <- aggregate(la_vehicle_emissions$Emissions, by=list(la_vehicle_emissions$year), FUN=sum)
colnames(la_totals) <- c("Year", "Total")

# Calculate difference for each year as percentage of 199 levels
balt_totals$PctChange = (balt_totals$Total/balt_totals$Total[balt_totals$Year == 1999]) * 100
la_totals$PctChange = (la_totals$Total/la_totals$Total[la_totals$Year == 1999]) * 100

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
png("plot6.png")
plot(balt_totals$Year, y=balt_totals$PctChange, type="b", col="red", xlab="Year", main="Emissions From Vehicles By Year", ylab="PM2.5 as a Percentage of 1999 Levels", ylim=c(0,150))
points(la_totals$Year, y=la_totals$PctChange, type="b", col="blue")
legend("topleft",  col = c("red", "blue"), legend = c("Baltimore City", "Los Angeles County"), lty=c(1,1))
dev.off()