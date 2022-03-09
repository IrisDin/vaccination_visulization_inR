data <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-IrisDin/main/country_vaccinations.csv?token=GHSAT0AAAAAABQTGH73PLWKIPDBHWSFJVLEYRRTWGQ")
data_manu <- read.csv("https://raw.githubusercontent.com/info-201b-wi22/exploratory-analysis-IrisDin/main/country_vaccinations_by_manufacturer.csv?token=GHSAT0AAAAAABQTGH72JFRVQ36XIR3XIBG2YRRTXUA")


library(dplyr)
library(maps)
library(tidyverse)
library(ggplot2)

data.test <- data %>% group_by(country) %>% filter(date == max(as.Date(date))) %>% select(total_vaccinations, people_fully_vaccinated)
data.test <- data.test %>% mutate(vacc_usage = people_fully_vaccinated/total_vaccinations)
data.test$country[213] <- "USA"

world_shape <- map_data("world")
world_shape <- left_join(world_shape, data.test, by=c("region"= "country"))

ggplot(world_shape)+
  geom_polygon(mapping = aes(x = long, y = lat, group = group, fill = vacc_usage)) +
  scale_fill_continuous(low = 'pink', high ='red', labels = scales::label_number_si()) +
  labs(title = "The usage of vaccination group by country")