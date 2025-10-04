#gerando sempre a mesma amostra
set.seed(123)

#total de conveniados
conveniado<- 189000

#amostra
amostragemConveniado<-100000

#calcula quem buscou atendimento e quem não buscou, dentro do total de conveniados
atendimento<- rbinom(conveniado, 1, 0.32)

#selecionando amostra de pessoas que buscaram atendimento
amostragemAtendimento<- sample(atendimento,amostragemConveniado)

#distribuição normal de pessoas com base na media de expectativa de vida brasileira = 35
#https://agenciagov.ebc.com.br/noticias/202408/expectativa-de-vida-sobe-para-76-4-anos-no-brasil-apos-queda-durante-a-pandemia
idadeAmostragem<-abs(round(rnorm(amostragemConveniado,mean=35,20)))  

#historograma das idades
hist(idadeAmostragem,
     main = "Frequência de conveniados")

#Cria um dataFrame da idade respectiva e se houve atendimento
convenioIdade=data.frame(idadeAmostragem,amostragemAtendimento)

#filtra os jovens dentro da amostra entre 7 e 17
jovem<- idadeAmostragem[idadeAmostragem <= 17&idadeAmostragem>=7]
#limita para ordenar as variáveis discretas
Limite <- min(7):max(17)
#ordena as variáveis discrétas
freqJovem <- table(factor(jovem, levels = Limite))

#plota gráfico ordenado por idade
barplot(freqJovem,
        main = "Frequência do conjunto",
        xlab = "X",
        ylab = "Quantidade",
        col = "orange") 

#filtra os jovens dentro da amostra entre 55 e 82
idoso<- idadeAmostragem[idadeAmostragem <= 82&idadeAmostragem>=55]
#Limita a idade
Limite <- min(55):max(82)
#transforma as variáveis discretas em ordenadas
freqIdoso <- table(factor(idoso, levels = Limite))

#plota os gráficos de acordo com a idade
barplot(freqIdoso,
        main = "Frequência do conjunto",
        xlab = "X",
        ylab = "Quantidade",
        col = "orange") 

 
#une a frequencia dos jovens e idosos
freqTotal <-c(freqJovem,freqIdoso)
 
cores <- c(rep("orange", length(freqJovem)),  # cor dos jovens
           rep("blue", length(freqIdoso)))    # cor dos idosos

#plota o gráfico de jovem + idoso
barplot(freqTotal,
        col = cores,
        main = "Frequência de conveniados",
        xlab = "Idade",
        ylab = "Quantidade",
)
 
#listando quantidade de atendimento por idade. 0 = não atendido. 1 = atendido
table(convenioIdade)

#quantos atendimentos teve
nrow(convenioIdade[convenioIdade$amostragemAtendimento==1,])

#jovem total
jovem<-nrow(convenioIdade[convenioIdade$idadeAmostragem <= 17
                                    &convenioIdade$idadeAmostragem >= 7, ])

#quantos jovens na faixa etaria de 7 a 17 foram atendidos
jovensAtendidos<-nrow(convenioIdade[convenioIdade$idadeAmostragem <= 17
                   &convenioIdade$idadeAmostragem >= 7
                   &convenioIdade$amostragemAtendimento==1, ])

#idoso total
idoso<-nrow(convenioIdade[convenioIdade$idadeAmostragem >= 55
                                    &convenioIdade$idadeAmostragem <= 82, ])

#quantos idosos na faixa etaria de 52 e 82 foram atendidos
idososAtendidos<-nrow(convenioIdade[convenioIdade$idadeAmostragem >= 55
                   &convenioIdade$idadeAmostragem <= 82
                   &convenioIdade$amostragemAtendimento==1, ])

#porcentagem de jovens atendidos
percentualJovem<-abs(round(jovensAtendidos/jovem*100)) 
percentualJovem

#porcentagem de idosos atendidos
percentualIdoso<-abs(round(idososAtendidos/idoso*100)) 
percentualIdoso



#Gráfico de frequência de atendimento para as faixas etárias
barplot(c(jovensAtendidos,idososAtendidos),
        col = c("blue","orange"),
        main = "Frequência da atendimento por faixa etária",
        names.arg = c("Jovem", "Idoso"),
        xlab = "Faixa etária",
        ylab = "Quantidade",
        
)
 
#quantidade de jovens e idosos no convenio
barplot(c(jovem,idoso),
        col = c("blue","orange"),
        main = "Frequência da atendimento por faixa etária",
        names.arg = c("Jovem", "Idoso"),
        xlab = "Faixa etária",
        ylab = "Quantidade",
        
)

#----------------------Perguntas---------------------------------------------

#1. Qual a média de idade com maior número de atendimentos médicos?
barplot(freqTotal,
        col = cores,
        main = "Frequência do conjunto",
        xlab = "Faixa etaria",
        ylab = "Quantidade",
)
#Idade com maior número de atendimento
names(freqTotal)[which.max(freqTotal)]

#2. Quais faixas etárias necessitam de maior número de atendimentos médicos? 
faixaEtaria<-factor(cut (idadeAmostragem, breaks=c(7,12,17,55,64,82)),
             labels = c("7-12","13-17","-","55-64","65-82")
             )
faixaEtaria<-faixaEtaria[faixaEtaria!="-"]
barplot(table(faixaEtaria),
        col = "blue",
        main = "Frequência",
        xlab = "Faixa etaria",
        ylab = "Quantidade",
)
#Maior quantidade de atendimento em 55-64  
names(which.max(table(faixaEtaria)))

#3. Qual ala o hospital deve priorizar: jovens ou idosos?
barplot(c(jovensAtendidos,idososAtendidos),
        col = c("blue","orange"),
        main = "Frequência da atendimento por faixa etária",
        names.arg = c("Jovem", "Idoso"),
        xlab = "Faixa etária",
        ylab = "Quantidade",
        
)
#Quantidade de idosos atendidos é maior que a dos jovens, logo idosos precisam ser priorizados


#4. Qual o percentual da ala que precisa ser priorizada?
#porcentagem de idosos atendidos
percentualIdoso<-abs(round(idososAtendidos/idoso*100)) 
percentualIdoso
#32% dos idosos foram atendidos

