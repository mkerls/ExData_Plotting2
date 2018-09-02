setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')

baltimore <- '24510'

# Sum Baltimore City emissions
NEI_agg <- NEI %>%
  filter(fips == baltimore) %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot2.png')
barplot(NEI_agg$emissions, names.arg=NEI_agg$year, border=NA,
        main='Total Emissions in Baltimore City', xlab='Year', ylab='Emissions (tons)')
dev.off()
