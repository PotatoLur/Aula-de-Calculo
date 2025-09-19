data <- ac1.cco.b

barplot(table(data$V3),
        main = "Distribuição de notas")
data <- data[-1]
data$nota <- gsub(",", ".", data$V3)
data$nota <- trimws(data$nota)
data$nota <- as.numeric(data$nota)
data$nota[-1]
hist(data$nota)
barplot(table(data$nota))
