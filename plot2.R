# Read the data
NEI <- readRDS("summarySCC_PM25.rds")

# Get just the data for baltimore
bmoreNEI <- NEI[NEI$fips == "24510", ]

# Get total PM2.5 by year
totals <- aggregate(bmoreNEI$Emissions, by=list(bmoreNEI$year), FUN=sum)

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
png("plot2.png")
plot(totals, type="b", xlab="Year", ylab="Total PM2.5 in tons")
dev.off()