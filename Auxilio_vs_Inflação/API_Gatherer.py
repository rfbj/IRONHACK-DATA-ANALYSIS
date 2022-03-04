import time
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.select import Select
from bs4 import BeautifulSoup
import requests
import os
import zipfile



### PARAMS ###
    ## DIRECTORY PARAMS ##

soup = BeautifulSoup()
data_path = "C:\Ironhack\DATA_CLASSES\IRONHACK-DATA-ANALYSIS\PROJECTS\Auxilio_vs_Inflação\data"
chrome_path = 'C:/chromedriver'


    ## SELENIUM PARAMS
# ser = Service(chrome_path)
# prefs = {'download.default_directory': data_path}
# chrome_options = webdriver.ChromeOptions()
# chrome_options.add_experimental_option('prefs', prefs)
# driver = webdriver.Chrome(service=ser, options=chrome_options)


    ## REQUESTS PARAMS
api_url = "https://api.portaldatransparencia.gov.br/api-de-dados/auxilio-emergencial-beneficiario-por-municipio"
response = requests.get(api_url)
#mesAno = 202008 #precisa ser  uma lista
#codigoIbge = 3550308 #precisa ser uma lista com os 5.570 municípios - site: https://www.ibge.gov.br/explica/codigos-dos-municipios.php
pagina = 1

params = {"mesAno":202105, "codigoIbge":14001000,"pagina":1}
headers = {"chave-api-dados": "7e44a488bb29946885b8d1789810b0ea"}

response = requests.get(api_url, params=params, headers=headers)

print(response)
results = response.json()
print(results)
dados = []




