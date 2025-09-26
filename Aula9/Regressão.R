df <- data.frame(
  nota = c(4, 9, 7, 3, 9, 5, 8, 1, 10, 2, 9),
  tempo_ia = c(105, 20, 30, 60, 15, 30, 40, 70, 2, 100, 90)
)

cor(df$tempo_ia, df$nota)
plot(df$tempo_ia, df$nota)

regressao <- lm(df$nota ~ df$tempo_ia)
plot(df$tempo_ia, df$nota)
abline(regressao)
