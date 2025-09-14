# Projeto de Simulação de Cenários
# Integrantes: 
# Guilherme Aoki - 04251081
# Igor Cardoso - 04251001
# Lucas Hideo - 04251030

p <- 189000
n <- 20000

set.seed(123)

# Gerando um número aleatório para separar jovens de idosos do total
numeroAleatorio <- round(runif(1, 5000, 11000))
numeroAleatorio

# Crianças
criancas <- round(numeroAleatorio)
idade_criancas <- abs(round(rnorm(criancas, 12, 5)))

# Idades apenas entre 7 e 17 anos.
for (i in 1:length(idade_criancas)) {
  if (idade_criancas[i] < 7 | idade_criancas[i] > 17) {
    idade_criancas[i] <- round(runif(1, 7, 17))
  }
}

# Idosos - Considerando 60% do total
idosos <- round(20000 - numeroAleatorio)
idade_idosos <- abs(round(rnorm(idosos, 69, 14)))

# Idades apenas entre 55 e 82 anos.

for (i in 1:length(idade_idosos)) {
  if (idade_idosos[i] < 55 | idade_idosos[i] > 82) {
    idade_idosos[i] <- round(runif(1, 55, 82))
  }
}


idade <- c(idade_criancas, idade_idosos)
idade

hist(idade_criancas,
     main = "Frequência da idade dos jovens",
     xlab = "Idade",
     ylab = "Frequência",
     col = "darkblue")

hist(idade_idosos,
     main = "Frequência da idade dos idosos",
     xlab = "Idade",
     ylab = "Frequência",
     col = "lightblue")

hist(idade,
     main = "Frequência das idades",
     xlab = "Idade",
     ylab = "Frequência",
     col = "green")


faixa_etaria <- cut(idade, 
                    breaks = c(6, 17, 54, 82),
                    labels = c("7-17", "-", "55-82"),
                    ordered = TRUE)
barplot(table(faixa_etaria))


conveniado <- rbinom(n, 1, 0.32)
conveniado
atendimento <- data.frame(conveniado, idade)


frequencia <- table(idade)
frequencia_crianca <- table(idade_criancas)
frequencia_idoso <- table(idade_idosos)
max_frequencia_total <- as.numeric(names(which.max(frequencia)))
max_frequencia_crianca <- as.numeric(names(which.max(frequencia_crianca)))
max_frequencia_idoso <- as.numeric(names(which.max(frequencia_idoso)))

max_frequencia_total
max_frequencia_crianca
max_frequencia_idoso

