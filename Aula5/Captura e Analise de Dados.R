process <- processos
recursos <- scriptGrupo

# É necessário filtrar alguns dados irrelevantes?
# Sim muitas informações dos processos do psutil.process_iter poderiam 
# ser irrelevantes para uma análise de apenas CPU, memória, disco e 
# Swap. Por isso foi simplificado para puxar apenas alguns dados

# É preciso formatar algum campo?
# Os campos analisados já foram formatados no script em python, para 
# facilitar a leitura

# Juntar todos os dados em um único CSV ou manter separados?
# Por terem colunas muito diferentes sobre os processos, eles foram 
# mantidos em arquivos CSV separados.

process$status
recursos$cpu
recursos$ram
recursos$disco

mediaCPU <- mean(recursos$cpu)
mediaRAM <- mean(recursos$ram)
mediaDisco <- mean(recursos$disco)
