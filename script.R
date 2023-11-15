library(MASS)
library(rpart.plot)
library(tidymodels)
library(tidyr)
library(readr)

# Read in data from chosen csv into master
master <- read_csv(file.choose())

# Remove unnecessary features and categorize Target variable
master_u <- subset(master, select=-c(1,2,10))
master_u$Target <- as.factor(master_u$Target)

# Convert Type variable to numeric
master_u$Type[master_u$Type=='L'] <- 0
master_u$Type[master_u$Type=='M'] <- 1
master_u$Type[master_u$Type=='H'] <- 2
master_u$Type <- as.numeric(master_u$Type)

# set random seed and split data into training and testing sets
set.seed(4893175)
data_split <- initial_split(master_u, prop=0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# Build model, fit it with predicted data, and build confusion matrix
model <- rpart(Target~., data=train_data, method='class', minsplit=2)
predict_test <- predict(model, test_data, type='class')
conf_mat <- table(test_data$Target, predict_test)

# Model and data performance measures
precision <- conf_mat[2,2]/sum(conf_mat[2,])
recall <- conf_mat[2,2]/sum(conf_mat[,2])
specificity <- conf_mat[1] / sum(conf_mat[1], conf_mat[2])
f1 <- 2 * ((precision * recall) / (precision + recall))
accuracy <- sum(conf_mat[1], conf_mat[4]) / sum(conf_mat[1:4])

# Plot of the decision tree model
rpart.plot(model, tweak=1.3)
