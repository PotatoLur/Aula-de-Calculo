peso=c(60,55,70,45,80,35,65,50,75,40,85,30,60,55,70,45,80)
genero=c('m','f','m','f','m','f','m','f','m','f','m','f','m','f','m','f','m')
idade=c(25,40,55,35,60,20,45,30,50,25,65,18,40,35,55,40,60)
altura=c(175,165,180,160,185,155,170,165,180,160,185,155,175,165,180,160,185)

dfoo = data.frame(peso, genero, idade, altura)

cor(dfoo$peso, dfoo$idade)
regressao <- lm(dfoo$idade ~ dfoo$peso)
plot(dfoo$peso, dfoo$idade)
abline(regressao)
