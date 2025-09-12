p <- 200000
n <- 20000

set.seed(123)
idade <- abs(round(rnorm(n, 37, 7)))
idade

hist(idade)
plot(idade)


altura <- abs(round(rnorm(n, 1.50, 0.25),2))
altura

peso <- abs(round(rnorm(n, 55, 4),2))
peso

imc <- round(peso/(altura*altura),2)
imc

salario <- abs(round(rnorm(n, 3000.0, 400),2))
salario

carro_pop <- rep(0:3, length = p)
carro_pop

carro <- sample(carro_pop, n)
carro
barplot(table(carro))
rm(carro_pop)

filho_pop <- rep(0:2, length = p)
filho <- sample(filho_pop, n)
filho
rm(filho_pop)
barplot(table(filho))


escolaridade_pop <- rep(0:6, length = p)
escolaridade_temp <- sample(escolaridade_pop)
escolaridade <- factor(escolaridade_temp, 
                       levels = c(0:6),
                       labels = c(
                         "Analfabeto",
                         "1° grau",
                         "2° grau",
                         "3° grau",
                         "Mestrado",
                         "Doutorado",
                         "Pós Doutorado"
                       ),
                       ordered = TRUE)
escolaridade
levels(escolaridade)
as.numeric(escolaridade)

rm(escolaridade_pop)
rm(escolaridade_temp)

fumante_temp <- rbinom(n, 1, 0.4)
fumante_temp
barplot(table(fumante_temp))

fumante <- factor(fumante_temp,
                  levels = c(0:1),
                  labels = c("Não fumante", "Fumante"),
                  ordered = TRUE)
fumante

sexo_pop <- rep(0:1, length = p)
sexo_temp <- sample(sexo_pop)

sexo <- factor(sexo_temp,
                  levels = c(0:1),
                  labels = c("Masculino", "Feminino"),
                  ordered = FALSE)
sexo

profissao_pop <- rep(0:2, length = p)
profissao_temp <- sample(profissao_pop)
profissao <- factor(profissao_temp, 
                       levels = c(0:2),
                       labels = c(
                         "Professor",
                         "Engenheiro",
                         "Advogado"
                       ),
                       ordered = TRUE)
profissao

df_imc <- data.frame(
  altura,
  carro,
  escolaridade,
  filho,
  fumante,
  idade,
  imc,
  peso,
  salario
)

write.table(df_imc, file = "~/Documentos/Dados-legais-de-IMC.csb", sep = ";")
