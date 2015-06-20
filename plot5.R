#Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get SCC values for vehicles Look in SCC.Level.Two for the vehicle
SCC_vehicles <- as.character(SCC$SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)])

# Get vehicle emissions in baltmire
vehicle_emissions <- NEI[is.element(NEI$SCC, SCC_vehicles), ]
balt_vehicle_emissions <- vehicle_emissions[vehicle_emissions$fips == "24510", ]

# Get total PM2.5 by year
totals <- aggregate(balt_vehicle_emissions$Emissions, by=list(balt_vehicle_emissions$year), FUN=sum)

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
png("plot5.png")
plot(totals, type="b", xlab="Year", main="Emissions From Vehicles By Year", ylab="PM2.5 In Tons")
dev.off()