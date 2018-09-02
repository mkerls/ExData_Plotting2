setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')
SCC <- readRDS('~/exploring_data_analysis/Source_Classification_Code.rds')

# Coal combustion sources
SCC_coal <- SCC %>%
  mutate(SCC=as.character(SCC)) %>%
  filter(grepl('coal', EI.Sector, ignore.case=TRUE)) %>%
  select(SCC, Sector=EI.Sector, Short.Name)

# Sum coal combustion emissions
NEI_agg <-  NEI %>%
  inner_join(SCC_coal, by='SCC') %>%
  group_by(year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot4.png')
ggplot(NEI_agg, aes(as.factor(year), emissions / 10^3)) +
  geom_bar(stat='identity') +
  labs(title='Total Coal Combustion Emissions in the United States', x='Year', y='Emissions (thousand tons)') +
  theme_minimal()
dev.off()




# Get coal combustion emissions
NEI_agg <-  NEI %>%
  inner_join(SCC_coal, by='SCC') %>%
  group_by(Sector, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot4.png')
ggplot(NEI_agg, aes(year, emissions, color=Sector)) +
  geom_line(size=2) +
  theme_classic() +
  labs(title='Coal Combustion Emissions', x='Year', y='Emissions (tons)')
dev.off()
