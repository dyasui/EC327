library(dplyr)
library(readr)
library(knitr)
library(kableExtra)
# Get results from Canvas csv export
results_df <- read_csv("activities/05LemonsMarket/Results.csv") %>% 
  rename(
    group = "Group Number",
    round = "Round Number",
    model = "Car Model:",
    buyer = "Buyer:",
    price = "Price:",
    resale_price = "Resale Value:",
    dealer = "Dealer Name",
    daler_profit = "Dealer Profit",
    cartype = "Lemon?")

# get recorded values of cartype column
unique(results_df$cartype)
# relabel cartypes as unified names
lemons <- c("Yes","yes","Lemon","lemon")
goods  <- c("No","no","Good","good")
results_df <- results_df %>% 
  mutate(cartype = ifelse(cartype %in% lemons, "lemon", 
                       ifelse(cartype %in% goods, "good",  NA))
         )
