##################################
#### IRONHACK - DATA ANALYSIS ####
####    MANDATORY PROJECT # 1 ####
####                          ####
####       DATA CLEANING      ####
####        SHARK ATTACK      ####
##################################

# LIB IMPORTS
import pandas as pd
import numpy as np
import tqdm
import seaborn as sns
import matplotlib as plt
import re
import time



shark_data = pd.read_csv("data/attacks.csv", encoding="latin1")

start = time.time()
print(shark_data.head(5))
print(shark_data.shape)
shark_data = shark_data[shark_data["Country"] == "USA"]
print(shark_data)
end = time.time()
print(f'Elapsed time: {end - start}')


