### IMPORT LIBRARIES ###

import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.select import Select
import os
import zipfile



### PARAMS ###

files_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio\data"
chrome_path = 'C:/chromedriver'
ser = Service(chrome_path)
prefs = {'download.default_directory': files_path}
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option('prefs', prefs)
driver = webdriver.Chrome(service=ser, options=chrome_options)


url = "https://www.portaltransparencia.gov.br/download-de-dados/auxilio-emergencial"

driver.get(url)  # acessa o site

### DEF ITERABLE ELEMENTS ###

# find_element SINGULAR - Retorna um WEBELEMENT
# find_elements PLURAL - Retorna uma LISTA DO WEBELEMENT

dropd_years = driver.find_element('xpath', '//*[@id="links-anos"]')
selec_dropd_years = Select(dropd_years)
dropd_months = driver.find_element('xpath', '//*[@id="links-meses"]')
selec_dropd_months = Select(dropd_months)
button_dl = driver.find_element('xpath', '//*[@id="btn"]')

### CREATE LISTS TO ITERATE THROUGH WEBELEMENTS ###

years_list = []
months_list = []

for year in selec_dropd_years.options:
    years_list.append(year.text)

for yl in years_list:
    selec_dropd_years.select_by_value(f"{yl}")

    for month in selec_dropd_months.options:
        months_list.append(month.text)

months_list = set(months_list)
months_list = [m.lower() for m in months_list]
months_list = [mon.capitalize() for mon in months_list]

time.sleep(0.5)
print(f"Estes são os meses encontrados no site:\n{months_list}\n")
time.sleep(0.5)
print(f"Estes são os anos encontrados no site:\n{years_list}\n")
time.sleep(0.5)

### DOWNLOAD ZIP FILES ###

def ask_dl():
    question = input("Deseja baixar os arquivos?(S/N)")
    if question == "S" or question == "s" or question == "Y" or question == "y":
        return True
    elif question == "N" or question == "n":
        return False
    else:
        ask_dl()

need_dl = ask_dl()


if need_dl:
    for yr in years_list:
        time.sleep(1)
        selec_dropd_years.select_by_value(f"{yr}")

        for item in months_list:
            try:
                time.sleep(1)
                selec_dropd_months.select_by_visible_text(f"{item}")
                button_dl = driver.find_element('xpath', '//*[@id="btn"]')
                button_dl.click()
            except:
                print(f"O mês {item} não possui dados para o ano {yr}")

print("Usuário optou por não baixar os arquivos\n\n\n")

### START UNZIPPING DOWNLAODED FILES ###
files_in_dir = os.listdir(f"{files_path}\\")
zip_files_in_dir = [zp if zp.endswith(".zip") else "" for zp in files_in_dir] #o remove gera um objeto None
zip_files_list = [file for file in zip_files_in_dir if file != ""] #por isso ele é removido aqui


print("Foram encontrados os seguintes arquivos:")
for file in zip_files_list:
    print(file)

def ask_unzip():
    question2 = input("Deseja descompactar os arquivos?(S/N)")
    if question2 == "S" or question2 == "s" or question2 == "Y" or question2 == "y":
        return True
    elif question2 == "N" or question2 == "n":
        return False
    else:
        ask_unzip()

need_unzip = ask_unzip()

if need_unzip:
    print(f"Extraindo {len(zip_files_list)} arquivos....")
    for file in zip_files_list:
        print(f"Extraindo {file} ..........")
        with zipfile.ZipFile(f'{files_path}\\{file}', "r") as zip_obj:
            zip_obj.extractall(f"{files_path}")

def ask_del_zips():
    question3 = input(f"Deseja deletar os {len(zip_files_list)} arquivos já descompactados?(S/N)")
    if question3 == "S" or question3 == "s" or question3 == "Y" or question3 == "y":
        return True
    elif question3 == "N" or question3 == "n":
        return False
    else:
        ask_del_zips()

need_del_z = ask_del_zips()

if need_del_z:
    print("Iniciando remoção dos arquivos!")
    for file in zip_files_list:
        os.remove(f"{files_path}\\{file}")
        print(f"{file} excluído!")
    print(f"{len(zip_files_list)} arquivos removidos com sucesso!")
else:
    print("Usuário optou por não deletar os arquivos")

