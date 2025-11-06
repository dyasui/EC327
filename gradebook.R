library(tidyverse)

# Detect csv file with default Canvas export name
# in current working directorf
export <- list.files(pattern = "*_Grades-EC_327.csv") %>%
  sort(decreasing = TRUE) %>% head(1) # select most recent if multiple

grades <- read_csv(export) %>%
  filter(
    !row_number() %in% c(1, 2), # drop format rows
    !str_detect(Student, "Test") # drop test student
  ) %>%
  rename_with(~ .x %>%
      str_remove_all("\\s*\\(\\d+\\)") %>% # Remove assignment ID in parentheses
      str_to_lower() %>%                  # Convert to lowercase
      str_replace_all("[:space:]", "")    # Remove spaces
  ) %>%
  select(student,
         # hw0 = practicesubmission,
         hw1 = `homework1`,
         hw2 = `homework2:sequentialmoves`,
         hw3 = `homework3:simultaneousmoves`,
         hw4 = `homework4:combiningsimultaneous&sequential`,
         # ec,
         ac1 = `activity1:guess2/3rdstheaverage`,
         ac2 = `activity2:survivorflags`,
         # ac3 = `activity3:piratetreasure`,
         # ac4 = `activity4:electionblotto`,
         ac5 = `activity5:socialmediaadspace`,
         ac6 = `activity6:penaltyshootoutparticipation`,
         # ac7 = `activity7-brinksmanship`,
         # ac8 = `activity8:marketforlemons`,
         quiz = quizzesunpostedcurrentscore,
         homework = homeworkunpostedcurrentscore,
         activity = classactivitiescurrentscore,
         midterm,
         finalexam,
         score = unpostedcurrentscore) %>%
  mutate(across(hw1:score, as.numeric)) # %>%
  # mutate(ec = ifelse(is.na(ec), 0, as.numeric(ec)))

# plot midterm dist
library(ggplot2)
midterm_plot <- grades %>%
  ggplot() +
  geom_density(aes(x = midterm), fill = "darkblue", binwidth = 2.5) +
  geom_vline(xintercept = mean(grades$midterm, na.rm = TRUE)) +
  # xlim(25, max(grades$midterm) + 1) +
  scale_x_continuous(breaks = seq(0, 90, by = 5), limits=c(25, 95)) +
  labs(x = "Midterm Score (out of 90)",
    title = "EC327 Fall 2025 Midterm Exam Performance"
  ) 
ggsave(midterm_plot, file = "EC327F25-mt-score-distribution.png")

# plot final exam dist
library(ggplot2)
finalexam_plot <- grades %>%
  ggplot() +
  geom_histogram(aes(x = finalexam), fill = "purple", binwidth = 2.5) +
  geom_vline(xintercept = mean(grades$finalexam, na.rm = TRUE)) +
  xlim(25, max(grades$finalexam) + 1) +
  scale_x_continuous(breaks = seq(25, 100, by = 5), limits=c(25, 105)) +
  labs(x = "Final Exam Score (out of 90)",
    title = "EC327 Fall 2024 Final Exam Performance"
  ) 
ggsave(finalexam_plot, file = "EC327F24-finalexam-score-distribution.png")

# plot class grade distribution
grade_plot <- grades %>%
  ggplot() +
  geom_density(aes(x = score), fill = "darkgreen") +
  geom_vline(xintercept = mean(grades$score, na.rm = TRUE)) +
  xlim(50, max(grades$score) + 1) +
  theme_minimal() +
  # scale_x_continuous(breaks = seq(25, 100, by = 5), limits=c(25, 105)) +
  labs(x = "Percent Grade",
       title = "EC327 Fall 2025 Course Grades")
ggsave(grade_plot, file = "EC327F25-final-grade-distribution.png")

#### #### ####
final_grades <- grades %>%
  # simulate final grades
  mutate(
    midterm = midterm * (100/90),
    midterm_curved = (midterm/2) + 50,
    grade_curved = (.1*activity + .2*homework + .1*quiz + .3*midterm_curved + .3*midterm),
    # homework = ((hw1 + hw2 + hw3) / 120) * 100, # homework grade so far
    finalexam = midterm,
    # finalexam = rnorm(n = nrow(grades),
    #                   mean = mean(midterm, na.rm = TRUE),
    #                   sd = sd(midterm, na.rm = TRUE)),
    # finalexam = ifelse(finalexam < 100, round(finalexam), 100),
    grade_simulated = .1*activity + .2*homework + .1*quiz
      +.3 * midterm + .3*finalexam
  ) %>%
  select(
    activity, homework, quiz, 
    midterm, midterm_curved, finalexam,
    grade_curved, grade_simulated
  ) %>%
  print(n = 100)

# plot hypothetical final grades distribution
final_grade_plot <- final_grades %>% ggplot() +
  geom_density(aes(x = grade_simulated), fill = "purple") +
  labs(x = "Score (out of 100)",
       title = "Simulated Final Grade Distribution") +
  xlim(25, max(final_grades$grade_curved) + 1) +
  scale_x_continuous(breaks = seq(25, 100, by = 5), limits=c(25, 105))
ggsave(final_grade_plot, file = "EC327F25-final-sim-distribution.png")
