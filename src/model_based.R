## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------
library(ggplot2)
library(caret)
data(iris)


## --------------------------------------------------------------------------------------------------------------------------------
table(iris$Species)


## --------------------------------------------------------------------------------------------------------------------------------
inTrain <- createDataPartition(iris$Species, p = 0.7, list = FALSE)
training <- iris[inTrain,]
testing <- iris[-inTrain,]


## --------------------------------------------------------------------------------------------------------------------------------
modLDA <- train(Species ~ ., data = training, method = "lda") # Linear Discriminant
# modNB <-  train(Species ~ ., data = training, method = "nb")
plda <-  predict(modLDA, testing)
# pnb = predict(modNB, testing)
# table(plda, pnb)


## --------------------------------------------------------------------------------------------------------------------------------
# equalPredictions = (plda == pnb)
testing$predRight <- plda == testing$Species
table(plda, testing$Species)

qplot(Petal.Width, Petal.Length, color = predRight, data = testing, main = "newdata Predictions")

