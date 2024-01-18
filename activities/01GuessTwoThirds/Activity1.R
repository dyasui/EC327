library(readr)
library(dplyr)
setwd("activities/01GuessTwoThirds")
# Get results from Canvas csv export
ClassData_df <- read_csv("results.csv") %>% 
  # rename(guess = "3950918: What is your guess?") %>% 
  select(name, guess)

# Calculate average guess
average_guess <- ClassData_df %>% 
  summarise(mean(guess)) %>% 
  unlist() %>% unname()

average_guess
winning_guess = average_guess*(2/3)

# Find closest match to average_guess * 2/3
winners <- ClassData_df %>% 
  filter(abs(guess - winning_guess) == min(abs(guess - winning_guess))) %>% 
  select(name)

winners

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
