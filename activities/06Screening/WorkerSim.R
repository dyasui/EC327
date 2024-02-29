library(tidyverse)

types <- tibble(
  Type = c("High-Risk", "Low-Risk"),
  Endowment = rep(1000000, length.out = 2),
  Risk      = ifelse(Type=="High-Risk",     2/3,     1/3),
)

N=10

sample <- 
  sample_n(types, size = N, replace = TRUE, weight = c(.39,.6)) %>% 
  mutate(
    BadLuck   = runif(n = N, min=0,max=1),
    Accident  = ifelse(BadLuck < Risk, 1, 0),
    )

coverage_low  = 500000
cost_low      = 10000
coverage_high = 750000
cost_high     = 500000
  
  EU= Risk*sqrt(Endowment - 750000 + coverage - cost) + (1-Risk)*sqrt(Endowment - cost)

sample %>% 
  mutate(EU_low = 
           Risk*sqrt(Endowment - 750000 + coverage_low - cost_low) +
           (1-Risk)*sqrt(Endowment - cost_low),
         EU_high = 
           Risk*sqrt(Endowment - 750000 + coverage_high - cost_high) + 
           (1-Risk)*sqrt(Endowment - cost_high),
         EU_noplan = 
           Risk*sqrt(Endowment - 750000) + (1-Risk)*sqrt(Endowment)) %>% 
  mutate(cost_paid = ifelse((EU_high >= EU_low) & (EU_high >= EU_noplan), cost_high,
                            ifelse((EU_low >= EU_high) & (EU_low >= EU_noplan), cost_low, 0)))

calculate_profit = function(coverage_low, coverage_high, cost_low, cost_high, N=10) {
  types <- tibble(
    Type            = c("High-Risk", "Low-Risk"),
    Endowment       = c(    1000000,    1000000),
    Risk            = ifelse(Type=="High-Risk",     2/3,     1/3)
  )
  
  sample_n(types, size=N, weight = c(.39,.61), replace = TRUE) %>% 
    mutate(Accident = sample(c(1,0), size = 1, replace = TRUE, prob = c(Risk, (1-Risk))))
}
