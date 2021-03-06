## ----setup, include=FALSE---------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_knit$set(base.dir = './images')


## ----message=FALSE----------------------------------------------------------------------------------------------------------------
library(caret)
library(kernlab)


## ---------------------------------------------------------------------------------------------------------------------------------
data(spam)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------------------
set.seed(32343)
fit <- train(type ~ ., data = training, method = 'glm')


## ---------------------------------------------------------------------------------------------------------------------------------
fit


## ---------------------------------------------------------------------------------------------------------------------------------
fit$finalModel


## ---------------------------------------------------------------------------------------------------------------------------------
predictions <- predict(fit, newdata = testing)
summary(predictions)

## ---------------------------------------------------------------------------------------------------------------------------------
confusionMatrix(predictions, testing$type)

