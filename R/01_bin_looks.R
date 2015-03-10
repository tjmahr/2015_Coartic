library("magrittr")
library("dplyr", warn.conflicts = FALSE)
library("reshape2")
source("R/lookr_exports.R")
options(stringsAsFactors = FALSE)

# Get the labeled gaze locations for looks during the analysis window
gaze <- read.csv("data/gazes.csv") %>%
  as_data_frame %>%
  select(-XMean, -YMean, -GazeByAOI)

# Get the experimental condition of each trial
stim <- read.csv("data/trials.csv") %>%
  as_data_frame %>%
  select(Subj:TrialNo, Condition = StimType)

# Count the looks to each area of interest
looks <- left_join(gaze, stim)
look_counts <- looks %>%
  aggregate_looks(Subj + Condition + Time ~ GazeByImageAOI) %>%
  as_data_frame %>%
  select(-Elsewhere, -NAs, -Others, -Proportion)

# Downsample data into 50ms bins
binned <- look_counts %>%
  # Assign bin numbers
  group_by(Subj, Condition) %>%
  mutate(Bin = assign_bins(Time, bin_width = 3)) %>%
  # Add up the looks to each AOI in each bin.
  group_by(Subj, Condition, Bin) %>%
  summarise(
    # Round to nearest 10ms (effectively nearest 50ms)
    Time = round(mean(Time), -1),
    ToDistractor = sum(Distractor),
    ToTarget = sum(Target))

# Compute looking probabilities
binned %<>%
  mutate(
    elogit = empirical_logit(ToTarget, ToDistractor),
    elogit_wt = empirical_logit_weight(ToTarget, ToDistractor),
    Proportion = ToTarget / (ToTarget + ToDistractor)) %T>%
  write.csv("data/binned_looks.csv", row.names = FALSE)

# Subset down to analysis window and experimental conditions
model_ready <- binned %>%
  filter(between(Time, 175, 1025), Condition != "filler") %>%
  # Renumber bins in this subset
  mutate(Bin = seq_along(Bin))

# Create orthogonal polynomials for time
orth_times <- model_ready$Bin %>%
  orthogonal_time(degree = 3) %>%
  rename(Bin = Time)

# Include orthogonal times
model_ready <- left_join(model_ready, orth_times) %T>%
  write.csv("data/model_data.csv", row.names = FALSE)
