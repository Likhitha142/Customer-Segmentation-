# 📦 Load necessary libraries
library(ggplot2)
library(cluster)
library(plotrix)
library(factoextra)
library(NbClust)
library(purrr)
library(gridExtra)
library(grid)

# 📂 Load the dataset
customer_data <- read.csv("Mall_Customers.csv", header = TRUE)
str(customer_data)
names(customer_data)
head(customer_data)

# 📊 Summary Statistics
summary(customer_data$Age)
sd(customer_data$Age)
summary(customer_data$Annual.Income..k..)
sd(customer_data$Annual.Income..k..)
summary(customer_data$Spending.Score..1.100.)
sd(customer_data$Spending.Score..1.100.)

# 🧍‍♂️ Gender Distribution
gender_table <- table(customer_data$Gender)
barplot(gender_table,
        main = "Gender Comparison",
        xlab = "Gender",
        ylab = "Count",
        col = rainbow(2),
        legend = rownames(gender_table))

# 🎯 3D Pie Chart
pct <- round(gender_table / sum(gender_table) * 100)
labels <- paste(names(gender_table), " ", pct, "%", sep = "")
pie3D(gender_table, labels = labels, main = "Gender Ratio")

# 📈 Age Distribution
hist(customer_data$Age,
     col = "blue",
     main = "Age Distribution",
     xlab = "Age",
     ylab = "Frequency",
     labels = TRUE)

boxplot(customer_data$Age,
        col = "#ff0066",
        main = "Boxplot of Age")

# 💰 Annual Income Analysis
hist(customer_data$Annual.Income..k..,
     col = "#660033",
     main = "Annual Income Distribution",
     xlab = "Income (k$)",
     ylab = "Frequency",
     labels = TRUE)

plot(density(customer_data$Annual.Income..k..),
     col = "blue",
     main = "Annual Income Density")
polygon(density(customer_data$Annual.Income..k..),
        col = "#ccff66")

# 💳 Spending Score Analysis
boxplot(customer_data$Spending.Score..1.100.,
        horizontal = TRUE,
        col = "#990000",
        main = "Boxplot of Spending Score")

hist(customer_data$Spending.Score..1.100.,
     col = "#6600cc",
     main = "Spending Score Distribution",
     xlab = "Spending Score",
     ylab = "Frequency",
     labels = TRUE)

# ⚙️ K-Means Elbow Method
iss <- function(k) {
  kmeans(customer_data[, 3:5], k, iter.max = 100, nstart = 100, algorithm = "Lloyd")$tot.withinss
}

k.values <- 1:10
iss_values <- map_dbl(k.values, iss)

plot(k.values, iss_values, type = "b", pch = 19,
     xlab = "Number of Clusters K",
     ylab = "Total Within-Cluster SS")

# 📏 Silhouette Method
for (k in 2:10) {
  km <- kmeans(customer_data[, 3:5], k, iter.max = 100, nstart = 50)
  plot(silhouette(km$cluster, dist(customer_data[, 3:5], "euclidean")),
       main = paste("Silhouette plot for k =", k))
}

# 📊 Determine Optimal Clusters
fviz_nbclust(customer_data[, 3:5], kmeans, method = "silhouette")

# 📈 Gap Statistic Method
set.seed(125)
gap_stat <- clusGap(customer_data[, 3:5], FUN = kmeans, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

# ✅ Final K-Means Model
set.seed(123)
final_kmeans <- kmeans(customer_data[, 3:5], centers = 6, iter.max = 100, nstart = 50)
customer_data$Cluster <- as.factor(final_kmeans$cluster)

# 🎨 Cluster Visualization
ggplot(customer_data, aes(x = Annual.Income..k.., y = Spending.Score..1.100.)) +
  geom_point(aes(color = Cluster), size = 3) +
  scale_color_discrete(name = "Cluster") +
  ggtitle("Customer Segmentation by Income vs Spending Score")

ggplot(customer_data, aes(x = Spending.Score..1.100., y = Age)) +
  geom_point(aes(color = Cluster), size = 3) +
  scale_color_discrete(name = "Cluster") +
  ggtitle("Customer Segmentation by Spending Score vs Age")

# 🧬 PCA for 2D Visualization
pca_result <- prcomp(customer_data[, 3:5], scale = FALSE)
plot(pca_result$x[, 1:2],
     col = rainbow(6)[as.numeric(customer_data$Cluster)],
     pch = 19,
     xlab = "PC1", ylab = "PC2",
     main = "Clusters Visualized Using PCA")
legend("bottomleft", legend = paste("Cluster", 1:6),
       fill = rainbow(6), cex = 0.8)
