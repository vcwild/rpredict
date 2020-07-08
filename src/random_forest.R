## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------
data(iris)
library(ggplot2)
library(caret)
library(randomForest)


## --------------------------------------------------------------------------------------------------------------------------------
inTrain <- createDataPartition(iris$Species, p = 0.7, list = FALSE)

training <- iris[inTrain,]
testing <- iris[-inTrain,]


## --------------------------------------------------------------------------------------------------------------------------------
modFit <- train(Species ~ ., data = training, method = "rf", prox = TRUE)
modFit


## --------------------------------------------------------------------------------------------------------------------------------
getTree(modFit$finalModel, k = 2)


## --------------------------------------------------------------------------------------------------------------------------------
irisP <- classCenter(training[, c("Petal.Length", "Petal.Width")], label = training$Species, prox = modFit$finalModel$prox)
irisP <- as.data.frame(irisP)
irisP$Species <- rownames(irisP)
qplot(Petal.Width, Petal.Length, col = Species, data = training) + 
    geom_point(data = irisP, aes(Petal.Width, Petal.Length, col = Species), size = 5, shape = 4)


## --------------------------------------------------------------------------------------------------------------------------------
pred <- predict(modFit, testing)
testing$predRight <- pred == testing$Species
table(pred, testing$Species)


## --------------------------------------------------------------------------------------------------------------------------------
qplot(Petal.Width, Petal.Length, color = predRight, data = testing, main = "newdata Predictions")

