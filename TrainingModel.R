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