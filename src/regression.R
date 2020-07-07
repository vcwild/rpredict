## ----setup, include=FALSE---------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---------------------------------------------------------------------------------------------------------------------------------
library(caret)
data("faithful")


## ---------------------------------------------------------------------------------------------------------------------------------
inTrain <- createDataPartition(y = faithful$waiting, p = 0.5, list = FALSE)
trainFaith <- faithful[inTrain,]
testFaith <- faithful[-inTrain,]
head(trainFaith)


## ---------------------------------------------------------------------------------------------------------------------------------
plot(trainFaith$waiting, trainFaith$eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration")


## ---------------------------------------------------------------------------------------------------------------------------------
lm1 <- lm(eruptions ~ waiting, data = trainFaith)
summary(lm1)$coef


## ---------------------------------------------------------------------------------------------------------------------------------
with(trainFaith, plot(waiting, eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration"))
lines(trainFaith$waiting, lm1$fitted, lwd = 3)



## ---------------------------------------------------------------------------------------------------------------------------------
# Y = b0 + b1 * X
coef(lm1)[1] + coef(lm1)[2] * 80


## ---------------------------------------------------------------------------------------------------------------------------------
newdata <- data.frame(waiting = 80)
predict(lm1, newdata)


## ---------------------------------------------------------------------------------------------------------------------------------
par(mfrow = c(1, 2))
plotVals <- function(df){with(df, plot(waiting, eruptions, pch = 19, col = "blue", xlab = "Waiting", ylab = "Duration"))}
plotVals(trainFaith)
lines(trainFaith$waiting, predict(lm1), lwd = 3)
plotVals(testFaith)
lines(testFaith$waiting, predict(lm1, newdata = testFaith), lwd = 3)


## ---------------------------------------------------------------------------------------------------------------------------------
sqrt(sum((lm1$fitted - trainFaith$eruptions)^2))


## ---------------------------------------------------------------------------------------------------------------------------------
sqrt(sum((predict(lm1, newdata = testFaith) - testFaith$eruptions)^2))


## ---------------------------------------------------------------------------------------------------------------------------------
pred1 <- predict(lm1, newdata = testFaith, interval = "prediction")
ord <- order(testFaith$waiting)

plot(testFaith$waiting, testFaith$eruptions, pch = 19, col = "blue")
matlines(testFaith$waiting[ord], pred1[ord,], type = "l", col = c(1, 2, 2), lty = c(1, 1, 1), lwd = 3)


## ---------------------------------------------------------------------------------------------------------------------------------
modFit <- train(eruptions ~ waiting, data = trainFaith, method = "lm")
summary(modFit$finalModel)$coef

