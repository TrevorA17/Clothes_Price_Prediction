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

# Measures of Frequency
frequency_brand <- clothes_data %>% count(Brand)
frequency_category <- clothes_data %>% count(Category)
frequency_color <- clothes_data %>% count(Color)
frequency_size <- clothes_data %>% count(Size)
frequency_material <- clothes_data %>% count(Material)

# Measures of Central Tendency
central_tendency_summary <- summarise(clothes_data, 
                                      mean_price = mean(Price),
                                      median_price = median(Price),
                                      mode_price = as.numeric(names(sort(-table(Price))[1])))

# Measures of Distribution
distribution_summary <- summarise(clothes_data,
                                  min_price = min(Price),
                                  max_price = max(Price),
                                  range_price = max_price - min_price,
                                  sd_price = sd(Price),
                                  quantiles_price = quantile(Price))

# Measures of Relationship (Correlation Matrix)
correlation_matrix <- cor(select(clothes_data, -c(1:5))) # Excluding non-numeric columns

# Display results
frequency_brand
frequency_category
frequency_color
frequency_size
frequency_material
central_tendency_summary
distribution_summary
correlation_matrix