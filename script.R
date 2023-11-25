library(MASS)
library(rpart)
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

# Build baseline model, fit it with predicted data, and build confusion matrix
model <- rpart(Target~., data=train_data, method='class')
predict_test <- predict(model, test_data, type='class')
conf_mat <- table(test_data$Target, predict_test)

# Model and data performance measures for baseline model
precision <- conf_mat[1] / sum(conf_mat[1], conf_mat[3])
recall <- conf_mat[1] / sum(conf_mat[1], conf_mat[2])
f1 <- 2 * ((precision * recall) / (precision + recall))
accuracy <- sum(diag(conf_mat)) / sum(conf_mat)

# Plot of the baseline decision tree model
rpart.plot(model, tweak=1.3, cex=0.4)


# Build primary model, fit it with predicted data, and build confusion matrix
model_b <- rpart(Target~., data=train_data, method='class', maxdepth=6)
predict_test_b <- predict(model_b, test_data, type='class')
conf_mat_b <- table(test_data$Target, predict_test_b)

# Model and data performance measures for primary model
precision_b <- conf_mat_b[1] / sum(conf_mat_b[1], conf_mat_b[3])
recall_b <- conf_mat_b[1] / sum(conf_mat_b[1], conf_mat_b[2])
f1_b <- 2 * ((precision_b * recall_b) / (precision_b + recall_b))
accuracy_b <- sum(diag(conf_mat_b)) / sum(conf_mat_b)

# Plot of the primary decision tree model
rpart.plot(model_b, tweak=1.3, cex=0.4)
