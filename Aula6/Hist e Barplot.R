clientes <- data.frame(
  nome = c("Bob", "Tom", "Ana", "Mel", "Dan"), # Variável Nominal
  idade = c(20, 30, 22, 42, 37), # Variável Discreta
  salario = c(6534.5, 2145.5, 7821.1, 966.4, 3254.1), # Variável Contínua
  plano = factor( # Variável Ordinal
    c("Ouro", "Prata", "Ouro", "Bronze", "Prata"),
    levels = c("Bronze", "Prata", "Ouro"),
    ordered = TRUE
  ),
  area = factor(
    c("Humanas", "Biológicas", "Exatas", "Biológicas", "Humanas"),
    levels = c("Humanas", "Biológicas", "Exatas"),
    ordered = FALSE
  )
)

clientes$plano

clientes$area

hist(clientes$salario)

barplot(table(clientes$plano))
