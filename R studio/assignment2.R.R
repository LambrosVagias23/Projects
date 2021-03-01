## Lambros vagias
## u803120

## Load packages ---------------------------------------------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(caret)

## Load data -------------------------------------------------------------------
modality <- read.csv("E:/input/modality.csv", stringsAsFactors = FALSE)
concreteness <- read.csv("E:/input/concreteness.csv", stringsAsFactors = FALSE)
AoA <- read.csv("E:/input/AoA.csv", stringsAsFactors = FALSE)

## Exercise 1 ------------------------------------------------------------------
q1 <- modality %>%
  mutate(auditory = ifelse(auditory > mean(auditory), "high", "low")) %>%
  mutate(gustatory = ifelse(gustatory > mean(gustatory), "high", "low")) %>%
  mutate(haptic = ifelse(haptic > mean(haptic), "high", "low")) %>%
  mutate(olfactory = ifelse(olfactory > mean(olfactory), "high", "low")) %>%
  mutate(visual = ifelse(visual > mean(visual), "high", "low"))

answer1 <- q1

## Exercise 2 ------------------------------------------------------------------

q2 <- modality %>%
  mutate(exclusivity = apply(modality[, 2:6], 1, max) / apply(modality[, 2:6], 1, sum))

answer2 <- q2
## Exercise 3 ------------------------------------------------------------------
q3 <- pivot_longer(modality,
  cols = c(auditory, gustatory, haptic, olfactory, visual),
  names_to = "modality_type",
  values_to = "modality_score"
)
answer3 <- q3

## Exercise 4 ------------------------------------------------------------------
q4 <- AoA %>%
  group_by(WORD) %>%
  summarize(smallest_AoA = min(AoA)) %>%
  arrange(smallest_AoA, WORD)

answer4 <- q4


## Exercise 5 ------------------------------------------------------------------
q5 <- inner_join(modality, concreteness, by = c("word" = "Word"))
answer5 <- q5


## Exercise 6 ------------------------------------------------------------------
q6 <- concreteness %>%
  mutate(dominant_position = ifelse(dominant_position == "Noun", "Noun", "Not Noun"))
set.seed(1)
dominant_KNN <- train(dominant_position ~ . - Word,
  method = "knn", data = q6,
  trControl = trainControl(method = "cv", number = 5),
  tuneGrid = data.frame(k = c(3, 5))
)
answer6 <- dominant_KNN

## Exercise 7 ------------------------------------------------------------------
set.seed(1)

dominant_LRM <- train(dominant_position ~ (concreteness * freq_by_million),
  method = "glm", data = q6, family = binomial(link = "logit"),
  trControl = trainControl(method = "cv", number = 3)
)

answer7 <- dominant_LRM
## Exercise 8 ------------------------------------------------------------------
q8 <- inner_join(AoA, concreteness, by = c("WORD" = "Word")) %>%
  filter(dominant_position == "Verb" | dominant_position == "Noun") %>%
  mutate(concreteness = concreteness * 2) %>%
  mutate(AoA = ifelse(AoA <= 3, "toddlerhood", ifelse(AoA >= 7, "middle childhood", "early childhood")))

answer8 <- ggplot(q8, aes(x = AoA, y = concreteness, fill = dominant_position)) +
  geom_boxplot(position = position_dodge(1)) +
  scale_x_discrete(limits = c("toddlerhood", "early childhood", "middle childhood"))
## Exercise 9 ------------------------------------------------------------------
word_complete_data <- read.csv("E:/input/word_complete_data.csv", stringsAsFactors = FALSE)

answer9 <- word_complete_data %>%
  filter(!is.na(dominant_position)) %>%
  filter(dominant_position != "#N/A") %>%
  filter(dominant_position != "Unclassified") %>%
  mutate(freq_by_million = na_if(freq_by_million, 0)) %>%
  mutate(freq_by_million = ifelse(is.na(freq_by_million) == TRUE, mean(freq_by_million, na.rm = TRUE), freq_by_million)) %>%
  mutate(freq_by_million = log(freq_by_million / 1000000)) %>%
  rename(log_freq = freq_by_million) %>%
  rename(auditory_mod = auditory, gustatory_mod = gustatory, olfactory_mod = olfactory, visual_mod = visual, by_early_childhood = AoA) %>%
  mutate(by_early_childhood = ifelse(by_early_childhood < 7, "yes", "no")) %>%
  mutate(auditory_mod = ifelse(is.na(auditory_mod) == TRUE, mean(auditory_mod, na.rm = TRUE), auditory_mod)) %>%
  mutate(gustatory_mod = ifelse(is.na(gustatory_mod) == TRUE, mean(gustatory_mod, na.rm = TRUE), gustatory_mod)) %>%
  mutate(olfactory_mod = ifelse(is.na(olfactory_mod) == TRUE, mean(olfactory_mod, na.rm = TRUE), olfactory_mod)) %>%
  mutate(visual_mod = ifelse(is.na(visual_mod) == TRUE, mean(visual_mod, na.rm = TRUE), visual_mod)) %>%
  mutate(haptic = ifelse(is.na(haptic) == TRUE, mean(haptic, na.rm = TRUE), haptic)) %>%
  mutate(exclusitivity = ifelse(is.na(exclusitivity) == TRUE, mean(exclusitivity, na.rm = TRUE), exclusitivity))
## Exercise 10 ------------------------------------------------------------------
word_numeric_data <- read.csv("E:/input/word_numeric_data.csv", stringsAsFactors = FALSE)
set.seed(1)
q10 <- word_numeric_data %>%
  select(-c(word, dominant_position))

train_index <- createDataPartition(y = q10$by_early_childhood, p = 0.60, list = FALSE)
train_by_early_childhood <- q10[train_index, ]
test_by_early_childhood <- q10[-train_index, ]

by_early_childhood_KNN <- train(by_early_childhood ~ .,
  method = "knn", data = train_by_early_childhood,
  trControl = trainControl(
    method = "cv", number = 5, classProbs = TRUE,
    summaryFunction = prSummary
  ), metric = "Recall",
  preProcess = c("center", "scale")
)

predicted_outcomes_mR <- predict(by_early_childhood_KNN, test_by_early_childhood)

knn_mR_confusionMatrix <- confusionMatrix(predicted_outcomes_mR, as.factor(test_by_early_childhood$by_early_childhood))
knn_mR_confusionMatrix

Precision <- knn_mR_confusionMatrix$byClass["Precision"]
Recall <- knn_mR_confusionMatrix$byClass["Recall"]

answer10 <- c(Precision, Recall)

