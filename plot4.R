#Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get SCC values for coal combustion. Look in SCC.Level.One for combustion and in SCC.Level.Three for coal
SCC_coal <- as.character(SCC$SCC[grepl("coal", SCC$SCC.Level.Three, ignore.case=TRUE) & grepl("combustion", SCC$SCC.Level.One, ignore.case=TRUE)])

# Filter NEI data to just coal combustion
coal_emissions <- NEI[is.element(NEI$SCC, SCC_coal), ]

# Get total PM2.5 by year
totals <- aggregate(coal_emissions$Emissions, by=list(coal_emissions$year), FUN=sum)

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
png("plot4.png")
plot(totals, type="b", xlab="Year", main="Emissions From Coal Combustion By Year", ylab="PM2.5 In Tons")
dev.off()