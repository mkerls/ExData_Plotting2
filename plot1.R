setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')

# Sum emissions
NEI_agg <- NEI %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot1.png')
barplot(NEI_agg$emissions / 10^6, names.arg=NEI_agg$year, border=NA,
        main='Total Emissions in the United States', xlab='Year', ylab='Emissions (million tons)')
dev.off()
