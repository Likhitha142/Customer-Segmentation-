# 🛍️ Customer Segmentation using K-Means Clustering

This project performs customer segmentation using machine learning techniques on the **Mall Customer dataset**. It aims to group customers based on their **age**, **annual income**, and **spending score**, helping businesses target marketing strategies more effectively.

## 📌 Objective

The primary goal of this project is to:
- Analyze customer data from a mall.
- Apply **K-Means Clustering** to identify distinct customer segments.
- Use **data visualization** and **dimensionality reduction (PCA)** to interpret the clusters.
- Assist in business decision-making for personalized marketing and customer targeting.

---

## 📁 Dataset

- **Name:** Mall_Customers.csv  
- **Source:** Public dataset for clustering use-cases  
- **Attributes:**
  - `CustomerID` – Unique customer identifier
  - `Gender` – Male/Female
  - `Age` – Age of the customer
  - `Annual Income (k$)` – Annual income in thousands
  - `Spending Score (1-100)` – Score assigned by the mall based on customer behavior

---

## ⚙️ Technologies Used

- **Programming Language:** R
- **Libraries Used:**
  - `ggplot2` – For visualization
  - `cluster` – For silhouette score calculation
  - `factoextra` – For cluster visualization and validation
  - `NbClust` – To determine the optimal number of clusters
  - `plotrix` – For 3D pie charts
  - `purrr` – For functional operations in clustering loop

---

## 🔍 Exploratory Data Analysis (EDA)

The project starts with EDA to understand customer demographics and behavior.

- **Gender Distribution:** Bar plot and 3D pie chart
- **Age Distribution:** Histogram and box plot
- **Annual Income Analysis:** Histogram and density plot
- **Spending Score Analysis:** Histogram and box plot

---

## 🔗 Clustering Process

1. **Feature Selection:** Only `Age`, `Annual Income`, and `Spending Score` were used for clustering.
2. **Elbow Method:** Used to determine the optimal number of clusters by plotting within-cluster sum of squares.
3. **Silhouette Method:** Evaluated quality of clustering for k = 2 to 10.
4. **Gap Statistic:** Another method to confirm optimal k.
5. **K-Means Clustering:** Applied K-means with the selected optimal number of clusters (k=6).
6. **Visualization of Clusters:**
   - Scatter plots of clusters using combinations of features.
   - PCA to visualize clusters in 2D.

---

## 📊 Results

- **6 distinct clusters** were identified based on customer behavior.
- Each cluster represents a customer segment such as:
  - High Income, High Spenders
  - Low Income, High Spenders
  - Young Moderate Spenders, etc.
- These insights can help tailor promotions, loyalty programs, and customer engagement strategies.

---

## 📌 How to Run

1. Download the dataset `Mall_Customers.csv`.
2. Open `customer_segmentation.R` in RStudio or any R environment.
3. Install required packages (if not already installed):
   ```r
   install.packages(c("ggplot2", "cluster", "factoextra", "NbClust", "plotrix", "purrr"))
