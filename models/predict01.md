Train, Test & Predict 01
================

## Setup

``` r
library(caret)
library(kernlab)
```

``` r
data(spam)
inTrain <- createDataPartition(y = spam$type, p = 0.75, list = FALSE)

training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
```

    ## [1] 3451   58

``` r
set.seed(32343)
fit <- train(type ~ ., data = training, method = 'glm')
```

``` r
fit
```

    ## Generalized Linear Model 
    ## 
    ## 3451 samples
    ##   57 predictor
    ##    2 classes: 'nonspam', 'spam' 
    ## 
    ## No pre-processing
    ## Resampling: Bootstrapped (25 reps) 
    ## Summary of sample sizes: 3451, 3451, 3451, 3451, 3451, 3451, ... 
    ## Resampling results:
    ## 
    ##   Accuracy   Kappa    
    ##   0.9213416  0.8347084

``` r
fit$finalModel
```

    ## 
    ## Call:  NULL
    ## 
    ## Coefficients:
    ##       (Intercept)               make            address                all  
    ##         -1.513641          -0.619508          -0.155582           0.246344  
    ##             num3d                our               over             remove  
    ##          2.101220           0.460376           1.463063           1.772559  
    ##          internet              order               mail            receive  
    ##          0.487966           0.849257           0.099994          -0.020240  
    ##              will             people             report          addresses  
    ##         -0.113995          -0.096959           0.080087           0.848749  
    ##              free           business              email                you  
    ##          1.210599           1.348302           0.271395           0.055694  
    ##            credit               your               font             num000  
    ##          1.381115           0.226308           0.163806           2.026985  
    ##             money                 hp                hpl             george  
    ##          0.620729          -1.953229          -1.056749          -9.955579  
    ##            num650                lab               labs             telnet  
    ##          0.484253          -3.984181          -0.424851          -0.102319  
    ##            num857               data             num415              num85  
    ##         10.613072          -1.129369         -13.290227          -2.037621  
    ##        technology            num1999              parts                 pm  
    ##          0.675818           0.119669          -0.821482          -1.148112  
    ##            direct                 cs            meeting           original  
    ##         -0.430718         -41.359587          -2.328322          -0.756722  
    ##           project                 re                edu              table  
    ##         -1.676478          -0.717224          -2.173285          -2.682571  
    ##        conference      charSemicolon   charRoundbracket  charSquarebracket  
    ##         -3.830365          -1.382485          -0.706406          -1.080134  
    ##   charExclamation         charDollar           charHash         capitalAve  
    ##          0.245567           5.712794           3.540652           0.017962  
    ##       capitalLong       capitalTotal  
    ##          0.005702           0.001061  
    ## 
    ## Degrees of Freedom: 3450 Total (i.e. Null);  3393 Residual
    ## Null Deviance:       4628 
    ## Residual Deviance: 1329  AIC: 1445

``` r
predictions <- predict(fit, newdata = testing)
summary(predictions)
```

    ## nonspam    spam 
    ##     721     429

``` r
confusionMatrix(predictions, testing$type)
```

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction nonspam spam
    ##    nonspam     664   57
    ##    spam         33  396
    ##                                           
    ##                Accuracy : 0.9217          
    ##                  95% CI : (0.9047, 0.9366)
    ##     No Information Rate : 0.6061          
    ##     P-Value [Acc > NIR] : < 2e-16         
    ##                                           
    ##                   Kappa : 0.8346          
    ##                                           
    ##  Mcnemar's Test P-Value : 0.01533         
    ##                                           
    ##             Sensitivity : 0.9527          
    ##             Specificity : 0.8742          
    ##          Pos Pred Value : 0.9209          
    ##          Neg Pred Value : 0.9231          
    ##              Prevalence : 0.6061          
    ##          Detection Rate : 0.5774          
    ##    Detection Prevalence : 0.6270          
    ##       Balanced Accuracy : 0.9134          
    ##                                           
    ##        'Positive' Class : nonspam         
    ##
