### LIBRARIES ###

import time
import pandas as pd
import os
from tqdm import tqdm
#from multiprocessing import Pool
import datetime


### PARAMS ###

files_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\\"
files_dir = os.listdir(f"{files_path}\\")
path2 = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\extra\\"
filename2 = "nomes_2cols.csv"
dfn = pd.read_csv(path2+filename2,sep=";")

### DEF VARS ###
csv_list = [csv for csv in files_dir if csv.endswith(".csv")]
ano_mes = [csv.split("_")[0] for csv in files_dir if csv.endswith(".csv")]
dfs_var_list = []
concat_list = []
for item in range(len(csv_list)+1):
    dfs_var_list.append(f"df{item}")
start = time.time()
stop = time.time()
now = datetime.datetime.now()

### DATA CLEANING ###

for var, file in zip(dfs_var_list, tqdm(csv_list)):

    print(f"\n{var}\n{file}\n{now}")
    var = pd.read_csv(files_path+file,sep=";", encoding="ANSI")
    var.drop(["NIS BENEFICIÁRIO","CPF BENEFICIÁRIO","NIS RESPONSÁVEL","CPF RESPONSÁVEL","OBSERVAÇÃO","NOME RESPONSÁVEL","UF","NOME MUNICÍPIO"], axis=1, inplace=True)

    var.rename(columns={
        'MÊS DISPONIBILIZAÇÃO':"disponibilizacao",
        "PARCELA":"parcela",
        'CÓDIGO MUNICÍPIO IBGE':"cod_mun_ibge",
        'NOME BENEFICIÁRIO':"beneficiario",
        'VALOR BENEFÍCIO':"valor",
        "ENQUADRAMENTO":"tipo"},inplace=True)

    var["valor"] = var["valor"].str.replace(",00", "")
    var["valor"] = pd.to_numeric(var["valor"])
    var.fillna(0,inplace=True)
    var["beneficiario"] = var["beneficiario"].str.strip().replace("\\t ", "").replace("\\t", "").replace("?", "")
    var["beneficiario"] = var["beneficiario"].str.split().str.get(0)
    print("\nfim do split")
    var["parcela"] = var["parcela"].str.split("ª").str.get(0)
    var["parcela"] = pd.to_numeric(var["parcela"])
    var = pd.merge(var, dfn, how="left", left_on="beneficiario", right_on="first_name")
    print("\nfim do merge")
    var.drop(["beneficiario", "first_name"], axis=1, inplace=True)
    print("\n fim do dropei")
    var["classification"].fillna("I", inplace=True)
    concat_list.append(var)
    var.to_csv(f"{files_path}{file.split('_')[0]}_AuxEm_Tratado.csv",index=False)
    print(f"Parabéns! Arquivo {file} concluido às {now} e salvo sob o nome {file.split('_')[0]}_AuxEm_Tratado.csv")

print(f"{now} - Concatenando arquivos às {time}")
one_csv = pd.concat(tqdm(concat_list))
one_csv.to_csv(f"{files_path}\\ae_20_21_tratado_final.csv", index=False)
print(f"\n Arquivo final concatenado e salvo com sucesso em {int(end - start)} segundos, às {now}....")

