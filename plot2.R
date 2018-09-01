setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')

# Sum emissions
NEI_agg <- NEI %>%
  filter(fips == '24510') %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot2.png')
plot(NEI_agg$year, NEI_agg$emissions, type='b', main='Baltimore Emissions', xlab='Year', ylab='Emissions (tons)')
dev.off()
