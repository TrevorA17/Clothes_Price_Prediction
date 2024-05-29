# Load necessary library
library(dplyr)

# Load dataset
clothes_data <- read.csv("data/clothes_price_prediction_data.csv", colClasses = c(
  Brand = "factor",
  Category = "factor",
  Color = "factor",
  Size = "factor",
  Material = "factor",
  Price = "numeric"
))

# Check for missing values
missing_values <- colSums(is.na(clothes_data))

# Print the count of missing values
print(missing_values)
