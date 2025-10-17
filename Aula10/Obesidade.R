install.packages("ggplot2")
library(ggplot2)

data <- read.csv("ObesityDataSet.csv")

# Correlação 1: Weight e Height
corr_wh <- cor(data$Weight, data$Height, use = "complete.obs")
corr_wh

# Correlação 2: Weight e Age
corr_aw <- cor(data$Weight, data$Age, use = "complete.obs")
corr_aw

# Correlação 3: FAF e TUE
corr_ft <- cor(data$FAF, data$TUE, use = "complete.obs")
corr_ft

# Gráfico 1: Weight e Height
plot_1 <- ggplot(data, aes(x = Height, y = Weight)) +
  geom_point(alpha = 0.6, color = "darkgrey") + 
  geom_smooth(method = "lm", color = "blue", se = FALSE) + 
  labs(title = "Regressão: Weight vs. Height",
       x = "Height",
       y = "Weight") +
  theme_minimal()
print(plot_1)


# Gráfico 2: Weight e Age
plot_2 <- ggplot(data, aes(x = Age, y = Weight)) +
  geom_point(alpha = 0.6, color = "darkgrey") +
  geom_smooth(method = "lm", color = "red", se = FALSE) +
  labs(title = "Regressão: Weight vs. Age",
       x = "Age",
       y = "Weight") +
  theme_minimal()
print(plot_2)


# Gráfico 3: FAF e TUE
plot_3 <- ggplot(data, aes(x = FAF, y = TUE)) +
  geom_point(alpha = 0.6, color = "darkgrey") +
  geom_smooth(method = "lm", color = "darkgreen", se = FALSE) +
  labs(title = "Regressão: FAF vs. TUE",
       x = "FAF",
       y = "TUE") +
  theme_minimal()
print(plot_3)
