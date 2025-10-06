install.packages(c("readr", "dplyr", "ggplot2", "tidyr"))

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)

df <- read_csv("Obesity_Dataset.csv")

df_clean <- df %>%
  mutate(
    Gender = as.factor(Gender),
    FAVC = as.factor(FAVC),  # Consumo frequente de alimentos calóricos
    SMOK = as.factor(SMOK),
    SCC = as.factor(SCC),    # Monitoramento de calorias
    MTRANS = as.factor(MTRANS), # Meio de transporte
    NObeyesdad = as.factor(NObeyesdad), # Variável Alvo
    
    CAEC = factor(CAEC, levels = c("No", "Sometimes", "Frequently", "Always")),
    CALC = factor(CALC, levels = c("No", "Sometimes", "Frequently", "Always"))
  )

g1 <- ggplot(df_clean, aes(x = NObeyesdad, fill = NObeyesdad)) +
  geom_bar() +
  labs(title = "Distribuição dos Níveis de Obesidade", x = "Nível de Obesidade", y = "Contagem") +
  theme_minimal() +
  coord_flip()
print(g1)

g2 <- ggplot(df_clean, aes(x = Height, y = Weight, color = NObeyesdad)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
  labs(title = "Relação entre Altura e Peso", x = "Altura (m)", y = "Peso (kg)") +
  theme_bw()
print(g2)

g3 <- ggplot(df_clean, aes(x = CAEC, y = Weight, fill = CAEC)) +
  geom_boxplot() +
  labs(title = "Impacto do Consumo Entre Refeições (CAEC) no Peso",
       x = "Frequência de Consumo Extra", y = "Peso (kg)") +
  theme_classic() +
  theme(legend.position = "none")
print(g3)

modelo_reg_1 <- lm(Weight ~ Height, data = df_clean)

print("\nRESULTADOS: Regressão 1 (Peso ~ Altura)")
summary(modelo_reg_1)

r_squared_1 <- summary(modelo_reg_1)$r.squared
coef_height_1 <- coef(modelo_reg_1)["Height"]
p_value_height_1 <- summary(modelo_reg_1)$coefficients["Height", "Pr(>|t|)"]

cat("\n**ASSIMILAÇÃO 1: Peso (Y) vs. Altura (X)**\n")
cat(paste("   - **Poder Explicativo (R²):**", round(r_squared_1, 4) * 100, "%"))
cat(paste("\n     Este percentual da variação do Peso é explicado pela Altura. É um valor robusto, esperado devido à correlação biológica entre as variáveis."))

cat(paste("\n   - **Coeficiente da Altura (Slope):**", round(coef_height_1, 2)))
cat(paste("\n     Para cada aumento de **1 metro** (100 cm) na Altura, o Peso médio do indivíduo aumenta em **", round(coef_height_1, 2), " kg**."))
cat(paste("\n     O p-valor (", format(p_value_height_1, scientific = FALSE, digits = 3), ") é altamente significativo (< 0.05), confirmando a relevância da Altura."))
cat("\n   - **Decisão/Insight:** A forte relação confirma que Peso e Altura são inseparáveis na análise de obesidade, justificando o uso do IMC (Índice de Massa Corporal).\n")

modelo_reg_2 <- lm(Weight ~ Age, data = df_clean)

print("\nRESULTADOS: Regressão 2 (Peso ~ Idade)")
summary(modelo_reg_2)

r_squared_2 <- summary(modelo_reg_2)$r.squared
coef_age_2 <- coef(modelo_reg_2)["Age"]
p_value_age_2 <- summary(modelo_reg_2)$coefficients["Age", "Pr(>|t|)"]

cat("\n**ASSIMILAÇÃO 2: Peso (Y) vs. Idade (X)**\n")
cat(paste("   - **Poder Explicativo (R²):**", round(r_squared_2, 4) * 100, "%"))
cat(paste("\n     Este valor de R² é muito mais baixo que o anterior. A Idade, sozinha, é uma preditora muito **fraca** do Peso."))

cat(paste("\n   - **Coeficiente da Idade (Slope):**", round(coef_age_2, 2)))
cat(paste("\n     Para cada aumento de **1 ano** na Idade, o Peso médio esperado aumenta em **", round(coef_age_2, 2), " kg**."))
cat(paste("\n     O p-valor (", format(p_value_age_2, scientific = FALSE, digits = 3), ") ainda pode ser significativo (< 0.05), mas o efeito prático (R²) é pequeno."))
cat("\n   - **Decisão/Insight:** Embora o efeito seja estatisticamente detectável (peso tende a subir com a idade), a Idade **não é o fator dominante** na determinação do Peso. Fatores como dieta (FAVC, CAEC) e atividade física (FAF) provavelmente têm maior impacto prático (o que sugere a necessidade de uma Regressão Múltipla).\n")

cat("\n**OUTRAS POSSIBILIDADES DE REGRESSÃO LINEAR SIMPLES:**\n")
cat("1. **Weight ~ FAF (Frequência de Atividade Física):** Investigar se a quantidade de exercício (variável numérica) tem uma relação linear direta com o Peso.\n")
cat("2. **Weight ~ CH2O (Consumo de Água):** Verificar se o maior consumo de água (variável numérica) está linearmente associado a um Peso mais baixo (Slope negativo).\n")
cat("3. **Weight ~ TUE (Tempo de Uso de Tecnologia):** Verificar se o tempo de tela/tecnologia (sedentarismo) tem uma relação linear positiva com o Peso.\n")
