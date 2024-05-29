# Load the saved Linear Regression model
loaded_lm_model <- readRDS("./models/saved_lm_model.rds")

#* @apiTitle Clothes Price Prediction Model API
#* @apiDescription Used to predict clothes prices.

#* @param Brand Brand of the clothes
#* @param Category Category of the clothes
#* @param Color Color of the clothes
#* @param Size Size of the clothes
#* @param Material Material of the clothes

#* @get /clothes_price_prediction
predict_clothes_price <- function(Brand, Category, Color, Size, Material) {
  
  # Create a data frame using the arguments
  new_data <- data.frame(
    Brand = as.factor(Brand),
    Category = as.factor(Category),
    Color = as.factor(Color),
    Size = as.factor(Size),
    Material = as.factor(Material)
  )
  
  # Use the loaded model to make predictions
  prediction <- predict(loaded_lm_model, newdata = new_data)
  
  # Return the prediction
  return(prediction)
}
