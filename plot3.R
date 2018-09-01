setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')

# Sum emissions
NEI_agg <- NEI %>%
  filter(fips == '24510') %>%
  group_by(type, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot3.png')
ggplot(NEI_agg, aes(year, emissions, color=type)) +
  geom_line(size=2) +
  theme_classic() +
  labs(title='Baltimore Emissions', x='Year', y='Emissions (tons)')
dev.off()
