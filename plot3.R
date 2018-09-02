setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')

baltimore <- '24510'

# Sum Baltimore City emissions
NEI_agg <- NEI %>%
  filter(fips == baltimore) %>%
  rename(Type = type) %>%
  group_by(Type, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot3.png')
ggplot(NEI_agg, aes(year, emissions, color=Type)) +
  geom_line(size=2) +
  labs(title='Total Emissions in Baltimore City', x='Year', y='Emissions (tons)') +
  theme_minimal()
dev.off()
