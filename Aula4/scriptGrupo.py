import pandas as pd
import psutil
import time
import datetime

nome = input("Nome do usuário: ")
dados = {
    "user": nome,
    "timestamp": [],
    "cpu": [],
    "ram": [],
    "disco": [],
}

i = 0
while i < 30:
    dataTempo = datetime.datetime.now()
    cpu = psutil.cpu_percent(percpu = False)
    ram = psutil.virtual_memory()
    disco = psutil.disk_usage('/')

    dados["timestamp"].append(dataTempo.replace(microsecond=0))
    dados["cpu"].append(cpu)
    dados["ram"].append(round(ram.used/10**9, 1))
    dados["disco"].append(round(disco.used/10**9, 1))
    i += 1
    df = pd.DataFrame(dados)
    df.to_csv("scriptGrupo.csv", encoding="utf-8", index=False, sep=';')
    time.sleep(1)
