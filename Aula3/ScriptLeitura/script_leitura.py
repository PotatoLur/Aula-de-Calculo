import pandas as pd

dados = pd.read_csv("coleta-dos-dados.csv")

cpus = list(dados['cpu'])
rams = list(dados['ram'])
discos = list(dados['disco'])

media = 0
i = 0
while i < len(rams):
    media = media + rams[i]
    i += 1
media = media / len(rams)
print(f"Média de RAM: {round(media, 2)} GB\n")

maior = cpus[0]
i = 1
while i < len(cpus):
    if cpus[i] > maior:
        maior = cpus[i]
    i += 1
print(f"Pico de uso da CPU: {maior}%\n")

minutos = input("Tempo em minutos: ")
medicao = int(minutos) * 6

if medicao > len(discos):
    medicao = len(discos)

soma_disco = 0
i = len(discos) - medicao
while i < len(discos):
    soma_disco = soma_disco + discos[i]
    i += 1

media_disco = soma_disco / medicao
print(f"Média de disco em {minutos} minutos: {round(media_disco, 2)} GB")