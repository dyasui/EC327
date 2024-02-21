# the probability each outcome is reached in the equilibrium calculated in class:
eqm <- c(.45*.45, .45*.1, .45*.45, .1*.45, .1*.1, .1*.45, .45*.45, .45*.1, .45*.45)
# out of 1417 matches, how many would we expect of each outcome:
exp_data <- round(eqm * 1417, digits = 0)

# actual data on counts of each match observed played by pro soccer players:
data <- c(278, 13, 310, 51, 4, 51, 307, 7, 391)

# compare our expected vs observed data in the same table:
table <- tibble(exp_data, data)

# use a Chi-squared test to the null hypothesis 
# that the expected frequencies are equal to the observed data:
table %>% 
  chisq.test()
