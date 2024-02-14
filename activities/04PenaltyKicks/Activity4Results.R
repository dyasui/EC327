library(tidyverse)
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
                              ifelse(Kick %in% Right_vals, "R", "NA"))),
         Intercept = ifelse(Intercept %in% Left_vals, "L", 
                            ifelse(Intercept %in% Middle_vals, "M", 
                                   ifelse(Intercept %in% Right_vals, "R", NA)))
         )

# count how many time each strategy appears
results_df %>% 
  summarise(KickL_IntL = count(Kick=="L" & Intercept=="L"),
            KickL_IntM = count(Kick=="L" & Intercept=="M"),
            KickL_IntR = count(Kick=="L" & Intercept=="R"),
            KickM_IntL = count(Kick=="M" & Intercept=="L"),
            KickM_IntM = count(Kick=="M" & Intercept=="M"),
            KickM_IntR = count(Kick=="M" & Intercept=="R"),
            KickR_IntL = count(Kick=="R" & Intercept=="L"),
            KickR_IntM = count(Kick=="R" & Intercept=="M"),
            KickR_IntR = count(Kick=="R" & Intercept=="R"),
            )
