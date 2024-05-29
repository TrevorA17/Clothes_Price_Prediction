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
