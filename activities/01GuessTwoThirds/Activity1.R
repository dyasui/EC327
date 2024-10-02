library(tidyverse)

# Detect csv file with default Canvas export name
# in current working directory
export <- list.files(pattern = "*Student Analysis Report.csv") %>%
  sort(decreasing = TRUE) %>% head(1) # select most recent if multiple

# Get results from Canvas csv export
ClassData_df <- read_csv(export) %>% 
  rename(guess = "4401461: Choose your integer between 0 and 100") %>% 
  select(name, guess)

# Calculate average guess
average_guess <- ClassData_df %>% 
  summarise(mean(guess)) %>% 
  unlist() %>% unname()

winning_guess = average_guess*(2/3)

# Find closest match to average_guess * 2/3
winners <- ClassData_df %>% 
  filter(abs(guess - winning_guess) == min(abs(guess - winning_guess))) %>% 
  select(name)

# Plot distribution of guesses
library(ggplot2)
library(ggthemes)
ClassData_df %>% 
  ggplot(aes(x=guess)) +
  geom_histogram(binwidth = 2, fill="#69b3a2", color="#e9ecef", alpha=0.9) +
  geom_vline(xintercept = average_guess) +
  annotate("text", 
           x=average_guess-1.6, y=2.7, 
           label=paste0("average = ", average_guess), 
           angle=90) +
  geom_vline(xintercept = winning_guess, color = "#5517E8") +
  annotate("text", 
           x = winning_guess - 1.6, y = 2.7, 
           label=paste0("winners = ", winners), 
           angle=90,
           color = "#5517E8") +
  ggtitle("Distribution of Guessing 2/3rd's Game guesses") + 
  theme_stata()

ggsave("histogram.png")
