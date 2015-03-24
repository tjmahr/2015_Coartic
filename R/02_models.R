library("stringr")
library("magrittr")
library("dplyr", warn.conflicts = FALSE)
library("lme4")

source("R/00_lookr_imports.R")
mean_center <- function(xs) xs - mean(xs, na.rm = TRUE)

# Load looking data
looks <- read.csv("data/model_data.csv") %>% tbl_df %>%
  mutate(Condition = factor(Condition, levels = c("neutral", "facilitating")))

# Load child-level data
infos <- read.csv("data/subj.csv") %>%
  tbl_df %>%
  filter(is.na(Exclude)) %>%
  # mean-center predictors
  transmute(Subj = Subj, cAge =  mean_center(Age), cCDI = mean_center(CDI))

looks <- left_join(looks, infos, by = "Subj")




# First let's look at a basic model where looking patterns over time are
# estimated with a third-order polynomial. We allow the curvature of looking
# patterns to vary randomly within children.

# Dummy model with no condition effect
m_empty <- lmer(elogit ~ ot1 + ot2 + ot3 + (ot1 + ot2 + ot3 | Subj),
                weights = 1 / elogit_wt, REML = FALSE, looks)

# Next, allow the curves to interact with condition
m0 <- update(m_empty, . ~ . + (ot1 + ot2 + ot3) * Condition)

# We also expect children to vary randomly in their ability to pick up on
# coarticulatory information. We capture this variation by including
# child-by-condition random effects.
m1 <- update(m0, . ~ . + (ot1 + ot2 + ot3 | Subj:Condition))
summary(m1)

# Alternative (left-sided) random effects structure. Too many random effects
# covariances probably keep it from converging nicely.
m1b <- update(m0, . ~ . + ((ot1 + ot2 + ot3) * Condition | Subj))
summary(m1b)

main_models <- list(
  m_empty = m_empty,
  m_plus_cond = m0,
  m_cond_ranef = m1,
  m_cond_ranef_lhs = m1b)


# Add CDI scores to previous model to examine effect of vocabulary on intercept,
# condition, time and time x condition parameters

# intercept tests
m2a <- update(m1, . ~ . + cCDI)
m2b <- update(m2a, . ~ . + cCDI:Condition)

# time effects
m2c <- update(m2a, . ~ . + (ot1) * cCDI)
m2d <- update(m2a, . ~ . + (ot1 + ot2) * cCDI)
m2e <- update(m2a, . ~ . + (ot1 + ot2 + ot3) * cCDI)
cdi_models <- anova(m1, m2a, m2c, m2d, m2e)

# time x condition
m2f <- update(m2a, . ~ . + (ot1) * cCDI * Condition)
m2g <- update(m2a, . ~ . + (ot1 + ot2) * cCDI * Condition)
m2h <- update(m2a, . ~ . + (ot1 + ot2 + ot3) * cCDI * Condition)
cdi_inter <- anova(m1, m2b, m2f, m2g, m2h)

cdi_models <- list(
  cdi_time = list(m2a, m2c, m2d, m2e),
  cdi_time_cond = list(m2b, m2f, m2g, m2h))




# Add Age to previous model to examine effect of age on intercept, condition,
# time and time x condition parameters

# intercept tests
m3a <- update(m1, . ~ . + cAge)
m3b <- update(m1, . ~ . + cAge*Condition)

# time effects
m3c <- update(m1, . ~ . + (ot1) * cAge)
m3d <- update(m1, . ~ . + (ot1 + ot2) * cAge)
m3e <- update(m1, . ~ . + (ot1 + ot2 + ot3) * cAge)
age_models <- anova(m1, m3a, m3c, m3d, m3e)

# time x condition
m3f <- update(m1, . ~ . + (ot1) * cAge * Condition)
m3g <- update(m1, . ~ . + (ot1 + ot2) * cAge * Condition)
m3h <- update(m1, . ~ . + (ot1 + ot2 + ot3) * cAge * Condition)
age_inter <- anova(m1, m3b, m3f, m3g, m3h)

age_models <- list(
  age_time = list(m3a, m3c, m3d, m3e),
  age_time_cond = list(m3b, m3f, m3g, m3h))

# Bunlde up models together
models <- list(main = main_models, cdi = cdi_models, age = age_models)
save(models, file = "data/models.Rdata")
