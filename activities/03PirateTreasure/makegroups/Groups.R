# load packages
library(dplyr)
library(readr)
library(tidyr)
library(tibble)
library(ggplot2)
library(viridis)
library(ggthemes)

setwd("activities/03PirateTreasure")

PirateGroups <- read_csv("PirateGroups.csv") # %>% 
  # mutate(team = parse_number(group_name)) %>% 
  # switch order of names from (last, first) -> (first last)
  # mutate(name = sub("(\\w+),\\s(\\w+)","\\2 \\1", PirateGroups$name)) %>% 
  # select(name, team) %>% 
  # write_csv("PirateGroups.csv")

PirateGroups_tb <- PirateGroups %>% 
  group_by(team) %>% 
  mutate(order = row_number()) %>% 
  pivot_wider(names_from = order, values_from = name) %>% 
  arrange(team)

print(xtable(PirateGroups_tb))
