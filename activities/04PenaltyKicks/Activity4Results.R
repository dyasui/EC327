library(dplyr)
library(readr)
# Get results from Canvas csv export
results_df <- read_csv("activities/04PenaltyKicks/Activity4Results.csv") 

# get all values of Kicks
unique(results_df$Kick)
# get all values of Intercepts
unique(results_df$Intercept)
# relabel L, M, R strategy variations
Left_vals <- c("L","l","Left","left")
Middle_vals <- c("C","c","Center","Cener","center","M","m","Middle","middle")
Right_vals <- c("R","r","Right","right")
results_df <- results_df %>% 
  mutate(Kick = ifelse(Kick %in% Left_vals, "L", 
                       ifelse(Kick %in% Middle_vals, "M", 
                              ifelse(Kick %in% Right_vals, "R", NA))),
         Intercept = ifelse(Intercept %in% Left_vals, "L", 
                            ifelse(Intercept %in% Middle_vals, "M", 
                                   ifelse(Intercept %in% Right_vals, "R", NA)))
         )

# count how many times each strategy appears
results_df %>% 
  group_by(Kick) %>% 
  summarise(
    count = n()
  ) %>% 
  mutate(
    freq = count / sum(count)
  )
  
results_df %>% 
  group_by(Intercept) %>% 
  summarise(
    count = n()
  ) %>% 
  mutate(
    freq = count / sum(count)
  )

# count how many time each outcome appears
results_df %>% 
  filter_at(vars(Kick, Intercept), all_vars(!is.na(.))) %>% 
  group_by(Kick, Intercept) %>% 
  summarise(
    count = n()
  ) %>% 
  mutate(
    freq = count / sum(count)
  )

