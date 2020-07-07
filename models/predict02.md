Train, Test & Predict 02
================

## Setup

``` r
library(caret)
library(kernlab)
set.seed(32323)
data(spam)
```

## Subsets

``` r
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
```

    ## [1] 3451   58

## Return Train

``` r
foldsTrain <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = TRUE)

sapply(foldsTrain, length)
```

    ## Fold01 Fold02 Fold03 Fold04 Fold05 Fold06 Fold07 Fold08 Fold09 Fold10 
    ##   4141   4141   4141   4141   4142   4141   4141   4140   4141   4140

``` r
foldsTrain[[1]][1:10]
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

## Return Test

``` r
foldsTest <- createFolds(y = spam$type, k = 10, list = TRUE, returnTrain = FALSE)

sapply(foldsTest, length)
```

    ## Fold01 Fold02 Fold03 Fold04 Fold05 Fold06 Fold07 Fold08 Fold09 Fold10 
    ##    461    460    460    460    460    461    460    459    460    460

``` r
foldsTest[[1]][1:10]
```

    ##  [1]  19  32  40  50  64  79  90 115 136 139

## Resampling

``` r
foldsRes <- createResample(y = spam$type, times = 10, list = TRUE)
sapply(foldsRes, length)
```

    ## Resample01 Resample02 Resample03 Resample04 Resample05 Resample06 Resample07 
    ##       4601       4601       4601       4601       4601       4601       4601 
    ## Resample08 Resample09 Resample10 
    ##       4601       4601       4601

``` r
foldsRes[[1]][1:10]
```

    ##  [1] 1 2 3 4 4 4 6 6 6 7

## Time Slices

``` r
time <- 1:1000
foldsTime <- createTimeSlices(y = time, initialWindow = 20, horizon = 10) # Windows of 20 samples, predict next 10 samples
names(foldsTime)
```

    ## [1] "train" "test"

``` r
foldsTime$train[[1]]
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

``` r
foldsTime$test[[1]]
```

    ##  [1] 21 22 23 24 25 26 27 28 29 30
