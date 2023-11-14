library(MASS)
library(rpart.plot)
library(tidymodels)
library(tidyr)
library(readr)

master <- read_csv(file.choose())

master_u <- subset(master, select=-c(1,2,10))
master_u$Target <- as.factor(master_u$Target)

master_u$Type[master_u$Type=='L'] <- 0
master_u$Type[master_u$Type=='M'] <- 1
master_u$Type[master_u$Type=='H'] <- 2
master_u$Type <- as.numeric(master_u$Type)

set.seed(5426466)
data_split <- initial_split(master_u, prop=0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

model <- rpart(Target~., data=train_data, method='class')
predict_test <- predict(model, test_data, type='class')
conf_mat <- table(test_data$Target, predict_test)

precision <- conf_mat[2,2]/sum(conf_mat[2,])
recall <- conf_mat[2,2]/sum(conf_mat[,2])

rpart.plot(model)
