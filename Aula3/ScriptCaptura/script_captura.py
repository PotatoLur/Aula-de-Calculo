import psutil
import pandas as pd
import time
import datetime

dados = {
    "timestamp": [],
    "cpu": [],
    "ram": [],
    "disco": [],
}

i = 0
while i < 3:
    dataTempo = datetime.datetime.now()
    cpu = psutil.cpu_percent(percpu = False)
    ram = psutil.virtual_memory()
    disco = psutil.disk_usage('/')

    dados['timestamp'].append(dataTempo)
    dados['cpu'].append(cpu)
    dados['ram'].append(round(float(ram.used)/1000000000, 2))
    dados['disco'].append((disco.used)/1000000000)
    i += 1
    print(dados)
    time.sleep(10)

df = pd.DataFrame(dados)

df.to_csv("coleta-dos-dados", encoding="utf-8", index=False)