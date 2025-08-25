import pandas as pd
import psutil
import time
import datetime

processos = {
    "pid": [],
    "nome": [],
    "status": []
}

process = psutil.process_iter(['pid', 'name', 'status'])
for proc in process:
    processos["pid"].append(proc.pid)
    processos["nome"].append(proc.name())
    processos["status"].append(proc.status())

df = pd.DataFrame(processos)
df.to_csv("processos.csv", encoding="utf-8", index=False, sep=';')

nome = "Guilherme"
dados = {
    "user": nome,
    "timestamp": [],
    "cpu": [],
    "ram": [],
    "disco": [],
    "swap": []
}

i = 0
while i < 280:
    dataTempo = datetime.datetime.now()
    cpu = psutil.cpu_percent(percpu = False)
    ram = psutil.virtual_memory()
    disco = psutil.disk_usage('/')
    swap = psutil.swap_memory()

    dados["timestamp"].append(dataTempo.replace(microsecond=0))
    dados["cpu"].append(cpu)
    dados["ram"].append(round(ram.used/10**9, 1))
    dados["disco"].append(round(disco.used/10**9, 1))
    dados["swap"].append(round(swap.free/10**9, 1))
    i += 1
    df = pd.DataFrame(dados)
    df.to_csv("scriptGrupo.csv", encoding="utf-8", index=False, sep=';')
    time.sleep(1)
