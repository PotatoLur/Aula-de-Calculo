set.seed(1234)

media <- 35
desvio <- 15

prob <- pnorm(20, mean = media, sd = desvio)

idade <- abs(round(rnorm(500, media, desvio)))
idade

hist(idade)
