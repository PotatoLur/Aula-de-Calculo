import pandas as pd

dados = {
    "nome": ["bob", "tom", "mel"],
    "idade": [10, 42, 19]
}

df = pd.DataFrame(dados)

print(type(dados))
print(type(df))

df.to_csv("dados-usuarios.csv", encoding="utf-8", index=False)
