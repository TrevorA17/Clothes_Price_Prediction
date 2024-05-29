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

# Perform ANOVA
anova_result <- aov(Price ~ Category, data = clothes_data)

# Summary of ANOVA
summary(anova_result)

# Load necessary libraries
library(ggplot2)

# Load dataset
clothes_data <- read.csv("data/clothes_price_prediction_data.csv", colClasses = c(
  Brand = "factor",
  Category = "factor",
  Color = "factor",
  Size = "factor",
  Material = "factor",
  Price = "numeric"
))

# Univariate Plot for Price variable
price_plot <- ggplot(clothes_data, aes(x = Price)) +
  geom_histogram(fill = "skyblue", color = "black", bins = 30) +
  labs(title = "Distribution of Prices", x = "Price", y = "Frequency")

# Univariate Plot for Category variable
category_plot <- ggplot(clothes_data, aes(x = Category)) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(title = "Frequency of Categories", x = "Category", y = "Frequency") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Display univariate plots
price_plot
category_plot
# Load necessary libraries
library(plotly)

# Multivariate Plot (Scatter Plot)
multivariate_plot <- plot_ly(data = clothes_data, x = ~Price, y = ~Category, type = "scatter", mode = "markers",
                             marker = list(color = "rgba(255, 182, 193, 0.7)", size = 10),
                             text = ~paste("Price: $", Price, "<br>Category: ", Category)) %>%
  layout(title = "Price vs. Category", xaxis = list(title = "Price"), yaxis = list(title = "Category"))

# Display multivariate plot
multivariate_plot

