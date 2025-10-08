install.packages(c("readr", "dplyr", "ggplot2", "tidyr", "knitr"))

library(readr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(knitr)

df <- read_csv("ObesityDataSet.csv")

# --- B. Transform: Limpeza, Tratamento e Formatação ---
cat("\nVerificação de valores ausentes (NAs):\n")
print(colSums(is.na(df)))

df_clean <- df %>%
  mutate(
    Height = replace_na(Height, median(Height, na.rm = TRUE)),
    Weight = replace_na(Weight, median(Weight, na.rm = TRUE))
  )

df_clean <- df_clean %>%
  mutate(
    Gender = as.factor(Gender),
    FAVC = as.factor(FAVC),
    SMOK = as.factor(SMOK),
    SCC = as.factor(SCC),
    MTRANS = as.factor(MTRANS),
    NObeyesdad = as.factor(NObeyesdad),
    
    CAEC = factor(CAEC, levels = c("No", "Sometimes", "Frequently", "Always")),
    CALC = factor(CALC, levels = c("No", "Sometimes", "Frequently", "Always"))
  )

# --- C. Load: Data Frame Pronto para Análise ---
cat("\nEstrutura do Data Frame após a limpeza (Amostra de 5 linhas):\n")
print(head(df_clean, 5))
print(str(df_clean))

# --- 3. VISUALIZAÇÕES EXPLORATÓRIAS (EDA) ---
cat("\n--- VISUALIZAÇÕES EXPLORATÓRIAS (EDA) ---\n")

g1 <- ggplot(df_clean, aes(x = NObeyesdad, fill = NObeyesdad)) +
  geom_bar() +
  labs(title = "Distribuição dos Níveis de Obesidade",
       x = "Nível de Obesidade", y = "Contagem") +
  theme_minimal() +
  coord_flip()
print(g1)

g2 <- ggplot(df_clean, aes(x = Height, y = Weight, color = NObeyesdad)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +
  labs(title = "Relação entre Altura e Peso por Nível de Obesidade",
       x = "Altura (m)", y = "Peso (kg)") +
  theme_bw()
print(g2)

g3 <- ggplot(df_clean, aes(x = CAEC, y = Weight, fill = CAEC)) +
  geom_boxplot() +
  labs(title = "Impacto do Consumo Entre Refeições (CAEC) no Peso",
       x = "Frequência de Consumo Extra (CAEC)", y = "Peso (kg)") +
  theme_classic() +
  theme(legend.position = "none")
print(g3)

g4 <- ggplot(df_clean, aes(x = Gender, y = Weight, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Distribuição de Peso por Gênero",
       x = "Gênero", y = "Peso (kg)") +
  theme_light()
print(g4)

# --- 4. APLICAÇÃO DE MODELOS DE REGRESSÃO LINEAR SIMPLES ---
cat("\n--- MODELAGEM DE REGRESSÃO LINEAR SIMPLES ---\n")

modelo_reg_1 <- lm(Weight ~ Height, data = df_clean)
print("\nRESULTADOS: Regressão 1 (Peso ~ Altura)")
print(summary(modelo_reg_1))

modelo_reg_2 <- lm(Weight ~ Age, data = df_clean)
print("\nRESULTADOS: Regressão 2 (Peso ~ Idade)")
print(summary(modelo_reg_2))

modelo_reg_3 <- lm(Weight ~ FAF, data = df_clean)
print("\nRESULTADOS: Regressão 3 (Peso ~ Frequência de Atividade Física - FAF)")
print(summary(modelo_reg_3))

# --- 5. INTERPRETAÇÃO, ANÁLISES E INSIGHTS ---
resultados_regressao <- data.frame(
  Modelo = c("Peso ~ Altura", "Peso ~ Idade", "Peso ~ FAF"),
  R_Quadrado = c(summary(modelo_reg_1)$r.squared,
                 summary(modelo_reg_2)$r.squared,
                 summary(modelo_reg_3)$r.squared),
  Coeficiente_X = c(coef(modelo_reg_1)["Height"],
                    coef(modelo_reg_2)["Age"],
                    coef(modelo_reg_3)["FAF"]),
  Significancia_X = c(summary(modelo_reg_1)$coefficients["Height", "Pr(>|t|)"],
                      summary(modelo_reg_2)$coefficients["Age", "Pr(>|t|)"],
                      summary(modelo_reg_3)$coefficients["FAF", "Pr(>|t|)"])
)

cat("\n--- TABELA RESUMO DOS MODELOS DE REGRESSÃO LINEAR SIMPLES ---\n")
resultados_regressao_formatado <- resultados_regressao %>%
  mutate(
    R_Quadrado = paste0(round(R_Quadrado * 100, 2), "%"),
    Coeficiente_X = round(Coeficiente_X, 2),
    Significancia_X = ifelse(Significancia_X < 0.001, "< 0.001",
                             format(Significancia_X, scientific = FALSE, digits = 3))
  )
print(kable(resultados_regressao_formatado, caption = "Comparativo de Modelos", align = 'c'))

cat("\n--- ANÁLISES E INSIGHTS PARA DECISÃO DE NEGÓCIO ---\n")

cat("\n**1. O DOMÍNIO DA RELAÇÃO BIOLÓGICA (Peso ~ Altura)**\n")
cat(paste("  - **R²:", resultados_regressao_formatado[1, "R_Quadrado"], ".** A Altura é o fator **mais dominante** na variação do Peso.\n"))
cat(paste("  - **Coeficiente (Slope):**", resultados_regressao_formatado[1, "Coeficiente_X"], "kg/m.\n"))
cat("  - **Decisão/Insight:** Confirma a necessidade de usar o **Índice de Massa Corporal (IMC)** em qualquer modelo preditivo de obesidade mais robusto.\n")

cat("\n**2. IDADE É PREDITOR FRACO, MAS SIGNIFICATIVO (Peso ~ Idade)**\n")
cat(paste("  - **R²:", resultados_regressao_formatado[2, "R_Quadrado"], ".** A Idade, sozinha, é uma preditora muito **fraca** do Peso.\n"))
cat(paste("  - **Coeficiente (Slope):**", resultados_regressao_formatado[2, "Coeficiente_X"], "kg/ano.\n"))
cat("  - **Decisão/Insight:** Intervenções de saúde pública devem se concentrar em **mudar comportamentos** (dieta, exercício) em vez de apenas focar no grupo etário.\n")

cat("\n**3. FREQUÊNCIA DE ATIVIDADE FÍSICA (FAF) TEM RELAÇÃO LINEAR NEGATIVA**\n")
faf_coef <- as.numeric(resultados_regressao_formatado[3, "Coeficiente_X"])
cat(paste("  - **R²:", resultados_regressao_formatado[3, "R_Quadrado"], ".** Poder explicativo também baixo.\n"))
cat(paste("  - **Coeficiente (Slope):**", faf_coef, "kg. (Negativo).\n"))
cat("  - **Interpretação:** Para cada aumento de **1 nível** na escala de FAF, o Peso médio esperado **diminui** em cerca de", abs(faf_coef), "kg.\n")
cat("  - **Decisão/Insight:** Programas de saúde devem priorizar a **melhoria da FAF** como uma intervenção de alto impacto comportamental para a redução do peso.\n")

cat("\n**PRÓXIMOS PASSOS:**\n")
cat("A próxima etapa é construir um **Modelo de Regressão Múltipla** para verificar o efeito combinado e isolado de cada variável no Peso.\n")

