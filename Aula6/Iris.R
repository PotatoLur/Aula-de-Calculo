data("iris")

iris$ID <- 1:nrow(iris) # Variável Discreta

# Criando variável qualitativa nominal
iris$PetalLenthLevel <- factor(
  cut(iris$Petal.Length, breaks = c(0, 2, 5, 7)),
  labels = c("Pequeno", "Médio", "Grande"),
  ordered = TRUE
)

barplot(table(iris$PetalLenthLevel))

barplot(table(iris$Species))
