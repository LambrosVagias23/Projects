# Programming with R - Group Project, Tilburg University, 2019-2020

# Names and u-numbers ---------------------------------------------------------
# Joshua Cordromp - 1266161
# Mert Gül - 2047211
# Ivan Helin - 2030061
# Pedro Ramalho - 2046845
# Lambros Vagias - 2045338

## Load packages ---------------------------------------------------------------
library(dplyr)
library(tidyr)
library(ggplot2)
library(caret)
# your own package
install.packages("randomForest")
library("randomForest")

## Research Questions ----------------------------------------------------------
# “How do audio features of a track influence its popularity?”

# So, in addition to the main research question, we also test the hypothesis 
# that the average length of the songs released after the creation of Spotify 
# (in 2008) is shorter than the songs released before Spotify exists.

# Finally, we also study if we can predict the genre of a song by its music 
# characteristics and find what are the main audio features that define a music genre.


## Load data -------------------------------------------------------------------
# The dataset is downloaded from Kaggle website:
# https://www.kaggle.com/iamsumat/spotify-top-2000s-mega-dataset

Spotify_2000 <- read.csv("input/Spotify_2000.csv", stringsAsFactors=FALSE)

spotifyVECTOR <-Spotify_2000$Top.Genre
Preprosseced_Spotify <- Spotify_2000

## Preprocessing - EDA ---------------------------------------------------------

# Recoding genre in more general levels to be able to be processed
spotifyVECTOR <- recode_factor(spotifyVECTOR,
                               `punk`= "Alternative",
                               `pop punk`= "Alternative",
                               `neo mellow`= "Alternative",
                               `mellow gold`= "Alternative",
                               `latin alternative`= "Alternative",
                               `happy hardcore`= "Alternative",
                               `german alternative rock `= "Alternative",
                               `dutch prog`= "Alternative",
                               `cyberpunk`= "Alternative",
                               `british alternative rock`= "Alternative",
                               `alternative country`= "Alternative",
                               `alternative dance`= "Alternative",
                               `alternative hip hop`= "Alternative",
                               `alternative metal`= "Alternative",
                               `alternative pop`= "Alternative",
                               `alternative pop rock`= "Alternative",
                               `alternative rock`= "Alternative",
                               `german alternative rock`="Alternative",
                               `blues`="Blues",
                               `blues rock`="Blues",
                               `stomp and holler`="Country",
                               `contemporary country`="Country",
                               `trance`="Electronic/Dance",
                               `gabba`="Electronic/Dance",
                               `europop`="Electronic/Dance",
                               `eurodance`="Electronic/Dance",
                               `electronica`="Electronic/Dance",
                               `electro house`="Electronic/Dance",
                               `edm`="Electronic/Dance",
                               `downtempo`="Electronic/Dance",
                               `diva house`="Electronic/Dance",
                               `disco`="Electronic/Dance",
                               `acid jazz`="Electronic/Dance",
                               `basshall`="Electronic/Dance",
                               `big beat`="Electronic/Dance",
                               `big room`="Electronic/Dance",
                               `electro`="Electronic/Dance",
                               `electropop`="Electronic/Dance",
                               `gangster rap`="Hip-Hop/Rap",
                               `east coast hip hop`="Hip-Hop/Rap",
                               `dutch hip hop`="Hip-Hop/Rap",
                               `detroit hip hop`="Hip-Hop/Rap",
                               `atl hip hop`="Hip-Hop/Rap",
                               `compositional ambient`="Instrumental",
                               `classic schlager`="Instrumental",
                               `latin jazz`="Jazz",
                               `bebop`="Jazz",
                               `contemporary vocal jazz`="Jazz",
                               `latin`="Latin",
                               `uk pop`="Pop",
                               `pop`="Pop",
                               `operatic pop`="Pop",
                               `new wave pop`="Pop",
                               `nederpop`="Pop",
                               `la pop`="Pop",
                               `italian pop`="Pop",
                               `irish pop`="Pop",
                               `indie pop`="Pop",
                               `hip hop`="Pop",
                               `german pop`="Pop",
                               `dutch pop`="Pop",
                               `danish pop`="Pop",
                               `dance pop`="Pop",
                               `classic uk pop`="Pop",
                               `classic italian pop`="Pop",
                               `classic country pop`="Pop",
                               `chamber pop`="Pop",
                               `candy pop`="Pop",
                               `canadian pop`="Pop",
                               `bubblegum pop`="Pop",
                               `britpop`="Pop",
                               `brill building pop`="Pop",
                               `boy band`="Pop",
                               `bow pop`="Pop",
                               `acoustic pop`="Pop",
                               `adult standards`="Pop",
                               `afropop`="Pop",
                               `art pop`="Pop",
                               `austropop`="Pop",
                               `baroque pop`="Pop",
                               `belgian pop`="Pop",
                               `hip pop`="Pop",
                               `barbadian pop`="Pop",
                               `neo soul`="R&B/Soul",
                               `motown`="R&B/Soul",
                               `g funk`="R&B/Soul",
                               `funk`="R&B/Soul",
                               `classic soul`="R&B/Soul",
                               `chicago soul`="R&B/Soul",
                               `british soul`="R&B/Soul",
                               `reggae`="Reggae",
                               `reggae fusion`="Reggae",
                               `yacht rock`="Rock",
                               `soft rock`="Rock",
                               `rock-and-roll`="Rock",
                               `modern rock`="Rock",
                               `modern folk rock`="Rock",
                               `irish rock`="Rock",
                               `hard rock`="Rock",
                               `glam rock`="Rock",
                               `glam metal`="Rock",
                               `garage rock`="Rock",
                               `finnish metal`="Rock",
                               `dutch rock`="Rock",
                               `dutch metal`="Rock",
                               `dance rock`="Rock",
                               `classical rock`="Rock",
                               `classic rock`="Rock",
                               `classic canadian`="Rock",
                               `canadian rock`="Rock",
                               `classic canadian rock`="Rock",
                               `album rock`="Rock",
                               `art rock`="Rock",
                               `belgian rock`="Rock",
                               `christelijk`="Vocal",
                               `chanson`="Vocal",
                               `ccm`="Vocal",
                               `british folk`="Folk",
                               `canadian folk`="Folk",
                               `folk-pop`="Folk",
                               `folk`="Folk",
                               `indie anthem-folk`="Folk",
                               `streektaal`="Word",
                               `scottish singer-songwriter`="Word",
                               `permanent wave`="Word",
                               `metropopolis`="Word",
                               `levenslied`="Word",
                               `laboratorio`="Word",
                               `j-core`="Word",
                               `irish singer-songwriter`="Word",
                               `icelandic indie`="Word",
                               `german pop rock`="Word",
                               `dutch indie`="Word",
                               `dutch cabaret`="Word",
                               `dutch americana`="Word",
                               `danish pop rock`="Word",
                               `classic soundtrack`="Word",
                               `celtic rock`="Word",
                               `celtic`="Word",
                               `celtic punk`="Word",
                               `carnaval limburg`="Word",
                               `british singer-songwriter`="Word",
                               `british invasion`="Word",
                               `alaska indie`="Word",
                               `arkansas country`="Word",
                               `australian alternative rock`="Word",
                               `australian americana`="Word",
                               `australain dance`="Word",
                               `australian indie folk`="Word",
                               `australian pop`="Word",
                               `australian psych`="Word",
                               `australian rock`="Word",
                               `australian dance`="Word")

Preprosseced_Spotify$Top.Genre <-spotifyVECTOR

# Evaluating the results
levels(factor(Preprosseced_Spotify$Top.Genre))

# Change names of the genres and filter out four songs that have NA as duration
Spotify <- Preprosseced_Spotify %>%
  rename(Genre = Top.Genre ) %>%
  rename(BPM = Beats.Per.Minute..BPM. ) %>%
  rename(Duration = Length..Duration. ) %>%
  rename(Loudness = Loudness..dB. ) %>%
  mutate(Duration = as.numeric(Duration)) %>%
  filter(is.na(Duration) == FALSE)

# Change of duration before and after Spotify
Avg_Duration <- Spotify %>%
  mutate(before_spotify = as.factor(
    ifelse(Year < 2008, "before spotify", "after spotify")))

ggplot(Avg_Duration, aes(x = before_spotify, y = Duration)) +
  geom_boxplot()

# Distribution of genres
ggplot(data = Spotify, aes(y = Genre)) +
  geom_bar()

# Histogram of popularity
ggplot(data = Spotify, aes(x = Popularity)) +
  geom_histogram()

# Histogram of the year that the songs were released
ggplot(data = Spotify, aes(x = Year)) +
  geom_histogram()

# Plotting the relationship between Danceability and Popularity
ggplot(data = Spotify, aes(x = Danceability, y = Popularity)) +
  geom_point() +
  geom_smooth()

# Genre averages for some audio features
genre_means <- Spotify %>%
  group_by(Genre) %>%
  summarize(BPM =  mean(BPM), Energy =  mean(Energy), 
            Speechiness =  mean(Speechiness))

ggplot(genre_means, aes(x = BPM, y = Genre)) +
  geom_bar(stat = "identity")

## K-Nearest Neighbors (KNN) Model ---------------------------------------------

# Create Data for Popularity Classification 
Audio_Features <- Spotify %>%
  select(-one_of("Index","Artist","Genre", "Title", "Year")) %>%
  mutate(Popularity = as.factor(ifelse((Popularity > 50) == TRUE, 
                                       "popular", "unpopular")))

# First we split our data set into a *training* and *test* sets.
set.seed(1)
trn_ind = createDataPartition(y = Audio_Features$Popularity, p = 0.8, list = FALSE)
trn_pop50 = Audio_Features[trn_ind, ]
tst_pop50 = Audio_Features[-trn_ind, ]

# Specify Model Classifying Popularity
# 5-fold cross-validation with binary classification
train_control <- trainControl(method = 'cv', number = 5, classProbs = TRUE,
                              summaryFunction = twoClassSummary)

# Parameter grid of k, going from 3 to 25 in steps of 2.
k_tuner <- data.frame(k = seq(3, 25, by = 2))

# Fit the model, optimizing for Specificity and centering and scaling all vars
set.seed(12)
pop_knn <- train(Popularity ~ ., method = "knn", 
                 data = trn_pop50, metric = "Spec",
                 trControl = train_control, tuneGrid = k_tuner,
                 preProcess = c("center", "scale"))

# Create the confusion matrix
pop_pred <- predict(pop_knn, tst_pop50)
knn_pop_conFM <- confusionMatrix(pop_pred, tst_pop50$Popularity)

# Print out all of the important results
pop_knn
knn_pop_conFM
varImp(pop_knn)

# Format Data Classifying Genre
# Create a factor out of genre so we can use it for classification
# Also remove all columns that are not necessary for predicting genre
Audio_Features_Genre <- Spotify %>%
  select(-one_of("Index","Artist","Popularity", "Title", "Year"))

# Create a fixed train/test split of the data that is balanced around genre
set.seed(12)
trn_ind = createDataPartition(y = Audio_Features_Genre$Genre, p = 0.8, list = FALSE)
trn_genre50 = Audio_Features_Genre[trn_ind, ]
tst_genre50 = Audio_Features_Genre[-trn_ind, ]

# Specify Model Classifying Music Genre
# 5-fold cross-validation with multiclass classification
train_control <- trainControl(method = 'cv', number = 5, classProbs = FALSE)

# Parameter grid of k, going from 3 to 25 in steps of 2.
k_tuner <- data.frame(k = seq(3, 25, by = 2))

# Fit the model, optimizing for Accuracy and centering and scaling all vars
set.seed(12)
genre_knn <- train(Genre ~ ., method = "knn", 
                   data = trn_genre50, metric = "Accuracy",
                   trControl = train_control, tuneGrid = k_tuner,
                   preProcess = c("center", "scale"))

# Create the confusion matrix
genre_pred <- predict(genre_knn, tst_genre50)
knn_confM_genre <- confusionMatrix(genre_pred, tst_genre50$Genre)

# Print out all of the important results
genre_knn
knn_confM_genre
varImp(genre_knn)

## Logistic Regression Model ---------------------------------------------------
  
# We use logistic regression model and predict popularity on the test set
set.seed(1)
popularity_lgr = train(Popularity ~ ., method = "glm",
                   family = binomial(link = "logit"), data = trn_pop50,
                   trControl = trainControl(method = 'cv', number = 5))

set.seed(1)
predict_lgr <- predict(popularity_lgr, tst_pop50)
lgt_confM <- confusionMatrix(predict_lgr, as.factor(tst_pop50$Popularity))
lgt_confM


## Third Model: Random Forest --------------------------------------------------

# Popularity
set.seed(1)
popularity_rf <- train(Popularity ~ ., method ="rf", data = trn_pop50,
                       trControl = trainControl(method = 'cv', number = 5,
                       summaryFunction = defaultSummary), metric = "Accuracy",
                       preProcess = c("center", "scale"), 
                       tuneGrid=expand.grid(mtry=c(1:20)))

# Evaluate the performance 
num_mtry <- popularity_rf$results['mtry']
accuracies <- popularity_rf$results['Accuracy']
results_rf <- data.frame(num_mtry, accuracies)
plot(results_rf, type="l", col="red")

predicted_outcomes_popularity_rf <- predict(popularity_rf, tst_pop50)

rf_confM_pop <- confusionMatrix(predicted_outcomes_popularity_rf, 
                                as.factor(tst_pop50$Popularity))

# Genre
set.seed(1)
genre_rf <- train(Genre ~ ., method ="rf", data = trn_genre50,
                  trControl = trainControl(method = 'cv', number = 5,
                  summaryFunction = defaultSummary), preProcess = c("center", "scale"),
                  metric="Accuracy", tuneGrid=expand.grid(mtry=c(1:20)))
                  
predicted_outcomes_genre_rf <- predict(genre_rf, tst_genre50)

rf_confM_genre <- confusionMatrix(predicted_outcomes_genre_rf, 
                                  as.factor(tst_genre50$Genre))
