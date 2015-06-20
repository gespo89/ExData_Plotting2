# Read the data
NEI <- readRDS("summarySCC_PM25.rds")

# Get just the data for baltimore
bmoreNEI <- NEI[NEI$fips == "24510", ]

# Get total PM2.5 by year and type
totals <- aggregate(bmoreNEI$Emissions~bmoreNEI$year+bmoreNEI$type, FUN=sum)
colnames(totals) <- c("Year", "Type", "PM2.5")

# This keeps us from getting scientific notation on the y-axis
options(scipen = 5)

# Make the plot
library("ggplot2")
qplot(Year, PM2.5, data=totals, main="Baltimore PM2.5 Emissions", geom="line", facets=Type~.)
ggsave("plot3.png", width=6, height=6, dpi=80)