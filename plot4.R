setwd('~/exploring_data_analysis/ExData_Plotting2')

# Libraries
library(dplyr)
library(ggplot2)

# Read data
NEI <- readRDS('~/exploring_data_analysis/summarySCC_PM25.rds')
SCC <- readRDS('~/exploring_data_analysis/Source_Classification_Code.rds')

# Get coal combustion
SCC_coal <- SCC %>%
  mutate(SCC = as.character(SCC)) %>%
  filter(grepl('Coal', EI.Sector)) %>%
  select(SCC, EI.Sector)

# Sum emissions
NEI_agg <- NEI %>%
  inner_join(SCC_coal, by='SCC') %>%
  group_by(EI.Sector, year) %>%
  summarise(emissions = sum(Emissions)) %>%
  ungroup()

# Plot to png
png('plot4.png')
ggplot(NEI_agg, aes(year, emissions, color=EI.Sector)) +
  geom_line(size=2) +
  theme_classic() +
  labs(title='Coal Emissions', x='Year', y='Emissions (tons)')
dev.off()
