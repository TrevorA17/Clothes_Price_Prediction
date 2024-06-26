# Load necessary library
library(caTools) # For sample.split function

# Load dataset
clothes_data <- read.csv("data/clothes_price_prediction_data.csv", colClasses = c(
  Brand = "factor",
  Category = "factor",
  Color = "factor",
  Size = "factor",
  Material = "factor",
  Price = "numeric"
))

# Split the dataset into training and testing sets
set.seed(123) # For reproducibility
split <- sample.split(clothes_data$Price, SplitRatio = 0.7)
train_data <- subset(clothes_data, split == TRUE)
test_data <- subset(clothes_data, split == FALSE)

dim(train_data)
dim(test_data)

# Load necessary library
library(boot)

# Define function for bootstrapping
bootstrap_func <- function(data, indices) {
  sampled_data <- data[indices, ]
  # Perform your analysis or modeling here
  # For example, you can fit a linear model:
  lm_model <- lm(Price ~ ., data = sampled_data)
  # Then return the parameters you're interested in
  return(coef(lm_model))
}

# Perform bootstrapping
boot_results <- boot(data = clothes_data, statistic = bootstrap_func, R = 1000)

# View bootstrap results
print(boot_results)

# Load necessary library
library(caret)

# Define cross-validation method
control <- trainControl(method = "cv", number = 10) # 10-fold cross-validation

# Train the model using cross-validation
# For example, let's say you want to train a linear regression model
model <- train(Price ~ ., data = clothes_data, method = "lm", trControl = control)

# View model results
print(model)

# Load necessary library (if not already loaded)
library(caret)

# Define cross-validation method
control <- trainControl(method = "cv", number = 10) # 10-fold cross-validation

# Train the linear regression model using cross-validation
lm_model <- train(Price ~ ., data = clothes_data, method = "lm", trControl = control)

# View model results
print(lm_model)

# Load necessary library (if not already loaded)
library(randomForest)

# Train the random forest regression model
rf_model <- randomForest(Price ~ ., data = clothes_data)

# View model results
print(rf_model)

# Load necessary library (if not already loaded)
library(gbm)

# Train the gradient boosting regression model
gbm_model <- gbm(Price ~ ., data = clothes_data, n.trees = 100, interaction.depth = 4)

# View model results
print(gbm_model)

# Load necessary libraries
library(caret)
library(randomForest)
library(gbm)

# Define cross-validation method
control <- trainControl(method = "cv", number = 10) # 10-fold cross-validation

# Define models
models <- list(
  lm = train(Price ~ ., data = clothes_data, method = "lm", trControl = control),
  rf = train(Price ~ ., data = clothes_data, method = "rf", trControl = control),
  gbm = train(Price ~ ., data = clothes_data, method = "gbm", trControl = control)
)

# Compare model performance using resamples
model_resamples <- resamples(models)

# Summarize model performance
summary(model_resamples)

# Plot model performance
dotplot(model_resamples)
