setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')
SCC <- readRDS('~/exploring_data_analysis/Source_Classification_Code.rds')

baltimore <- '24510'

# Get motor vehicle sources
SCC_vehicle <- SCC %>%
  mutate(SCC = as.character(SCC)) %>%
  filter(grepl('vehicle', EI.Sector, ignore.case=TRUE)) %>%
  select(SCC, Sector=EI.Sector, Short.Name)

# Sum Baltimore City emissions
NEI_agg <- NEI %>%
  filter(fips == baltimore) %>%
  inner_join(SCC_vehicle, by='SCC') %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot5.png')
ggplot(NEI_agg, aes(as.factor(year), emissions)) +
  geom_bar(stat='identity') +
  labs(title='Total Motor Vehicle Emissions in Baltimore City', x='Year', y='Emissions (tons)') +
  theme_minimal()
dev.off()
