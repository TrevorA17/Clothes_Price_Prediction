# Load dataset
clothes_data <- read.csv("data/clothes_price_prediction_data.csv", colClasses = c(
  Brand = "factor",
  Category = "factor",
  Color = "factor",
  Size = "factor",
  Material = "factor",
  Price = "numeric"
))

# Display the structure of the dataset
str(clothes_data)

# View the first few rows of the dataset
head(clothes_data)

# View the dataset in a separate viewer window
View(clothes_data)
