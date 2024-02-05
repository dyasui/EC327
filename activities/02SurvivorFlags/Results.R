################################################################################
###                  Survivor Flags Game Results                             ###
################################################################################
#
# load packages
library(dplyr)
library(readr)
library(tidyr)
library(tibble)
library(ggplot2)
library(viridis)
library(ggthemes)
library(paletteer)

# get results from csv
results_df <- read_csv("activities/02SurvivorFlags/Results.csv")

# rollback solution is first team always leaves multiple of 4 flags
solution = tibble(
  # team = rep(1:2, length.out=11),
  round = 0:11,
  # taken = c(1, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3),
  flagsleft = c(21, 20, NA, 16, NA, 12, NA, 8, NA, 4, NA, 0)
  )

# Plot Game 1 results against backwards induction solution
results_df %>% filter(game==1) %>% 
  ggplot() +
  geom_point( # plot rollback solution
    data = solution,
    aes(x = round, y = flagsleft),
    shape = 0, size = 4) +
  geom_line(
    aes(x = round, y = flagsleft, 
        group = match_id, color=as.factor(match_id)),
    linetype = "dashed", linewidth = .5, alpha = .5
  ) +
  # geom_step(
  #   aes(x = round, y = flagsleft, group = match_id, color=as.factor(match_id)),
  #   direction = "vh", linetype = "solid", linewidth = .5, alpha = .5
  # ) +
  geom_point( # flags left at end
    aes( x = round, y = flagsleft,
         group = match_id, color=as.factor(match_id)),
    size = 2, 
  ) +
  labs(title = "Game 1 match histories",
       subtitle = "squares indicate rollback solution", ) +
  guides(color = guide_legend(title = "Match")) +
  ylab("flags left") +
  theme_bw() +
  theme(legend.position = c(.92, .7)) +
  scale_x_continuous(breaks = seq(1, 15, by = 2)) +
  scale_y_continuous(breaks = seq(0, 25, by = 4)) +
  scale_color_viridis_d(option = "H")

# Plot Game 2 results with starting points
results_df %>% filter(game==2) %>% 
  ggplot() +
  # geom_line( # plot rollback solutions for each ruleset
  #   aes( x = round, 
  #        # I think this is the right formula???
  #        y = (start_rule - (round * (take_rule + 1)) / 2),
  #        group = match_id, color=as.factor(match_id)),
  #   linetype = "dotted", linewidth = 1, alpha = .5) +
  geom_step(
    aes(x = round, y = flagsleft, 
        group = match_id, color=as.factor(match_id)),
    direction = "vh", linetype = "solid", linewidth = .5, alpha = .5
    ) +
  geom_point( # flags left at end
    aes( x = round, y = flagsleft, 
         group = match_id, color=as.factor(match_id)),
    size = 1.25, 
  ) +
  labs(title = "Game 2 match histories", 
       subtitle = "with different starting flags",
       ) +
  guides(color = guide_legend(title = "Match")) +
  ylab("flags left") +
  theme_bw() +
  theme(legend.position = c(.87, .73)) +
  scale_x_continuous(breaks = seq(1, 15, by = 2)) +
  scale_y_continuous(breaks = seq(0, 25, by = 4)) +
  scale_color_viridis_d(option = "H")

# How many times did the first team win?
results_df %>% 
  filter(flagsleft == 0) %>% # select winning rounds
  summarise(mean(movedfirst))

# Was there any learning between games?
results_df %>% 
  group_by(game) %>% 
  filter(flagsleft == 0) %>% # select winning rounds
  summarise(mean(movedfirst))

# Save winning teams
SurvivorGroup <- read_csv("SurvivorGroup.csv") %>% 
  mutate(team = parse_number(group_name))

winners <- results_df %>% 
  filter(flagsleft == 0) %>% 
  summarise(winning_teams = team) %>% 
  left_join(SurvivorGroup) %>% 
  select(3:6) %>% 
  summarise_all(winners = list(1,2,3,4))


# Simulate what the data would look like with randomly chosen flags
# 
sim_randflags <- function() {
  loser <- tibble(
    team = rep_len(rep(1:2, each = 1), length.out = 21),
    round = rep_len(1:21, length.out = 21),
    taken = rep_len(sample(c(1,2,3), size = 11, replace = TRUE), length.out = 21),
    flagsleft = rep(21 - cumsum(taken))
  ) %>% 
    filter(flagsleft %in% c(0,1,2)) %>% 
    slice_head(n=1) %>% 
    select(team)
}



# Plot actual results against simulated results
results_df %>% filter(game==1) %>%
  ggplot() +
  geom_line(aes(x=round, y=flagsleft, 
                group=match_id, color=as.factor(match_id)),
            linetype = "dotdash") +
  geom_line(data = simresults_df, 
            aes(x=round, y=flagsleft))


  