import psutil
import math

def datetime(segundos):
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

cpu = psutil.cpu_times(percpu = False)
cpu_tempo = datetime(float(cpu.user))
print("-----------------------CPU-----------------------")
print(f"Tempo de utilização: {(cpu_tempo)}")
for i in range(len(psutil.cpu_percent(interval = 1, percpu=True))):
    print(f"Porcentagem de uso da CPU {i+1}: {psutil.cpu_percent(interval = 1)}%.")

print("\n---------------------Memória---------------------")
memory = psutil.virtual_memory()
print(f"Memória total: {round(float(memory.total)/1000000000, 2)} Gb.")
print(f"Memória sendo utilizada: {round(float(memory.used)/1000000000, 2)} Gb.")
print(f"Memória utilizada: {round(float(memory.percent), 2)}%.")

# discPart = psutil.disk_partitions()
# print(discPart)

# discUsage = psutil.disk_usage('/')
# print(discUsage)