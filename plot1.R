#Read the data
NEI <- readRDS("summarySCC_PM25.rds")

# Get total PM2.5 by year
totals <- aggregate(NEI$Emissions, by=list(NEI$year), FUN=sum)

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
png("plot1.png")
plot(totals, type="b", xlab="Year", main="Total Emissions By Year", ylab="PM2.5 in tons")
dev.off()