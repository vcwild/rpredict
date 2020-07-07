## ----setup, include=FALSE---------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------------------------------------------------------------------------------------------------------
library(caret)
library(kernlab)
library(RANN)
data(spam)


## ---------------------------------------------------------------------------------------------------------------------------------
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)
training <- spam[inTrain,]
testing <- spam[-inTrain,]

hist(training$capitalAve, main = "", xlab= "Ave. Capital run length")


## ---------------------------------------------------------------------------------------------------------------------------------
mean(training$capitalAve)


## ---------------------------------------------------------------------------------------------------------------------------------
sd(training$capitalAve)


## ---------------------------------------------------------------------------------------------------------------------------------
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve))/sd(trainCapAve)
mean(trainCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------

testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(testCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------
sd(testCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------
preObj <- preProcess(training[,-58], method = c("center", "scale"))
trainCapAveS <- predict(preObj, training[, -58])$capitalAve
mean(trainCapAveS)

## ---------------------------------------------------------------------------------------------------------------------------------
sd(trainCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------
testCapAveS <- predict(preObj, testing[, -58])$capitalAve
mean(testCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------
sd(testCapAveS)


## ----message=FALSE, warning=FALSE-------------------------------------------------------------------------------------------------
set.seed(323243)
model <- train(type ~ ., data = training, preProcess = c("center", "scale"), method = "glm")
model


## ---------------------------------------------------------------------------------------------------------------------------------
preObj <- preProcess(training[, -58], method = c("BoxCox"))
trainCapAveS <- predict(preObj, training[, -58])$capitalAve
par(mfrow = c(1, 2))
hist(trainCapAveS)
qqnorm(trainCapAveS)


## ---------------------------------------------------------------------------------------------------------------------------------
set.seed(13343)

# Generating NAs to use as example
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size = 1, prob = 0.05) == 1
training$capAve[selectNA] <- NA

# Impute and standardize
preObj <- preProcess(training[, -58], method = "knnImpute")
capAve <- predict(preObj, training[, -58])$capAve

# Standardize true values
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth - mean(capAveTruth)) / sd(capAveTruth)


## ---------------------------------------------------------------------------------------------------------------------------------
quantile(capAve - capAveTruth)


## ---------------------------------------------------------------------------------------------------------------------------------
quantile((capAve - capAveTruth)[selectNA])


## ---------------------------------------------------------------------------------------------------------------------------------
quantile((capAve - capAveTruth)[!selectNA])

