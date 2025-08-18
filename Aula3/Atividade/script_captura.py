import psutil
import pandas as pd
import time
import datetime
import math

def horaMinutoSegundo(segundos):
    tempo = ""
    if segundos/3600 >= 1:
        tempo = str(math.floor(segundos/3600)) + ':'
    else:
        tempo = "00:"
    if segundos/60 >= 1:
        if segundos/3600 >= 1:
            print(segundos%3600/60)
            tempo += str(math.floor(segundos%3600/60)) + ':'
        else:
            tempo += str(math.floor(segundos/60)) + ':'
    tempo += str(math.floor(segundos%3600%60))
    return tempo

dados = {
    "timestamp": [],
    "cpu": [],
    "ram": [],
    "disco": [],
}

i = 0
while i < 3:
    dataTempo = datetime.datetime.now()
    cpu = psutil.cpu_times(percpu = False)
    cpu_tempo = horaMinutoSegundo(float(cpu.user))
    ram = psutil.virtual_memory()

    dados['timestamp'].append(dataTempo)
    dados['cpu'].append(cpu_tempo)
    dados['ram'].append(round(float(ram.used)/1000000000, 2))
    dados['disco'].append(i)
    i += 1
    time.sleep(10)

df = pd.DataFrame(dados)

print(df)

# df.to_csv("coleta-dos-dados", encoding="utf-8", index=False)