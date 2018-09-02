setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')
SCC <- readRDS('~/exploring_data_analysis/Source_Classification_Code.rds')

baltimore <- '24510'
los_angeles <- '06037'

# Get motor vehicle sources
SCC_vehicle <- SCC %>%
  mutate(SCC = as.character(SCC)) %>%
  filter(grepl('vehicle', EI.Sector, ignore.case=TRUE)) %>%
  select(SCC, Sector=EI.Sector, Short.Name)

# Sum motor vehicle emissions
NEI_agg <- NEI %>%
  filter(fips %in% c(baltimore,los_angeles)) %>%
  mutate(City = ifelse(fips == baltimore, 'Baltimore City', 'Los Angeles County')) %>%
  inner_join(SCC_vehicle, by='SCC') %>%
  group_by(City, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot6.png')
ggplot(NEI_agg, aes(as.factor(year), emissions / 10^3)) +
  facet_grid(. ~ City) +
  geom_bar(stat='identity') +
  labs(title='Motor Vehicle Emissions', x='Year', y='Emissions (thousand tons)') +
  theme_bw()
dev.off()
