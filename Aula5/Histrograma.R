hist(df_grupo$disco,
     main = "Histograma de uso de disco",
     xlab = "Disco",
     ylab = "Frequência",
     col = 'skyblue',
     border = FALSE)

df_grupo[which.max(df_grupo$cpu),]
df_grupo[which.max(df_grupo$ram),]
