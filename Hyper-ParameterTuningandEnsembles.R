# Load necessary libraries
library(caret)

# Define control parameters for bagging
ctrl_bagging <- trainControl(method = "boot", number = 25)

# Train the bagged model
bagged_model <- train(
  Price ~ .,
  data = clothes_data,
  method = "rf",
  trControl = ctrl_bagging
)

# View bagged model performance
print(bagged_model)

# Define control parameters for boosting
ctrl_boosting <- trainControl(method = "repeatedcv", number = 5, repeats = 5, verboseIter = FALSE)

# Train the boosted model
boosted_model <- train(
  Price ~ .,
  data = clothes_data,
  method = "gbm",
  trControl = ctrl_boosting
)

# View boosted model performance
print(boosted_model)

# Load necessary library for stacking
library(superlearner)

# Define base learner models
base_learners <- list(
  RF = list(method = "rf", tuneGrid = data.frame(mtry = c(2, 4, 6))),
  GBM = list(method = "gbm", tuneGrid = list(n.trees = c(50, 100, 200), interaction.depth = c(2, 3, 4)))
)

# Train the stacked model
stacked_model <- SuperLearner(
  Y = clothes_data$Price,
  X = as.matrix(clothes_data[, -which(names(clothes_data) == "Price")]),
  family = "gaussian",
  method = "method.NNLS",
  SL.library = base_learners
)

# View stacked model performance
print(stacked_model)


