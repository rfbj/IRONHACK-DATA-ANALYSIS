import time
import numpy as np
import pandas as pd
import os
import re
from tqdm import tqdm
from multiprocessing import Pool
import datetime

## PARAMS ###

subs_colnames = ["beneficiario",'disponibilizacao','uf','cod_mun_ibge','municipio',"valor"]
files_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\\"
files_dir = os.listdir(f"{files_path}\\")
csv_list = [csv for csv in files_dir if csv.endswith("Emergencial.csv")]
path2 = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\extra\\"
filename2 = "nomes_2cols.csv"
dfn = pd.read_csv(path2+filename2,sep=";")


dfs_var_list = []
for item in range(len(csv_list)+1):
    dfs_var_list.append(f"df{item}")
concat_list = []


for var, file in zip(dfs_var_list, tqdm(csv_list)):
    start = time.time()
    now = datetime.datetime.now()
    print(f"\n{var}\n{file}\n{now}")
    var = pd.read_csv(files_path+file)
    print("dropei")
    var.drop(["uf","municipio"], axis=1, inplace=True)
    print("splitei")
    var["beneficiario_split"] = var["beneficiario"].str.split().str.get(0)
    var["beneficiario"] = var["beneficiario"].str.strip().replace("\\t ","").replace("\\t","").replace("?","")
    var = pd.merge(var, dfn, how="left", left_on="beneficiario_split", right_on="first_name")
    print("dei merge")
    var.drop(["beneficiario_split","first_name"], axis=1, inplace=True)
    print("dropei")
    var["classification"].fillna("I",inplace=True)
    concat_list.append(var)
    var.to_csv(f"{file}_ok.csv", index=False)
    stop = time.time()
    result = stop -start
    print(f"arquivo {file} concluido em {result}")

print(f"Concatenando arquivos às {time}")
start = time.time()
one_csv = pd.concat(tqdm(concat_list))
one_csv = one_csv.groupby(["disponibilizacao","classification","cod_mun_ibge"],as_index=True)["valor"].sum()
one_csv.to_csv(f"{files_path}\\ae_20_21_tratado_FINAL.csv",index=False)
end = time.time()
print(f"\n Arquivo final gravado com sucesso em {int(end - start)} segundos....")
