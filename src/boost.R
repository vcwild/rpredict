## ----setup, include=FALSE--------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## --------------------------------------------------------------------------------------------------------------------------------
library(ggplot2)
library(caret)
library(ISLR)
data(Wage)


## --------------------------------------------------------------------------------------------------------------------------------
Wage <- subset(Wage, select = -c(logwage))
inTrain <- createDataPartition(Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]


## ----message=FALSE, warning=FALSE------------------------------------------------------------------------------------------------
modFit <- train(wage ~ ., method = "gbm", data = training, verbose = FALSE)
modFit


## --------------------------------------------------------------------------------------------------------------------------------
qplot(predict(modFit, testing), wage, data = testing)

