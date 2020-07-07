## ----setup, include=FALSE---------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------------------------------------------------------------------------------------------------------
library(ISLR)
library(caret)
library(ggplot2)
data(Wage)

Wage <- subset(Wage, select = -c(logwage))

summary(Wage)


## ---------------------------------------------------------------------------------------------------------------------------------
inTrain <- createDataPartition(y = Wage$wage, p = 0.7, list = FALSE)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]

dim(training)
dim(testing)


## ---------------------------------------------------------------------------------------------------------------------------------
featurePlot(
    x = training[, c("age", "education", "jobclass")], 
    y = training$wage, 
    plot = "pairs"
)


## ---------------------------------------------------------------------------------------------------------------------------------
qplot(age, wage, color = jobclass, data = training)


## ---------------------------------------------------------------------------------------------------------------------------------
qplot(age, wage, color = education, data = training)


## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------------------
modFit <- train(wage ~ age + jobclass + education, method = "lm", data = training)

print(modFit)


## ---------------------------------------------------------------------------------------------------------------------------------
finMod <- modFit$finalModel

plot(finMod, 1, pch = 19, cex = 0.5, col="#00000010")


## ---------------------------------------------------------------------------------------------------------------------------------
qplot(finMod$fitted, finMod$residuals, color = race, data = training)


## ---------------------------------------------------------------------------------------------------------------------------------
plot(finMod$residuals, pch = 19)


## ---------------------------------------------------------------------------------------------------------------------------------
pred <- predict(modFit, testing)
qplot(wage, pred, color = year, data = testing)


## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------------------
modFitAll <- train(wage ~ ., data = training, method = "lm")
pred <- predict(modFitAll, testing)
qplot(wage, pred, data = testing)

