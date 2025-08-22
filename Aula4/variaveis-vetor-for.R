# Variáveis
a <- 10 # Setinha é para atribuição. O igual nem sempre pode ser usado, como no if e else
b <- 2
a

if(a < b){ # A linguagem R considera falso como 0. Então if (g <- 2) vai ser verdadeiro
  "teste 1"
}else{
  "teste 2"
}

somar <- function(a, b = 2) { # É possível definir o valor da variável, caso ela não seja definida, ela terá o valor definido
  return(a + b)
}

somar(10)

nomes <- c("Bob", "Tom", "Mel")
nomes[1]

for (nome in nomes) {
  cat(nome , "\n")
}
