### LIBRARIES ###
import glob
import time
import pandas as pd
import os
from tqdm import tqdm
#from multiprocessing import Pool
import datetime


### PARAMS ###

files_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data\csvs_teste\\"
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



import multiprocessing


def mp_trata_csv(file):
    file = file.replace("\\","/")
    print(f"""\n{f"df_{file.split(r'/')[-1].split('_')[0]}"}\n{file}\n{now}""")
    df = pd.read_csv(file,sep=";", encoding="ANSI", low_memory=True)
    df.drop(["NIS BENEFICIÁRIO","CPF BENEFICIÁRIO","NIS RESPONSÁVEL","CPF RESPONSÁVEL","OBSERVAÇÃO","NOME RESPONSÁVEL","UF","NOME MUNICÍPIO"], axis=1, inplace=True)

    df.rename(columns={
        'MÊS DISPONIBILIZAÇÃO':"disponibilizacao",
        "PARCELA":"parcela",
        'CÓDIGO MUNICÍPIO IBGE':"cod_mun_ibge",
        'NOME BENEFICIÁRIO':"beneficiario",
        'VALOR BENEFÍCIO':"valor",
        "ENQUADRAMENTO":"tipo"},inplace=True)

    df["valor"] = df["valor"].str.replace(",00", "")
    df["valor"] = pd.to_numeric(df["valor"])
    df.fillna(0,inplace=True)
    df["beneficiario"] = df["beneficiario"].str.strip().replace("\\t ", "").replace("\\t", "").replace("?", "")
    df["beneficiario"] = df["beneficiario"].str.split().str.get(0)
    print("\nfim do split")
    df["parcela"] = df["parcela"].str.split("ª").str.get(0)
    df["parcela"] = pd.to_numeric(df["parcela"])
    df = pd.merge(df, dfn, how="left", left_on="beneficiario", right_on="first_name")
    print("\nfim do merge")
    df.drop(["beneficiario", "first_name"], axis=1, inplace=True)
    print("\n fim do drop")
    df["classification"].fillna("I", inplace=True)
    concat_list.append(f"df_{file.split(r'/')[-1].split('_')[0]}")
    df.to_csv(f"{files_path}{file.split(r'/')[-1].split('_')[0]}_AuxEm_Tratado.csv",index=False)
    print(f"Parabéns! Arquivo {file} concluido às {datetime.datetime.now()} e salvo sob o nome {file.split(r'/')[-1].split('_')[0]}_AuxEm_Tratado.csv")


#for var, file in zip(dfs_var_list, tqdm(csv_list)):

if __name__ == "__main__":
    p = multiprocessing.Pool(processes=16)
    start = time.time()
    p.map(mp_trata_csv, glob.glob(files_path+"*.csv"))
    end = time.time()
    print(f"MP concluído em {end - start}")
    p.close()
    p.join()

# print(f"{now} - Concatenando arquivos às {time}")
# one_csv = pd.concat(tqdm(concat_list))
# one_csv.to_csv(f"{files_path}\\ae_20_21_tratado_final.csv", index=False)
# print(f"\n Arquivo final concatenado e salvo com sucesso em {int(end - start)} segundos, às {now}....")

# from multiprocessing import Pool, Manager
# import glob
# import pandas as pd
# from functools import partial
#
# def csv_to_df(lst, fname):
#     lst.append(pd.read_csv(fname))
#
#
# if __name__ == '__main__':
#     dfs_list = Manager().list()
#     pool = Pool(processes=16)
#     files = glob.iglob('*._AuxilioEmergencial.csv')
#     res = pool.map_async(partial(csv_to_df, dfs_list), files)
#     res.wait()
#     dfs = pd.concat(dfs_list, ignore_index=True)  # the final result
#     dfs.to_csv(f"{files_path}\\ae_20_21_tratado_final.csv", index=False)
#     print(dfs)

from multiprocessing import Pool  # for reading the CSVs faster
#
# def readcsv(flnm):
#
#     return pd.read_csv(flnm)
#
#
# def main():
#     file_list = [flnm for flnm in files_dir if csv.endswith("Tratado.csv")]
#
#     with Pool(processes=16) as pool:
#
#     df_list = pool.map(readcsv, file_list)
#     combined_df = pd.concat(df_list, ignore_index=True)
#     combined_df.to_csv(f"{files_path}\\ae_20_21_tratado_final.csv", index=False)
#
# if __name__ == '__main__':
#     main()