populacao <- 200
media <- 25
desvio <- 6

idade <- rnorm(populacao, media, desvio)
hist(idade)

visita <- rpois(8, 30)
visita

cupom <- rbinom(500, 500, 0.45)
cupom

pIdade <- pnorm(20, mean = media, sd = desvio)
pIdade

pCupom <- pbinom(200, 500, 0.45)
pCupom

pVisita <- ppois(25, 30)
pVisita
