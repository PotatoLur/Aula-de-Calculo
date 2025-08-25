# File -> Import dataset -> From Text (base)
df_grupo <- rbind(captura.carlos, 
                  captura.giuliana,
                  captura.joana, 
                  captura.marina, 
                  captura.rafael)

rm(captura.carlos, 
   captura.giuliana,
   captura.joana, 
   captura.marina, 
   captura.rafael)

mediaCPU <- mean(df_grupo$cpu)
mediaRAM <- mean(df_grupo$ram)
mediaDisco <- mean(df_grupo$disco)

# Exibindo os primeiros registros
head(df_grupo)
# Com número de linhas
head(df_grupo, 10)

# Vendo a estrutura do DF
str(df_grupo)

# Dimensões (linhas x colunas)
dim(df_grupo)

# Lembrando o que são os dados
summary(df_grupo)

# Manipulando um DF: DF[linhas, colunas]
df_grupo[1, 0]
df_grupo[,1]

# Filtrando linhas
df_grupo[df_grupo$cpu > 50,]

# Filtrando colunas
df_grupo[, c('ram', 'cpu')]
mean(df_grupo$ram[df_grupo$user == 'carlos'])

mean(df_grupo$ram[df_grupo$user == 'carlos'])
aggregate(cpu ~ user, data = df_grupo, FUN = mean)
