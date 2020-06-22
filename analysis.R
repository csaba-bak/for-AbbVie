library(tidyverse)
library(ggplot2)

#read in the tables
load("rda/tidy-blood-type-table.rda")
load("rda/pop-blood-type-table.rda")

#filer
country_filter <- c("Japan","Russia", "United Kingdom")

filtered_tidy_blood_type <- tidy_blood_type %>% 
  filter(Country %in% country_filter)

filtered_pop_blood_type <- pop_blood_type %>%
  filter(Country %in% country_filter)

#class check
filtered_tidy_blood_type$Country <- as.factor(filtered_tidy_blood_type$Country)
filtered_tidy_blood_type$Blood_Type <- as.factor(filtered_tidy_blood_type$Blood_Type)
filtered_pop_blood_type$Country <- as.factor(filtered_pop_blood_type$Country)

#plotting
filtered_tidy_blood_type %>%
  ggplot(aes(Country, Percentage, col = Country)) +
  geom_bar(stat = "identity", width = 0.5) +
  facet_grid(~Blood_Type) +
  theme(axis.text = element_text(angle = 90, hjust = 1), legend.position = "none") +
  xlab("") +
  ylab("% of population") +
  ggtitle("ABO distribution in Japan, Russia and the United Kingdom")
ggsave("figs/blood-type.png")

filtered_pop_blood_type %>%
  ggplot(aes(x = Country, y = Population/1000000, col = Country)) +
  geom_bar(stat = "identity", width = 0.6) +
  coord_flip() +
  xlab("") +
  ylab("Population (million)") +
  theme(legend.position = "none") +
  ggtitle("Population of Japan, Russia and the United Kingdom")
ggsave("figs/population.png")