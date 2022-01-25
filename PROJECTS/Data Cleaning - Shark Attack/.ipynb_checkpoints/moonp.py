import pandas as pd
import numpy as np
from tqdm import tqdm
import seaborn as sns
import matplotlib as plt
import re
import time
from pandas_profiling import ProfileReport
from datetime import datetime
from bs4 import BeautifulSoup
import dateparser
import requests


with open("gun_da_lua.csv", "a+") as gdl:
    gdl.write(f"New Moon,First Quarter,Full Moon,Third Quarter\n")
    for i in tqdm(range(1800, 2020)):
        content = requests.get(f"https://www.timeanddate.com/moon/phases/?year={i}")
        soup = BeautifulSoup(content.content)
        for line in soup.find_all("tbody")[1].find_all("tr"):
            children = list(line.children)[1::2]
            children = [dateparser.parse(date.text + f' {i}', settings={'STRICT_PARSING': True}) for date in children]
            gdl.write(f'{children[0].isoformat() if children[0] else children[0]},'
                  f'{children[1].isoformat() if children[1] else children[1]},'
                  f'{children[2].isoformat() if children[2] else children[2]},'
                  f'{children[3].isoformat() if children[3] else children[3]}\n')