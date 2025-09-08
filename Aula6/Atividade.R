data("Orange")

Orange$tamanho <- factor(
  cut(Orange$circumference, breaks = c(0, 50, 100, 150, 210)),
  labels = c("Pequeno", "Médio", "Grande", "Muito grande"),
  ordered = TRUE
)

Orange$Tree # Variável Nominal

Orange$age # Variável Discreta

Orange$circumference # Variável Contínua

Orange$tamanho # Variável Ordinal

hist(Orange$circumference)
# Com base nas circunferências das laranja, o gráfico mostra a quantidade de laranjas em um certo intervalo de tamanho.

barplot(table(Orange$age))
# Mostra a quantidade de laranjas com base nas idades

barplot(table(Orange$Tree))
# Mostra a quantidade de laranjas com base na árvore

barplot(table(Orange$tamanho))
# Mostra a quantidade de laranjas com base no tamanho
