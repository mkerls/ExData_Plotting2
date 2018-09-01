# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
# Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?
setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)
library(grid)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')
SCC <- readRDS('~/exploring_data_analysis/Source_Classification_Code.rds')

# Get coal combustion
SCC_vehicle <- SCC %>%
  mutate(SCC = as.character(SCC)) %>%
  filter(grepl('Vehicle', EI.Sector)) %>%
  select(SCC, EI.Sector)

# Sum emissions
NEI_agg <- NEI %>%
  filter(fips %in% c('06037','24510')) %>%
  mutate(City = ifelse(fips == '06037','Los Angeles','Baltimore')) %>%
  inner_join(SCC_vehicle, by='SCC') %>%
  group_by(City, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot6.png')
ggplot(NEI_agg, aes(year, emissions, color=City)) +
  geom_line(size=2) +
  theme_classic() +
  labs(title='Vehicle Emissions', x='Year', y='Emissions (tons)')
dev.off()
